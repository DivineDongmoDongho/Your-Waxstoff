<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.BestellungBean" %>



<%@ include file="header.jspf" %>

<h1 style="text-align:center; margin-top:2rem;">Bestellung verfolgen</h1>

<form class="form-container" method="get" action="BestellungVerfolgenView.jsp">
    <div class="form-group">
        <label for="bestellnummer">Deine Bestellnummer</label>
        <input type="number" id="bestellnummer" name="bestellnummer"
               value="<%= request.getParameter("bestellnummer") == null ? "" : request.getParameter("bestellnummer") %>"
               required>
    </div>
    <button type="submit" class="btn-primary" style="width:100%;">Bestellung anzeigen</button>
</form>

<%
    String bestellnummerParam = request.getParameter("bestellnummer");
    if (bestellnummerParam != null && !bestellnummerParam.isEmpty()) {
        int bestellnummer = Integer.parseInt(bestellnummerParam);

        BestellungBean bestellungBean = new BestellungBean();

   
        String artikelHtml = bestellungBean.getBestellungAlsHtml(bestellnummer);

        if (artikelHtml == null) {
%>
            <div class="confirmation-box">
                <p>Es wurde keine Bestellung mit der Nummer WX-<%= bestellnummer %> gefunden.</p>
            </div>
<%
        } else {
%>
            <div class="confirmation-box" style="text-align:left;">
                <h2>Bestellung WX-<%= bestellnummer %></h2>
                <div class="lieferhinweis">
                    Lieferung kommt spätestens am Ende der Woche an
                </div>
            </div>
<%
        }
    }
%>

<%@ include file="footer.jspf" %>