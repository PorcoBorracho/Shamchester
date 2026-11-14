<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="currentPage" value="'inicio'" scope="request"/>
<s:set var="titleKey" value="'inicio.title'" scope="request"/>
<jsp:include page="common/header.jsp"/>

<main>
    <section class="home" aria-labelledby="h-inicio">
        <div class="wrap">
            <div class="title-row">
                <h1 id="h-inicio"><s:text name="inicio.h1.start"/></h1>
                <p><s:text name="inicio.intro"/></p>
            </div>
            <div class="story">
                <p><s:text name="inicio.p1"/></p>
                <div class="cta-row">
                    <a class="btn btn-green" href="<s:url action="partidos"/>"><s:text name="inicio.cta.partidos"/></a>
                    <a class="btn btn-ghost" href="<s:url action="plantilla"/>"><s:text name="inicio.cta.plantilla"/></a>
                </div>
            </div>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp"/>
