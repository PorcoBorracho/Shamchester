<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="currentPage" value="'partidos'" scope="request"/>
<s:set var="titleKey" value="'partidos.title'" scope="request"/>
<jsp:include page="common/header.jsp"/>

<main>
    <section class="page" aria-labelledby="h-partidos">
        <div class="wrap">
            <h2 class="sec" id="h-partidos"><s:text name="partidos.title"/></h2>
            <p class="lede"><s:text name="partidos.lede"/></p>

            <article class="next" aria-label="<s:text name="partidos.next.label"/>">
                <div class="match">
                    <p class="when"><s:text name="partidos.next.when"/></p>
                    <div class="teams">
                        <div class="team">
                            <img class="crest" src="${pageContext.request.contextPath}/img/escudo.png" alt="" width="72" height="72">
                            <b><s:text name="partidos.next.home"/></b>
                        </div>
                        <div class="vs"><s:text name="partidos.next.vs"/></div>
                        <div class="team">
                            <svg class="crest" viewBox="0 0 30 34" aria-hidden="true"><path d="M2 2h26v15c0 8-6 13-13 15C8 30 2 25 2 17z" fill="#F2F0F5"/><path d="M15 2v30" stroke="#C0392B" stroke-width="5"/></svg>
                            <b><s:text name="partidos.next.away"/></b>
                        </div>
                    </div>
                </div>
                <div class="side">
                    <div class="countdown" id="countdown" data-kickoff="${env.NEXT_MATCH_DATE}">
                        <div><b data-u="d">00</b><span><s:text name="partidos.countdown.days"/></span></div>
                        <div><b data-u="h">00</b><span><s:text name="partidos.countdown.hours"/></span></div>
                        <div><b data-u="m">00</b><span><s:text name="partidos.countdown.minutes"/></span></div>
                        <div><b data-u="s">00</b><span><s:text name="partidos.countdown.seconds"/></span></div>
                    </div>
                </div>
            </article>

            <div class="hist-head">
                <h3><s:text name="partidos.history.title"/></h3>
                <p class="form-strip" style="margin:0"><s:text name="partidos.history.last5"/> <i class="r-V"><s:text name="result.V.short"/></i><i class="r-D"><s:text name="result.D.short"/></i><i class="r-E"><s:text name="result.E.short"/></i><i class="r-D"><s:text name="result.D.short"/></i><i class="r-V"><s:text name="result.V.short"/></i></p>
            </div>
            <table class="hist">
                <thead><tr><th scope="col"><s:text name="partidos.history.date"/></th><th scope="col"><s:text name="partidos.history.rival"/></th><th scope="col"><s:text name="partidos.history.score"/></th><th scope="col"><span class="sr"><s:text name="partidos.history.outcome"/></span></th></tr></thead>
                <tbody>
                <tr><td><s:text name="match.1.date"/></td><td class="rival"><s:text name="match.1.rival"/></td><td class="score">2-1</td><td class="res"><i class="r-V" title="<s:text name="result.V"/>" aria-label="<s:text name="result.V"/>"><s:text name="result.V.short"/></i></td></tr>
                <tr><td><s:text name="match.2.date"/></td><td class="rival"><s:text name="match.2.rival"/></td><td class="score">0-2</td><td class="res"><i class="r-D" title="<s:text name="result.D"/>" aria-label="<s:text name="result.D"/>"><s:text name="result.D.short"/></i></td></tr>
                <tr><td><s:text name="match.3.date"/></td><td class="rival"><s:text name="match.3.rival"/></td><td class="score">1-1</td><td class="res"><i class="r-E" title="<s:text name="result.E"/>" aria-label="<s:text name="result.E"/>"><s:text name="result.E.short"/></i></td></tr>
                <tr><td><s:text name="match.4.date"/></td><td class="rival"><s:text name="match.4.rival"/></td><td class="score">1-3</td><td class="res"><i class="r-D" title="<s:text name="result.D"/>" aria-label="<s:text name="result.D"/>"><s:text name="result.D.short"/></i></td></tr>
                <tr><td><s:text name="match.5.date"/></td><td class="rival"><s:text name="match.5.rival"/></td><td class="score">3-0</td><td class="res"><i class="r-V" title="<s:text name="result.V"/>" aria-label="<s:text name="result.V"/>"><s:text name="result.V.short"/></i></td></tr>
                <tr><td><s:text name="match.6.date"/></td><td class="rival"><s:text name="match.6.rival"/></td><td class="score">2-2</td><td class="res"><i class="r-E" title="<s:text name="result.E"/>" aria-label="<s:text name="result.E"/>"><s:text name="result.E.short"/></i></td></tr>
                <tr><td><s:text name="match.7.date"/></td><td class="rival"><s:text name="match.7.rival"/></td><td class="score">1-0</td><td class="res"><i class="r-V" title="<s:text name="result.V"/>" aria-label="<s:text name="result.V"/>"><s:text name="result.V.short"/></i></td></tr>
                </tbody>
            </table>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/countdown.js"></script>
