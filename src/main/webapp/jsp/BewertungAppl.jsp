<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.BewertungBean" %>
<%

    String action = request.getParameter("action");

    if ("speichern".equals(action)) {
        BewertungBean bewertungBean = new BewertungBean();
        bewertungBean.setPositionId(Integer.parseInt(request.getParameter("positionId")));
        bewertungBean.setArtikelBewertung(Integer.parseInt(request.getParameter("artikelBewertungValue")));
        bewertungBean.setBestellprozessBewertung(Integer.parseInt(request.getParameter("bestellprozessBewertungValue")));
        bewertungBean.setKommentar(request.getParameter("kommentar"));
        bewertungBean.speichereBewertung();
%>
<%@ include file="header.jspf" %>
        <div class="confirmation-box">
            <h1>Danke für deine Bewertung!</h1>
            <a class="btn-primary" href="StartseiteView.jsp">Zurück zur Startseite</a>
        </div>
<%@ include file="footer.jspf" %>
<%
    }
%>