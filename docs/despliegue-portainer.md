# Despliegue automático en Portainer

Cada push a la rama **`despliegue`** publica la web en el servidor de Portainer, sin tocar nada a mano.

```
push a "despliegue"
   └─▶ GitHub Actions construye la imagen Docker (Maven + Tomcat)
         └─▶ la publica en ghcr.io/porcoborracho/shamchester:despliegue
               └─▶ Portainer detecta el cambio, descarga la imagen y reinicia el contenedor
```

Archivos que intervienen:

| Archivo | Para qué sirve |
|---|---|
| `Dockerfile` | Compila el WAR y lo monta en Tomcat 10.1 con Java 21 |
| `.dockerignore` | Evita que `.env`, `target/` o `logs/` entren en la imagen |
| `.github/workflows/despliegue.yml` | Construye y publica la imagen en cada push a `despliegue` |
| `docker-compose.yml` | El stack que despliega Portainer |
| `portainer.env.example` | Plantilla de las variables que hay que rellenar en Portainer |
| `src/.../config/Env.java` | Lee la configuración de las variables del contenedor (no hay `.env` en Docker) |

---

## 1. Crear la rama `despliegue` (IntelliJ)

1. Ponte en `master` y actualízala: *Git → Pull*.
2. Clic en el nombre de la rama → **New Branch…** → `despliegue` (sin barra al principio).
3. Descomprime el zip en la raíz del proyecto.
4. Commit (`Ctrl+K`) y push (`Ctrl+Shift+K`).

Para publicar cambios más adelante: mezcla `master` en `despliegue` (*clic en master → Merge 'master' into 'despliegue'*) y haz push.

> El cambio de `Env.java` es seguro también para `master` (en local con `.env` funciona igual). Llevarlo a `master` evita conflictos en las mezclas.

---

## 2. GitHub Actions

No hay que configurar secretos para que funcione: el workflow usa el `GITHUB_TOKEN` automático para publicar en GitHub Container Registry (GHCR).

1. En GitHub, **Settings → Actions → General → Workflow permissions**: marca **Read and write permissions** y guarda.
   (Si la organización no lo permite, el workflow ya pide `packages: write` por su cuenta; si aun así falla con `denied`, este es el ajuste.)
2. Haz el primer push a `despliegue` (paso 1). En la pestaña **Actions** aparecerá *Despliegue (imagen Docker)*. La primera vez tarda unos minutos; las siguientes son más rápidas gracias a la caché.
3. Comprueba que la imagen existe: en el repositorio, columna derecha → **Packages → shamchester**.

También se puede lanzar a mano: *Actions → Despliegue (imagen Docker) → Run workflow*.

### Acceso a la imagen

Las imágenes de GHCR nacen **privadas**. Dos opciones:

- **Pública** (lo más sencillo): *Packages → shamchester → Package settings → Change visibility → Public*. La imagen solo contiene la web compilada; las contraseñas van en variables de Portainer, no en la imagen.
- **Privada**: crea un token en GitHub (*Settings → Developer settings → Personal access tokens → Tokens (classic)*) con el permiso **`read:packages`** y dáselo a tu amigo para el paso 3.1.

---

## 3. Portainer

### 3.1 Registro (solo si la imagen es privada)

*Registries → Add registry → Custom registry*:

- **Registry URL**: `ghcr.io`
- **Authentication**: activada
- **Username**: el usuario de GitHub del token
- **Password**: el token con `read:packages`

### 3.2 Crear el stack

*Stacks → Add stack*:

1. **Name**: `shamchester`
2. **Build method**: **Repository**
3. **Repository URL**: `https://github.com/PorcoBorracho/Shamchester`
4. **Repository reference**: `refs/heads/despliegue`
5. **Compose path**: `docker-compose.yml`
6. **Authentication**: desactivada (el repositorio es público).
7. **GitOps updates**: activado
   - **Mechanism**: **Polling**
   - **Fetch interval**: `5m`
   - **Re-pull image**: activado
   - **Force redeployment**: activado (ver «Por qué *Force redeployment*» abajo)
8. **Environment variables** → *Load variables from .env file*: sube una copia de `portainer.env.example` con los valores reales (sobre todo `SUPABASE_DB_PASSWORD`).
9. **Deploy the stack**.

La web queda en `http://<servidor>:8080` (o el puerto de `WEB_PORT`).

### Por qué *Force redeployment*

Portainer redespliega cuando ve **un commit nuevo** en la rama, pero la imagen tarda unos minutos en construirse en GitHub. Si Portainer mira justo después del push, descarga la imagen **anterior** y no vuelve a intentarlo porque ya «conoce» ese commit.

Con *Force redeployment* + *Re-pull image*, en cada sondeo hace `docker compose pull` + `up`: si la imagen no ha cambiado, no reinicia nada; si hay una nueva, recrea el contenedor. Así el retraso máximo es un intervalo después de que termine el build.

### Alternativa: webhook (redespliegue inmediato)

Si la versión de Portainer de tu amigo ofrece **Webhook** como mecanismo de GitOps y Portainer es **accesible desde internet**:

1. En el stack, cambia *Mechanism* a **Webhook** y copia la URL que genera.
2. En GitHub: *Settings → Secrets and variables → Actions → New repository secret* → `PORTAINER_WEBHOOK_URL` con esa URL.

El último paso del workflow llamará al webhook **después** de publicar la imagen, así que Portainer redespliega en cuanto la imagen está lista. Sin ese secreto, el paso se salta solo.

---

## 4. Comprobar y mantener

- **Logs de la aplicación**: Portainer → *Containers → shamchester → Logs*. Al arrancar debe aparecer la línea `Supabase: jdbc:postgresql://…` con el host y el usuario correctos.
- **Archivos de log** (`app.log`, `error.log`): están en el volumen `shamchester_logs`. Desde el contenedor: *Console* → `ls /logs`.
- **Volver a una versión anterior**: cada build publica también la imagen con el hash del commit (`ghcr.io/porcoborracho/shamchester:<sha>`). Basta con poner ese tag en `image:` del compose, o hacer *revert* en la rama `despliegue`.
- **Puerto**: si el 8080 está ocupado en el servidor, cambia `WEB_PORT` en las variables del stack.

## 5. Problemas habituales

| Síntoma | Causa probable | Solución |
|---|---|---|
| El workflow falla en *Construir y publicar* con `denied` | Sin permiso para publicar paquetes | Paso 2.1 (Read and write permissions) |
| Portainer: `pull access denied` / `unauthorized` | Imagen privada sin registro configurado | Hacer pública la imagen o paso 3.1 |
| Portainer: `Falta SUPABASE_DB_PASSWORD` | Variable sin rellenar en el stack | Añadirla en *Environment variables* |
| La web responde 503 | La aplicación no arrancó | Ver logs del contenedor; buscar `Caused by:` |
| `Connection is not available` en los logs | Host o contraseña de Supabase incorrectos | Usar el **Session pooler** de Supabase (*Connect*) y revisar la contraseña |
| El push no se refleja | Polling aún no ha pasado / build en curso | Esperar un intervalo, o *Pull and redeploy* en el stack |
