<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="header.jspf" %>

<%

    String bestellnummer = request.getParameter("bestellnummer");
    String positionId = request.getParameter("positionId");
%>

<div class="confirmation-box">
    <h1>Bestellung erfolgreich!</h1>
    <p>Vielen Dank für deine Bestellung.</p>
    <div class="bestellnummer">Bestellnummer: WX-<%= bestellnummer %></div>

    <a class="btn-primary" href="BewertungAbgebenView.jsp?positionId=<%= positionId %>">
        Jetzt bewerten
    </a>
    <br><br>
    <a class="btn-secondary" href="StartseiteView.jsp">Weiter einkaufen</a>
</div>

<%@ include file="footer.jspf" %>