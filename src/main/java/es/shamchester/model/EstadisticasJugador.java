package es.shamchester.model;

import es.shamchester.util.Fechas;

/**
 * Estadísticas globales (todas las temporadas) de un jugador.
 * Las fórmulas son las de la hoja "Resumen automático" del Excel del club;
 * la letra de cada columna está en el comentario de cada método.
 * Los partidos duran 50 minutos: de ahí el "/ min * 50".
 */
public final class EstadisticasJugador {

    public static final EstadisticasJugador VACIA =
            new EstadisticasJugador(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

    private final long partidos;      // AC
    private final long minutos;       // I
    private final long pb, pf;        // O, P  pases
    private final long ppb, ppf;      // R, S  pases de portero
    private final long rb, rf;        // U, V  regates
    private final long defensa;       // J
    private final long paradas;       // K
    private final long goles;         // L
    private final long asistencias;   // M
    /** Radar (0-100): valor relativo al mejor de la plantilla. */
    private final int radarPases, radarRegates, radarDefensa, radarIntervenciones, radarGolesAsistencias;

    public EstadisticasJugador(long partidos, long minutos, long pb, long pf, long ppb, long ppf,
                               long rb, long rf, long defensa, long paradas, long goles, long asistencias,
                               int radarPases, int radarRegates, int radarDefensa,
                               int radarIntervenciones, int radarGolesAsistencias) {
        this.partidos = partidos;
        this.minutos = minutos;
        this.pb = pb;
        this.pf = pf;
        this.ppb = ppb;
        this.ppf = ppf;
        this.rb = rb;
        this.rf = rf;
        this.defensa = defensa;
        this.paradas = paradas;
        this.goles = goles;
        this.asistencias = asistencias;
        this.radarPases = radarPases;
        this.radarRegates = radarRegates;
        this.radarDefensa = radarDefensa;
        this.radarIntervenciones = radarIntervenciones;
        this.radarGolesAsistencias = radarGolesAsistencias;
    }

    public static EstadisticasJugador de(FilaEstadisticas f) {
        return new EstadisticasJugador(n(f.getPartidos()), n(f.getMinutos()),
                n(f.getPasesBuenos()), n(f.getPasesMalos()), n(f.getPpBuenos()), n(f.getPpMalos()),
                n(f.getRegatesBuenos()), n(f.getRegatesMalos()),
                n(f.getDefensa()), n(f.getParadas()), n(f.getGoles()), n(f.getAsistencias()), 0, 0, 0, 0, 0);
    }

    /** Copia con los valores del radar ya normalizados contra los máximos de la plantilla. */
    public EstadisticasJugador conRadar(double maxCoefPases, double maxCoefRegates, double maxDefensa50,
                                        double maxIntervenciones50, double maxGolesAsistencias50) {
        return new EstadisticasJugador(partidos, minutos, pb, pf, ppb, ppf, rb, rf, defensa, paradas, goles, asistencias,
                escala(coefPases(), maxCoefPases), escala(coefRegates(), maxCoefRegates),
                escala(defensa50(), maxDefensa50), escala(intervenciones50(), maxIntervenciones50),
                escala(golesAsistencias50(), maxGolesAsistencias50));
    }

    /** N · Goles + asistencias, por cada 50 min (para el radar: así no gana quien más minutos juega). */
    public double golesAsistencias50() {
        return minutos == 0 ? 0 : (double) (goles + asistencias) / minutos * 50;
    }

    // ------------------------------------------------------------------ fórmulas del Excel

    /** Q · % Pases = O / (O + P) */
    public Double pctPases() { return ratio(pb, pb + pf); }

    /** T · % PP = R / (R + S) */
    public Double pctPp() { return ratio(ppb, ppb + ppf); }

    /** W · % regate = U / (U + V) */
    public Double pctRegate() { return ratio(rb, rb + rf); }

    /** X · Defensa/50 min = IFERROR(J / I * 50, 0) */
    public double defensa50() { return minutos == 0 ? 0 : (double) defensa / minutos * 50; }

    /** Y · Perdidas = P + V + S */
    public long perdidas() { return pf + rf + ppf; }

    /** Z · Perdidas por partido = Y / AC */
    public Double perdidasPartido() { return partidos == 0 ? null : (double) perdidas() / partidos; }

    /**
     * AA · Coeficiente Pases = a² / (a + b), con a = (O + R) / I * 50 y b = (P + S) / I * 50.
     * Equivale a: pases buenos por 50 min × % de acierto en pases (incluidos los de portero).
     */
    public double coefPases() { return coeficiente(pb + ppb, pf + ppf); }

    /** AB · Coeficiente Regates = a² / (a + b), con a = U / I * 50 y b = V / I * 50. */
    public double coefRegates() { return coeficiente(rb, rf); }

    /** AD · Mins por partido = I / AC */
    public Double minsPartido() { return partidos == 0 ? null : (double) minutos / partidos; }

    /** AE · % acierto total = IFERROR((O + U + R) / (O + U + R + S + P + V), 0) */
    public double aciertoTotal() {
        long total = pb + rb + ppb + ppf + pf + rf;
        return total == 0 ? 0 : (double) (pb + rb + ppb) / total;
    }

    /** AF · Intervenciones (por partido) = IFERROR((L + O + U + P + V + R + S) / AC, 0) */
    public double intervencionesPartido() {
        return partidos == 0 ? 0 : (double) (goles + pb + rb + pf + rf + ppb + ppf) / partidos;
    }

    /** AG · Fiabilidad = AF * AE */
    public double fiabilidad() { return intervencionesPartido() * aciertoTotal(); }

    /** AH · Intervenciones (por 50 min) = IFERROR((L + J + K + O + U + P + V + R + S) / I * 50, 0) */
    public double intervenciones50() {
        return minutos == 0 ? 0
                : (double) (goles + defensa + paradas + pb + rb + pf + rf + ppb + ppf) / minutos * 50;
    }

    // ------------------------------------------------------------------ getters para la JSP (texto en gallego)

    public boolean isConDatos() { return partidos > 0; }
    public boolean isConPasesPortero() { return ppb + ppf > 0; }
    public long getPartidos() { return partidos; }
    public long getMinutos() { return minutos; }
    public long getPerdidas() { return perdidas(); }

    public String getPctPases() { return pct(pctPases()); }
    public String getPctPp() { return pct(pctPp()); }
    public String getPctRegate() { return pct(pctRegate()); }
    public String getAciertoTotal() { return pct(aciertoTotal()); }
    /** Valor 0-100 para las barras; null sin intentos. */
    public Integer getBarPases() { return bar(pctPases()); }
    public Integer getBarPp() { return bar(pctPp()); }
    public Integer getBarRegate() { return bar(pctRegate()); }
    public Integer getBarAcierto() { return bar(aciertoTotal()); }

    public String getDefensa50() { return dec(defensa50()); }
    public String getPerdidasPartido() { return dec(perdidasPartido()); }
    public String getCoefPases() { return dec(coefPases()); }
    public String getCoefRegates() { return dec(coefRegates()); }
    public String getMinsPartido() { return dec(minsPartido()); }
    public String getIntervencionesPartido() { return dec(intervencionesPartido()); }
    public String getFiabilidad() { return dec(fiabilidad()); }
    public String getIntervenciones50() { return dec(intervenciones50()); }

    public int getRadarPases() { return radarPases; }
    public int getRadarRegates() { return radarRegates; }
    public int getRadarDefensa() { return radarDefensa; }

    public int getRadarIntervenciones() { return radarIntervenciones; }
    public int getRadarGolesAsistencias() { return radarGolesAsistencias; }

    /**
     * Vértices del polígono del radar (SVG 200×200, centro 100,100, radio 80), en sentido horario
     * desde arriba: Pases, Regates, Goles + asistencias, Defensa, Intervenciones.
     */
    public String getRadarPuntos() {
        int[] valores = {radarPases, radarRegates, radarGolesAsistencias, radarDefensa, radarIntervenciones};
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < valores.length; i++) {
            if (i > 0) sb.append(' ');
            sb.append(punto(valores[i], -90 + 72 * i));
        }
        return sb.toString();
    }

    // ------------------------------------------------------------------ utilidades

    private double coeficiente(long buenos, long malos) {
        if (minutos == 0 || buenos + malos == 0) {
            return 0;
        }
        double a = (double) buenos / minutos * 50;
        double b = (double) malos / minutos * 50;
        return a * a / (a + b);
    }

    private static Double ratio(long buenos, long total) {
        return total == 0 ? null : (double) buenos / total;
    }

    private static String pct(Double v) {
        return v == null ? null : Math.round(v * 100) + " %";
    }

    private static Integer bar(Double v) {
        return v == null ? null : (int) Math.round(v * 100);
    }

    private static String dec(Double v) {
        return v == null ? null : String.format(Fechas.GALEGO, "%.1f", v);
    }

    private static int escala(double valor, double maximo) {
        return maximo <= 0 ? 0 : (int) Math.round(Math.min(valor / maximo, 1) * 100);
    }

    private static String punto(int valor, double grados) {
        double r = 80 * valor / 100.0;
        double rad = Math.toRadians(grados);
        return String.format(java.util.Locale.ROOT, "%.1f,%.1f", 100 + r * Math.cos(rad), 100 + r * Math.sin(rad));
    }

    private static long n(Long valor) {
        return valor == null ? 0 : valor;
    }
}
