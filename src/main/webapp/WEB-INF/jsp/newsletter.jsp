<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="currentPage" value="'newsletter'" scope="request"/>
<s:set var="titleKey" value="'nav.newsletter'" scope="request"/>
<jsp:include page="common/header.jsp"/>

<main class="news news-page">
    <section aria-labelledby="h-news" style="width:100%">
        <div class="wrap">
            <div>
                <h2 class="sec" id="h-news"><s:text name="newsletter.title"/></h2>
                <p><s:text name="newsletter.text"/></p>
            </div>
            <div>
                <%-- Sin funcionalidad: el envío se simula en js/newsletter.js --%>
                <form id="newsForm" novalidate
                      data-error-invalid="<s:text name="newsletter.error.invalid"/>"
                      data-error-empty="<s:text name="newsletter.error.empty"/>"
                      data-sending="<s:text name="newsletter.sending"/>">
                    <label class="lbl" for="email"><s:text name="newsletter.email.label"/></label>
                    <div class="inrow">
                        <input type="email" id="email" name="email" placeholder="<s:text name="newsletter.email.placeholder"/>" autocomplete="email" aria-describedby="newsMsg">
                        <button class="btn btn-purple" type="submit" id="newsBtn"><span class="spinner" hidden></span><span class="lbl-t"><s:text name="newsletter.submit"/></span></button>
                    </div>
                    <p class="msg" id="newsMsg" aria-live="polite"></p>
                </form>
                <div class="done" id="newsDone" hidden role="status">
                    <h3><s:text name="newsletter.done.title"/></h3>
                    <p><s:text name="newsletter.done.text"/></p>
                </div>
            </div>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/newsletter.js"></script>
