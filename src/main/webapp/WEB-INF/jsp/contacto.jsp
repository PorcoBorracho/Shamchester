<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="currentPage" value="'contacto'" scope="request"/>
<s:set var="titleKey" value="'contacto.title'" scope="request"/>
<jsp:include page="common/header.jsp"/>

<main>
    <section class="page" aria-labelledby="h-contacto">
        <div class="wrap">
            <h2 class="sec" id="h-contacto"><s:text name="contacto.title"/></h2>
            <!--<p class="lede"><s:text name="contacto.lede"/></p>-->
            <div class="contact">
                <div>
                    <ul class="socials">
                        <li><a href="<s:property value='%{getValorInfo("redes.instagram")}'/>" target="_blank" rel="noopener"><span class="ic"><svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6"><rect x="2" y="2" width="16" height="16" rx="4.5"/><circle cx="10" cy="10" r="3.6"/><circle cx="14.6" cy="5.4" r="0.6" fill="currentColor"/></svg></span><div><b><s:text name="contacto.instagram"/></b></div><svg class="arrow" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h10M9 4l4 4-4 4"/></svg></a></li>
                        <li><a href="<s:property value='%{getValorInfo("redes.x")}'/>" target="_blank" rel="noopener"><span class="ic"><svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M3 3l14 14M17 3L3 17"/></svg></span><div><b><s:text name="contacto.x"/></b></div><svg class="arrow" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h10M9 4l4 4-4 4"/></svg></a></li>
                        <li><a href="<s:property value='%{getValorInfo("redes.youtube")}'/>" target="_blank" rel="noopener"><span class="ic"><svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6"><rect x="1.5" y="4" width="17" height="12" rx="3"/><path d="M8.5 7.5v5l4-2.5z" fill="currentColor" stroke="none"/></svg></span><div><b><s:text name="contacto.youtube"/></b></div><svg class="arrow" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h10M9 4l4 4-4 4"/></svg></a></li>
                        <li><a href="<s:property value='%{getValorInfo("redes.twitch")}'/>"><span class="ic"><svg viewBox="0 0 24 24 " role="img" width="20" height="20" fill="currentcolor"><title>Twitch</title><path d="M11.571 4.714h1.715v5.143H11.57zm4.715 0H18v5.143h-1.714zM6 0L1.714 4.286v15.428h5.143V24l4.286-4.286h3.428L22.286 12V0zm14.571 11.143l-3.428 3.428h-3.429l-3 3v-3H6.857V1.714h13.714Z"></path></svg></span><div><b><s:text name="contacto.twitch"/></b></div><svg class="arrow" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h10M9 4l4 4-4 4"/></svg></a></li>
                    </ul>
                    <address class="address"><b><s:text name="contacto.stadium"/></b><s:property value='%{getValorInfo("estadio.nombre")}'/></address>
                </div>
                <figure class="mapcard" style="margin:0">
                    <iframe
                        class="mapcard-map"
                        src="https://www.google.com/maps?q=<s:property value='%{getValorInfo("estadio.lat")}'/>,<s:property value='%{getValorInfo("estadio.lng")}'/>&z=16&output=embed"
                        title="<s:text name="contacto.map.alt"/>"
                        loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade"
                        style="border:0;width:100%;aspect-ratio:560/340;display:block">
                    </iframe>
                    <figcaption class="foot">
                        <p><s:text name="contacto.map.caption"/></p>
                        <a class="btn btn-ghost" href="<s:property value='%{getValorInfo("estadio.mapa_url")}'/>" target="_blank" rel="noopener"><s:text name="contacto.map.open"/></a>
                    </figcaption>
                </figure>
            </div>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp"/>
