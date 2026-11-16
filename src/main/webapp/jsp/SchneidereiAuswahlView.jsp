<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.ModellBean" %>
<%@ include file="header.jspf" %>

<%
    int waxstoffId = Integer.parseInt(request.getParameter("waxstoffId"));
    Object eingeloggtesObjekt = session.getAttribute("eingeloggterKunde");
%>

<% if (eingeloggtesObjekt == null) { %>
    <div class="confirmation-box">
        <h1>Bitte zuerst anmelden</h1>
        <p>Um eine Schneiderei-Bestellung aufzugeben, musst du eingeloggt sein.</p>
        <button class="btn-primary" onclick="openPopup('login-popup')">Anmelden</button>
    </div>
<% } else { %>

    <h1 class="schneiderei-title">Wie willst du gerne schneiden?</h1>
    <p style="text-align:center; color:var(--color-text);">
        Du kannst mehrere Modelle gleichzeitig auswählen.
    </p>

    <form method="post" action="BestellungAppl.jsp" onsubmit="return pruefeMehrfachauswahl()">
        <input type="hidden" name="action" value="schneidereiBestellen">
        <input type="hidden" name="waxstoffId" value="<%= waxstoffId %>">

        <%
            ModellBean modellBean = new ModellBean();
            out.println(modellBean.getModelleZweispaltigAlsHtml());
        %>

        <div class="form-container" style="max-width:400px;">
            <div class="form-group">
                <label for="zahlungsmethode">Zahlungsmethode</label>
                <select id="zahlungsmethode" name="zahlungsmethode" required>
                    <option value="Karte">Karte</option>
                    <option value="PayPal">PayPal</option>
                </select>
            </div>
            <button type="submit" class="btn-primary" style="width:100%;">Jetzt bestellen</button>
        </div>
    </form>

<% } %>

<%@ include file="footer.jspf" %>