<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.WaxstoffBean" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.BewertungBean" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.KundeBean" %>

<%@ include file="header.jspf" %>

<%
    int waxstoffId = Integer.parseInt(request.getParameter("waxstoffId"));

    WaxstoffBean waxstoffBean = new WaxstoffBean();
    boolean gefunden = waxstoffBean.ladeAusDB(waxstoffId);
%>

<% if (!gefunden) { %>
    <p style="padding:2rem;">Dieser Artikel wurde nicht gefunden.</p>
<% } else { %>


    <div class="detail-page">
        <div class="image-col">
            <img src="../<%= waxstoffBean.getBildPfad() %>" alt="<%= waxstoffBean.getName() %>">
        </div>
        <div class="info-col">
            <h1><%= waxstoffBean.getName() %></h1>
            <p class="beschreibung"><%= waxstoffBean.getBeschreibung() %></p>

      
            <p class="ts"><strong>Material:</strong> <%= waxstoffBean.getMaterial() %></p>
            <p class="ts"><strong>Pflegehinweis:</strong> <%= waxstoffBean.getPflegehinweis() %></p>
            <p class="ts"><strong>Herkunft:</strong> <%= waxstoffBean.getHerkunft() %></p>

            <div class="price"><%= waxstoffBean.getPreis() %> €</div>
            <% if (eingeloggterKunde == null) { %>
                <button class="btn-primary" onclick="openPopup('login-popup')">
                    Zum Bestellen anmelden
                </button>
            <% } else if (waxstoffBean.isIstFertig()) { %>
             
                <a class="btn-primary" href="BestellungAppl.jsp?action=fertigAuswaehlen&waxstoffId=<%= waxstoffId %>">
                    Bestellen
                </a>
            <% } else { %>

                <button class="btn-primary" onclick="vorSchneidenFragen(<%= waxstoffId %>)">
                    Bestellen
                </button>
            <% } %>

            <h2 style="margin-top:2rem;">Bewertungen</h2>
            <%

                BewertungBean bewertungBean = new BewertungBean();
                out.println(bewertungBean.getBewertungenAlsHtml("waxstoff", waxstoffId));
            %>
        </div>
    </div>

<% } %>


<div id="schneiden-popup" class="popup-overlay hidden">
    <div class="popup-box">
        <h2>Willst du das schneiden lassen?</h2>
        <div class="popup-actions">
            <button class="btn-primary" onclick="schneidenJa()">Ja</button>
            <button class="btn-secondary" onclick="schneidenNein()">Nein</button>
        </div>
    </div>
</div>

<%@ include file="footer.jspf" %>