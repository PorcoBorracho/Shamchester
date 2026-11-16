<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="currentPage" value="'partidos'" scope="request"/>
<s:set var="titleKey" value="'partidos.title'" scope="request"/>
<jsp:include page="common/header.jsp"/>

<main>
    <section class="page" aria-labelledby="h-partidos">
        <div class="wrap">
            <h2 class="sec" id="h-partidos"><s:text name="partidos.title"/></h2>
            <!--<p class="lede"><s:text name="partidos.lede"/></p>-->

            <s:if test="proximoPartido != null">
            <article class="next" aria-label="<s:text name="partidos.next.label"/>">
                <div class="match">
                    <p class="when"><s:text name="partidos.next.when"><s:param value="proximoPartido.jornada"/><s:param value="proximoPartido.fechaLarga"/></s:text></p>
                    <div class="teams">
                        <div class="team">
                            <img class="crest" src="${pageContext.request.contextPath}/img/escudo.png" alt="" width="72" height="72">
                            <b><s:text name="partidos.next.home"/></b>
                        </div>
                        <div class="vs"><s:text name="partidos.next.vs"/></div>
                        <div class="team">
                            <s:if test="proximoPartido.escudoDataUri != null">
                                <img class="crest" src="<s:property value="proximoPartido.escudoDataUri"/>" alt="<s:text name="partidos.next.crest"><s:param value="proximoPartido.rival"/></s:text>" width="72" height="72">
                            </s:if>
                            <s:else>
                                <svg class="crest" viewBox="0 0 30 34" aria-hidden="true"><path d="M2 2h26v15c0 8-6 13-13 15C8 30 2 25 2 17z" fill="#F2F0F5"/><path d="M15 2v30" stroke="#C0392B" stroke-width="5"/></svg>
                            </s:else>
                            <b><s:property value="proximoPartido.rival"/></b>
                        </div>
                    </div>
                </div>
                <div class="side">
                    <div class="countdown" id="countdown" data-kickoff="<s:property value="proximoPartido.fechaIso"/>">
                        <div><b data-u="d">00</b><span><s:text name="partidos.countdown.days"/></span></div>
                        <div><b data-u="h">00</b><span><s:text name="partidos.countdown.hours"/></span></div>
                        <div><b data-u="m">00</b><span><s:text name="partidos.countdown.minutes"/></span></div>
                        <div><b data-u="s">00</b><span><s:text name="partidos.countdown.seconds"/></span></div>
                    </div>
                </div>
            </article>
            </s:if>
            <s:else>
            <p class="lede"><s:text name="partidos.next.none"/></p>
            </s:else>

            <div class="hist-head">
                <h3><s:text name="partidos.history.title"/></h3>
                <s:if test="conHistorico">
                <p class="form-strip" style="margin:0"><s:text name="partidos.history.last5"/> <s:iterator value="historico" var="p" status="st"><s:if test="#st.index < 5 and #p.resultado() != null"><i class="r-<s:property value="#p.resultado()"/>" title="<s:text name="%{'result.' + #p.resultado()}"/>"><s:text name="%{'result.' + #p.resultado() + '.short'}"/></i></s:if></s:iterator></p>
                </s:if>
            </div>
            <table class="hist">
                <thead>
                    <tr>
                        <th scope="col"><s:text name="partidos.history.date"/></th>
                        <th scope="col"><s:text name="partidos.history.rival"/></th>
                        <th scope="col"><s:text name="partidos.history.score"/></th>
                        <th scope="col"><span class="sr"><s:text name="partidos.history.outcome"/></span></th>
                    </tr>
                </thead>
                <tbody>
                <s:iterator value="historico" var="p">
                    <tr>
                        <td><s:property value="#p.fechaCorta()"/></td>
                        <td class="rival"><s:property value="#p.rival()"/></td>
                        <td class="score"><s:if test="#p.resultado() != null"><s:property value="#p.golesFavor()"/>-<s:property value="#p.golesContra()"/></s:if><s:else>–</s:else></td>
                        <td class="res"><s:if test="#p.resultado() != null"><i class="r-<s:property value="#p.resultado()"/>" title="<s:text name="%{'result.' + #p.resultado()}"/>" aria-label="<s:text name="%{'result.' + #p.resultado()}"/>"><s:text name="%{'result.' + #p.resultado() + '.short'}"/></i></s:if><s:else>–</s:else></td>
                    </tr>
                </s:iterator>
                <s:if test="historico == null || historico.isEmpty()">
                    <tr><td colspan="4"><s:text name="partidos.history.empty"/></td></tr>
                </s:if>
                </tbody>
            </table>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/countdown.js"></script>
