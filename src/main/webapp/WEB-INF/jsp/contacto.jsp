<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="currentPage" value="'contacto'" scope="request"/>
<s:set var="titleKey" value="'contacto.title'" scope="request"/>
<jsp:include page="common/header.jsp"/>

<main>
    <section class="page" aria-labelledby="h-contacto">
        <div class="wrap">
            <h2 class="sec" id="h-contacto"><s:text name="contacto.title"/></h2>
            <p class="lede"><s:text name="contacto.lede"/></p>
            <div class="contact">
                <div>
                    <ul class="socials">
                        <li><a href="${env.SOCIAL_INSTAGRAM_URL}" target="_blank" rel="noopener"><span class="ic"><svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6"><rect x="2" y="2" width="16" height="16" rx="4.5"/><circle cx="10" cy="10" r="3.6"/><circle cx="14.6" cy="5.4" r="0.6" fill="currentColor"/></svg></span><div><b><s:text name="contacto.instagram"/></b><span><s:text name="contacto.instagram.handle"/></span></div><svg class="arrow" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h10M9 4l4 4-4 4"/></svg></a></li>
                        <li><a href="${env.SOCIAL_X_URL}" target="_blank" rel="noopener"><span class="ic"><svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M3 3l14 14M17 3L3 17"/></svg></span><div><b><s:text name="contacto.x"/></b><span><s:text name="contacto.x.handle"/></span></div><svg class="arrow" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h10M9 4l4 4-4 4"/></svg></a></li>
                        <li><a href="${env.SOCIAL_YOUTUBE_URL}" target="_blank" rel="noopener"><span class="ic"><svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6"><rect x="1.5" y="4" width="17" height="12" rx="3"/><path d="M8.5 7.5v5l4-2.5z" fill="currentColor" stroke="none"/></svg></span><div><b><s:text name="contacto.youtube"/></b><span><s:text name="contacto.youtube.text"/></span></div><svg class="arrow" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h10M9 4l4 4-4 4"/></svg></a></li>
                        <li><a href="mailto:${env.CONTACT_EMAIL}"><span class="ic"><svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M2.5 5.5l7.5 5 7.5-5"/><rect x="2" y="4" width="16" height="12" rx="1.5"/></svg></span><div><b><s:text name="contacto.email"/></b><span>${env.CONTACT_EMAIL}</span></div><svg class="arrow" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h10M9 4l4 4-4 4"/></svg></a></li>
                    </ul>
                    <address class="address"><b><s:text name="contacto.stadium"/></b><s:text name="contacto.address.line1"/><br><s:text name="contacto.address.line2"/></address>
                    <ul class="access">
                        <li><svg width="18" height="18" viewBox="0 0 18 18" fill="none" stroke="currentColor" stroke-width="1.6"><rect x="3" y="2" width="12" height="11" rx="2"/><path d="M3 9h12M6 16l1-3m5 3-1-3"/></svg><s:text name="contacto.access.1"/></li>
                        <li><svg width="18" height="18" viewBox="0 0 18 18" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M3 16V2h7a4 4 0 0 1 0 8H3"/></svg><s:text name="contacto.access.2"/></li>
                    </ul>
                </div>
                <figure class="mapcard" style="margin:0">
                    <svg viewBox="0 0 560 340" role="img" aria-label="<s:text name="contacto.map.alt"/>" font-family="Hanken Grotesk, sans-serif" font-size="12">
                        <rect width="560" height="340" fill="#101118"/>
                        <path d="M0 268c80-30 150 10 240-20s170-60 320-30v122H0z" fill="#16233A"/>
                        <path d="M0 268c80-30 150 10 240-20s170-60 320-30" fill="none" stroke="#3B5D8F" stroke-width="2"/>
                        <text x="470" y="300" fill="#7FA2D6" font-size="13"><s:text name="contacto.map.river"/></text>
                        <path d="M300 0v340" stroke="#2A2B36" stroke-width="16"/>
                        <path d="M0 90h560" stroke="#2A2B36" stroke-width="10"/>
                        <text x="12" y="80" fill="#A6A2B0"><s:text name="contacto.map.avenue"/></text>
                        <rect x="286" y="226" width="28" height="44" fill="#2A2B36"/>
                        <text x="320" y="252" fill="#A6A2B0"><s:text name="contacto.map.bridge"/></text>
                        <g transform="translate(80 120)">
                            <rect width="170" height="110" rx="16" fill="#1B1C25" stroke="#3A3B48"/>
                            <rect x="22" y="18" width="126" height="74" fill="#1A8841"/>
                            <path d="M85 18v74" stroke="#7CD39B" stroke-width="1.2"/>
                            <circle cx="85" cy="55" r="11" fill="none" stroke="#7CD39B" stroke-width="1.2"/>
                            <rect x="0" y="92" width="170" height="18" fill="#5500D5"/>
                            <text x="85" y="105" text-anchor="middle" fill="#fff" font-family="Big Shoulders Display, sans-serif" font-weight="800" letter-spacing="1"><s:text name="contacto.map.stand"/></text>
                        </g>
                        <circle cx="232" cy="244" r="7" fill="#4FC77A"/>
                        <text x="160" y="262" fill="#F2F0F5" font-weight="600"><s:text name="contacto.map.gates"/></text>
                        <circle cx="92" cy="114" r="7" fill="#4FC77A"/>
                        <text x="104" y="110" fill="#F2F0F5" font-weight="600"><s:text name="contacto.map.parking"/></text>
                        <circle cx="330" cy="96" r="6" fill="#A983FF"/>
                        <text x="342" y="114" fill="#D8D5DE"><s:text name="contacto.map.bus"/></text>
                    </svg>
                    <figcaption class="foot">
                        <p><s:text name="contacto.map.caption"/></p>
                        <a class="btn btn-ghost" href="${env.MAP_URL}" target="_blank" rel="noopener"><s:text name="contacto.map.open"/></a>
                    </figcaption>
                </figure>
            </div>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp"/>
