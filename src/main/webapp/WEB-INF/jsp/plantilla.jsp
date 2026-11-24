<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="currentPage" value="'plantilla'" scope="request"/>
<s:set var="titleKey" value="'plantilla.title'" scope="request"/>
<jsp:include page="common/header.jsp"/>

<main>
    <section class="page" aria-labelledby="h-plantilla">
        <div class="wrap">
            <h2 class="sec" id="h-plantilla"><s:text name="plantilla.title"/></h2>

            <s:if test="error">
                <p class="lede" role="alert"><s:text name="plantilla.error"/></p>
            </s:if>
            <s:elseif test="jugadores.isEmpty()">
                <p class="lede"><s:text name="plantilla.empty"/></p>
            </s:elseif>
            <s:else>
            <ul class="players">
                <s:iterator value="jugadores" var="j">
                <li class="player<s:if test="#j.lesionado"> injured</s:if>">
                    <div class="photo">
                        <s:if test="#j.conFoto">
                            <img src="<s:url action="jugador-foto"><s:param name="id" value="#j.id"/></s:url>" alt="" loading="lazy" decoding="async">
                        </s:if>
                        <s:else>
                            <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh<s:property value="#j.id"/>" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh<s:property value="#j.id"/>)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                        </s:else>
                        <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> <s:property value="#j.dorsal"/>"><s:property value="#j.dorsal"/></span>
                        <s:if test="#j.codigoPosicion != null">
                            <span class="pos-tag <s:property value="#j.codigoPosicion"/>"><s:text name="%{'pos.tag.' + #j.codigoPosicion}"/></span>
                        </s:if>
                        <s:if test="#j.lesionado">
                            <span class="injured-tag"><s:text name="plantilla.injured"/></span>
                        </s:if>
                    </div>
                    <div class="info">
                        <h4><button type="button" class="player-open js-player" aria-haspopup="dialog" data-dorsal="<s:property value="#j.dorsal"/>" data-nombre="<s:property value="#j.nombre"/>" data-posicion="<s:property value="#j.posicion"/>"><s:property value="#j.nombre"/><span class="sr-only"> · <s:text name="plantilla.stats.open"/></span></button></h4>
                        <p class="role"><s:property value="#j.posicion"/></p>
                        <s:if test="!#j.caracteristicas.isEmpty()">
                            <ul class="traits" aria-label="<s:text name="plantilla.traits"/>">
                                <s:iterator value="#j.caracteristicas" var="c"><li><s:property value="#c"/></li></s:iterator>
                            </ul>
                        </s:if>
                        <span class="player-more" aria-hidden="true"><s:text name="plantilla.stats.open"/><svg viewBox="0 0 16 16" width="14" height="14"><path d="M3 8h10M9 4l4 4-4 4" fill="none" stroke="currentColor" stroke-width="2"/></svg></span>
                    </div>
                    <%-- Estadísticas globales (fórmulas del Excel): la modal copia estas plantillas al abrirse --%>
                    <template class="js-radar">
                        <s:if test="#j.estadisticas.conDatos">
                        <figure class="radar">
                            <svg viewBox="-40 -6 280 196" role="img" aria-label="<s:text name="plantilla.stats.radar.aria"><s:param value="#j.estadisticas.radarPases"/><s:param value="#j.estadisticas.radarRegates"/><s:param value="#j.estadisticas.radarDefensa"/></s:text>">
                                <polygon class="radar__grid" points="100.0,80.0 117.3,110.0 82.7,110.0"/><polygon class="radar__grid" points="100.0,60.0 134.6,120.0 65.4,120.0"/><polygon class="radar__grid" points="100.0,40.0 152.0,130.0 48.0,130.0"/><polygon class="radar__grid" points="100.0,20.0 169.3,140.0 30.7,140.0"/><line class="radar__axis" x1="100" y1="100" x2="100.0" y2="20.0"/><line class="radar__axis" x1="100" y1="100" x2="169.3" y2="140.0"/><line class="radar__axis" x1="100" y1="100" x2="30.7" y2="140.0"/>
                                <polygon class="radar__shape" points="<s:property value="#j.estadisticas.radarPuntos"/>"/>
                                <text class="radar__label" x="100" y="10" text-anchor="middle"><s:text name="plantilla.stats.radar.passes"/></text>
                                <text class="radar__label" x="172" y="152" text-anchor="middle"><s:text name="plantilla.stats.radar.dribbles"/></text>
                                <text class="radar__label" x="28" y="152" text-anchor="middle"><s:text name="plantilla.stats.radar.defence"/></text>
                            </svg>
                            <figcaption><s:text name="plantilla.stats.radar.caption"/></figcaption>
                        </figure>
                        </s:if>
                    </template>
                    <template class="js-stats">
                        <s:set var="e" value="#j.estadisticas"/>
                        <s:if test="#e.conDatos">
                            <p class="pstats__scope"><s:text name="plantilla.stats.scope"><s:param value="#e.partidos"/><s:param value="#e.minutos"/></s:text></p>
                            <section class="pgroup">
                                <h5><s:text name="plantilla.stats.group.passes"/></h5>
                                <dl class="ptiles">
                                    <div class="ptile"><dt><s:text name="plantilla.stats.pctPases"/></dt><dd class="ptile__value"><s:if test="#e.pctPases != null"><s:property value="#e.pctPases"/></s:if><s:else>–</s:else></dd><s:if test="#e.barPases != null"><dd class="ptile__bar"><span style="--v: <s:property value="#e.barPases"/>"></span></dd></s:if></div>
                                    <s:if test="#j.portero or #e.conPasesPortero">
                                    <div class="ptile"><dt><s:text name="plantilla.stats.pctPp"/></dt><dd class="ptile__value"><s:if test="#e.pctPp != null"><s:property value="#e.pctPp"/></s:if><s:else>–</s:else></dd><s:if test="#e.barPp != null"><dd class="ptile__bar"><span style="--v: <s:property value="#e.barPp"/>"></span></dd></s:if></div>
                                    </s:if>
                                    <div class="ptile"><dt><s:text name="plantilla.stats.coefPases"/></dt><dd class="ptile__value"><s:if test="#e.coefPases != null"><s:property value="#e.coefPases"/></s:if><s:else>–</s:else></dd></div>
                                </dl>
                            </section>
                            <section class="pgroup">
                                <h5><s:text name="plantilla.stats.group.dribbles"/></h5>
                                <dl class="ptiles">
                                    <div class="ptile"><dt><s:text name="plantilla.stats.pctRegate"/></dt><dd class="ptile__value"><s:if test="#e.pctRegate != null"><s:property value="#e.pctRegate"/></s:if><s:else>–</s:else></dd><s:if test="#e.barRegate != null"><dd class="ptile__bar"><span style="--v: <s:property value="#e.barRegate"/>"></span></dd></s:if></div>
                                    <div class="ptile"><dt><s:text name="plantilla.stats.coefRegates"/></dt><dd class="ptile__value"><s:if test="#e.coefRegates != null"><s:property value="#e.coefRegates"/></s:if><s:else>–</s:else></dd></div>
                                </dl>
                            </section>
                            <section class="pgroup">
                                <h5><s:text name="plantilla.stats.group.defence"/></h5>
                                <dl class="ptiles">
                                    <div class="ptile"><dt><s:text name="plantilla.stats.defensa50"/></dt><dd class="ptile__value"><s:if test="#e.defensa50 != null"><s:property value="#e.defensa50"/></s:if><s:else>–</s:else></dd></div>
                                    <div class="ptile"><dt><s:text name="plantilla.stats.perdidas"/></dt><dd class="ptile__value"><s:if test="#e.perdidas != null"><s:property value="#e.perdidas"/></s:if><s:else>–</s:else></dd></div>
                                    <div class="ptile"><dt><s:text name="plantilla.stats.perdidasPartido"/></dt><dd class="ptile__value"><s:if test="#e.perdidasPartido != null"><s:property value="#e.perdidasPartido"/></s:if><s:else>–</s:else></dd></div>
                                </dl>
                            </section>
                            <section class="pgroup">
                                <h5><s:text name="plantilla.stats.group.performance"/></h5>
                                <dl class="ptiles">
                                    <div class="ptile"><dt><s:text name="plantilla.stats.minsPartido"/></dt><dd class="ptile__value"><s:if test="#e.minsPartido != null"><s:property value="#e.minsPartido"/></s:if><s:else>–</s:else></dd></div>
                                    <div class="ptile"><dt><s:text name="plantilla.stats.aciertoTotal"/></dt><dd class="ptile__value"><s:if test="#e.aciertoTotal != null"><s:property value="#e.aciertoTotal"/></s:if><s:else>–</s:else></dd><s:if test="#e.barAcierto != null"><dd class="ptile__bar"><span style="--v: <s:property value="#e.barAcierto"/>"></span></dd></s:if></div>
                                    <div class="ptile"><dt><s:text name="plantilla.stats.intervPartido"/></dt><dd class="ptile__value"><s:if test="#e.intervencionesPartido != null"><s:property value="#e.intervencionesPartido"/></s:if><s:else>–</s:else></dd></div>
                                    <div class="ptile"><dt><s:text name="plantilla.stats.fiabilidad"/></dt><dd class="ptile__value"><s:if test="#e.fiabilidad != null"><s:property value="#e.fiabilidad"/></s:if><s:else>–</s:else></dd></div>
                                    <div class="ptile"><dt><s:text name="plantilla.stats.interv50"/></dt><dd class="ptile__value"><s:if test="#e.intervenciones50 != null"><s:property value="#e.intervenciones50"/></s:if><s:else>–</s:else></dd></div>
                                </dl>
                            </section>
                        </s:if>
                        <s:else>
                            <p class="pstats__empty"><s:text name="plantilla.stats.empty"/></p>
                        </s:else>
                    </template>
                </li>
                </s:iterator>
            </ul>
            </s:else>
        </div>
    </section>

    <dialog class="player-modal" id="player-modal" aria-labelledby="player-modal-title">
        <div class="player-modal__panel">
            <div class="player-modal__head">
                <h3 id="player-modal-title"><span class="player-modal__num"></span><span class="player-modal__name"></span></h3>
                <button type="button" class="player-modal__close" data-close aria-label="<s:text name="plantilla.stats.close"/>">
                    <svg viewBox="0 0 16 16" width="16" height="16" aria-hidden="true"><path d="M3 3l10 10M13 3L3 13" stroke="currentColor" stroke-width="2" stroke-linecap="square"/></svg>
                </button>
            </div>
            <div class="player-modal__body">
                <div class="player-modal__side">
                    <div class="player-modal__radar"></div>
                    <div class="player-modal__photo"></div>
                </div>
                <div class="player-modal__stats">
                    <p class="player-modal__role"></p>
                    <h4 class="player-modal__title"><s:text name="plantilla.stats.title"/></h4>
                    <div class="player-modal__content"></div>
                </div>
            </div>
        </div>
    </dialog>
</main>
<jsp:include page="common/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/player-modal.js"></script>
