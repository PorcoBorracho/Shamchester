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
                        <h4><s:property value="#j.nombre"/></h4>
                        <p class="role"><s:property value="#j.posicion"/></p>
                        <s:if test="!#j.caracteristicas.isEmpty()">
                            <ul class="traits" aria-label="<s:text name="plantilla.traits"/>">
                                <s:iterator value="#j.caracteristicas" var="c"><li><s:property value="#c"/></li></s:iterator>
                            </ul>
                        </s:if>
                    </div>
                </li>
                </s:iterator>
            </ul>
            </s:else>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp"/>
