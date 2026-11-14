<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="currentPage" value="'plantilla'" scope="request"/>
<s:set var="titleKey" value="'plantilla.title'" scope="request"/>
<jsp:include page="common/header.jsp"/>

<main>
    <section class="page" aria-labelledby="h-plantilla">
        <div class="wrap">
            <h2 class="sec" id="h-plantilla"><s:text name="plantilla.title"/></h2>
            <p class="lede"><s:text name="plantilla.lede"/></p>
            <ul class="players">
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/1.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh1" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh1)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 1">1</span>
                    <span class="pos-tag POR">POR</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.1.name"/></h4>
                    <p class="role"><s:text name="pos.POR"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.1.trait.1"/></li><li><s:text name="player.1.trait.2"/></li><li><s:text name="player.1.trait.3"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/2.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh2" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh2)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 2">2</span>
                    <span class="pos-tag DEF">DEF</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.2.name"/></h4>
                    <p class="role"><s:text name="pos.DEF"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.2.trait.1"/></li><li><s:text name="player.2.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/3.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh3" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh3)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 3">3</span>
                    <span class="pos-tag DEF">DEF</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.3.name"/></h4>
                    <p class="role"><s:text name="pos.DEF"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.3.trait.1"/></li><li><s:text name="player.3.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player captain">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/4.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh4" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh4)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 4">4</span>
                    <span class="pos-tag DEF">DEF</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.4.name"/> <span class="sr">(<s:text name="plantilla.captain"/>)</span></h4>
                    <p class="role"><s:text name="pos.DEF"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.4.trait.1"/></li><li><s:text name="player.4.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/5.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh5" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh5)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 5">5</span>
                    <span class="pos-tag DEF">DEF</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.5.name"/></h4>
                    <p class="role"><s:text name="pos.DEF"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.5.trait.1"/></li><li><s:text name="player.5.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/6.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh6" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#1A8841" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh6)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 6">6</span>
                    <span class="pos-tag MED">MED</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.6.name"/></h4>
                    <p class="role"><s:text name="pos.MED"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.6.trait.1"/></li><li><s:text name="player.6.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/7.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh7" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh7)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 7">7</span>
                    <span class="pos-tag DEL">DIA</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.7.name"/></h4>
                    <p class="role"><s:text name="pos.DEL"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.7.trait.1"/></li><li><s:text name="player.7.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/8.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh8" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#1A8841" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh8)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 8">8</span>
                    <span class="pos-tag MED">MED</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.8.name"/></h4>
                    <p class="role"><s:text name="pos.MED"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.8.trait.1"/></li><li><s:text name="player.8.trait.2"/></li><li><s:text name="player.8.trait.3"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/9.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh9" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh9)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 9">9</span>
                    <span class="pos-tag DEL">DIA</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.9.name"/></h4>
                    <p class="role"><s:text name="pos.DEL"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.9.trait.1"/></li><li><s:text name="player.9.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/10.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh10" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#1A8841" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh10)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 10">10</span>
                    <span class="pos-tag MED">MED</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.10.name"/></h4>
                    <p class="role"><s:text name="pos.MED"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.10.trait.1"/></li><li><s:text name="player.10.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/11.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh11" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh11)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 11">11</span>
                    <span class="pos-tag DEL">DIA</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.11.name"/></h4>
                    <p class="role"><s:text name="pos.DEL"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.11.trait.1"/></li><li><s:text name="player.11.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/13.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh13" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh13)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 13">13</span>
                    <span class="pos-tag POR">POR</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.13.name"/></h4>
                    <p class="role"><s:text name="pos.POR"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.13.trait.1"/></li><li><s:text name="player.13.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/14.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh14" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#1A8841" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh14)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 14">14</span>
                    <span class="pos-tag MED">MED</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.14.name"/></h4>
                    <p class="role"><s:text name="pos.MED"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.14.trait.1"/></li><li><s:text name="player.14.trait.2"/></li></ul>
                </div>
            </li>
            <li class="player">
                <div class="photo">
                    <%-- Foto real: <img src="${pageContext.request.contextPath}/img/jugadores/19.jpg" alt=""> --%>
                    <svg viewBox="0 0 200 210" aria-hidden="true"><defs><linearGradient id="sh19" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#5500D5" stop-opacity=".55"/><stop offset="1" stop-color="#14151C" stop-opacity="0"/></linearGradient></defs><rect width="200" height="210" fill="url(#sh19)"/><circle cx="100" cy="78" r="34" fill="#2C2D3A"/><path d="M30 210c4-52 34-80 70-80s66 28 70 80z" fill="#2C2D3A"/></svg>
                    <span class="dorsal" aria-label="<s:text name="plantilla.dorsal"/> 19">19</span>
                    <span class="pos-tag DEL">DIA</span>
                </div>
                <div class="info">
                    <h4><s:text name="player.19.name"/></h4>
                    <p class="role"><s:text name="pos.DEL"/></p>
                    <ul class="traits" aria-label="<s:text name="plantilla.traits"/>"><li><s:text name="player.19.trait.1"/></li><li><s:text name="player.19.trait.2"/></li></ul>
                </div>
            </li>
            </ul>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp"/>
