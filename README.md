# Shamchester United

Maqueta de la web do Shamchester United con **Maven**, **Java 21** y **Struts 7**. Todavía no tiene funcionalidad: cada página es una acción que solo muestra su JSP.

## Abrir en IntelliJ

1. `File > Open` y elige la carpeta del proyecto (o el `pom.xml`). IntelliJ lo importa como proyecto Maven.
2. Pon el SDK del proyecto en Java 21 (`File > Project Structure > Project`).
3. Copia `.env.example` como `.env` si no existe.
4. Ejecuta la configuración **Jetty (mvn jetty:run)** o, en terminal, `mvn jetty:run`.
5. Abre http://localhost:8080/

También puedes generar el `.war` con `mvn package` y desplegarlo en Tomcat 10.1 o superior.

## Dónde está cada cosa

| Qué | Dónde |
| --- | --- |
| Variables de entorno | `.env` (plantilla en `.env.example`) |
| Lectura del `.env` | `src/main/java/es/shamchester/config/Env.java` |
| Textos (locale) | `src/main/resources/i18n/messages.properties` |
| Rutas de Struts | `src/main/resources/struts.xml` |
| Acciones | `src/main/java/es/shamchester/action/` |
| Vistas | `src/main/webapp/WEB-INF/jsp/` (cabecera y pie en `common/`) |
| Estilos | `src/main/webapp/css/` (`variables.css` y `styles.css`) |
| Scripts de la maqueta | `src/main/webapp/js/` |
| Fotos de jugadores | `src/main/webapp/img/jugadores/` |

## Variables de entorno

Se leen del `.env` al arrancar y se publican en las JSP como `${env.NOMBRE}`. Si existe una variable de sistema con el mismo nombre, gana la del sistema. Para usar otro archivo, define `ENV_FILE=/ruta/al/archivo`.

## Textos e idiomas

Todos los textos visibles están en `messages.properties` y se pintan con `<s:text name="clave"/>`. Para añadir un idioma, crea `messages_en.properties` (por ejemplo) con las mismas claves.

## Páginas

| URL | Acción | Vista |
| --- | --- | --- |
| `/inicio` | `InicioAction` | `inicio.jsp` |
| `/plantilla` | `PlantillaAction` | `plantilla.jsp` |
| `/partidos` | `PartidosAction` | `partidos.jsp` |
| `/newsletter` | `NewsletterAction` | `newsletter.jsp` |
| `/contacto` | `ContactoAction` | `contacto.jsp` |
