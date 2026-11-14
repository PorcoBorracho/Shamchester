<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="gl">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><s:text name="%{#request.titleKey}"/> · <s:text name="app.name"/></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Big+Shoulders+Display:wght@500;700;800;900&family=Hanken+Grotesk:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<header class="top" id="top">
    <div class="wrap">
        <a class="mark" href="<s:url action="inicio"/>">
            <img src="${pageContext.request.contextPath}/img/escudo.png" alt="" width="40" height="40">
            <s:text name="app.name"/>
        </a>
        <button class="burger" id="burger" aria-expanded="false" aria-controls="menu" aria-label="<s:text name="nav.open"/>">
            <svg width="20" height="14" viewBox="0 0 20 14" fill="none" stroke="currentColor" stroke-width="2"><path d="M0 1h20M0 7h20M0 13h20"/></svg>
        </button>
        <nav class="menu" id="menu" aria-label="<s:text name="nav.label"/>">
            <a href="<s:url action="inicio"/>"<s:if test="#request.currentPage == 'inicio'"> class="on" aria-current="page"</s:if>><s:text name="nav.inicio"/></a>
            <a href="<s:url action="plantilla"/>"<s:if test="#request.currentPage == 'plantilla'"> class="on" aria-current="page"</s:if>><s:text name="nav.plantilla"/></a>
            <a href="<s:url action="partidos"/>"<s:if test="#request.currentPage == 'partidos'"> class="on" aria-current="page"</s:if>><s:text name="nav.partidos"/></a>
            <a href="<s:url action="newsletter"/>"<s:if test="#request.currentPage == 'newsletter'"> class="on" aria-current="page"</s:if>><s:text name="nav.newsletter"/></a>
            <a href="<s:url action="contacto"/>"<s:if test="#request.currentPage == 'contacto'"> class="on" aria-current="page"</s:if>><s:text name="nav.contacto"/></a>
        </nav>
    </div>
</header>
