<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jspf" %>

<%
    String positionId = request.getParameter("positionId");
%>

<h1 style="text-align:center; margin-top:2rem;">Wie war dein Einkauf?</h1>

<form class="form-container" method="post" action="BewertungAppl.jsp">
    <input type="hidden" name="action" value="speichern">
    <input type="hidden" name="positionId" value="<%= positionId %>">


    <input type="hidden" name="artikelBewertungValue" id="artikelBewertungValue" value="0">
    <input type="hidden" name="bestellprozessBewertungValue" id="bestellprozessBewertungValue" value="0">

    <div class="form-group">
        <label>Wie war der Artikel?</label>

        <div class="star-rating" id="artikelBewertung">
            <span class="star" onclick="sterneSetzen('artikelBewertung', 1)">&#9733;</span>
            <span class="star" onclick="sterneSetzen('artikelBewertung', 2)">&#9733;</span>
            <span class="star" onclick="sterneSetzen('artikelBewertung', 3)">&#9733;</span>
            <span class="star" onclick="sterneSetzen('artikelBewertung', 4)">&#9733;</span>
            <span class="star" onclick="sterneSetzen('artikelBewertung', 5)">&#9733;</span>
        </div>
    </div>

    <div class="form-group">
        <label>Wie hast du den Bestellprozess gefunden?</label>
        <div class="star-rating" id="bestellprozessBewertung">
            <span class="star" onclick="sterneSetzen('bestellprozessBewertung', 1)">&#9733;</span>
            <span class="star" onclick="sterneSetzen('bestellprozessBewertung', 2)">&#9733;</span>
            <span class="star" onclick="sterneSetzen('bestellprozessBewertung', 3)">&#9733;</span>
            <span class="star" onclick="sterneSetzen('bestellprozessBewertung', 4)">&#9733;</span>
            <span class="star" onclick="sterneSetzen('bestellprozessBewertung', 5)">&#9733;</span>
        </div>
    </div>

    <div class="form-group">
        <label for="kommentar">Kommentar (optional)</label>
        <textarea id="kommentar" name="kommentar" rows="4"></textarea>
    </div>

    <button type="submit" class="btn-primary" style="width:100%;">Bewertung abschicken</button>
</form>

<%@ include file="footer.jspf" %>