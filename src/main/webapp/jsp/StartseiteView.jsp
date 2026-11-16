<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.WaxstoffBean" %>
<%@ include file="header.jspf" %>

<%
    String typ = request.getParameter("typ");
    if (typ == null) { typ = "alle"; }

    String geschlecht = request.getParameter("geschlecht");
    if (geschlecht == null) { geschlecht = "alle"; }

    String sortierung = request.getParameter("sortierung");
    if (sortierung == null) { sortierung = "keine"; }
%>

<form class="filter-bar" method="get" action="StartseiteView.jsp">
    <select name="typ">
        <option value="alle"     <%= "alle".equals(typ) ? "selected" : "" %>>Alle Artikel</option>
        <option value="waxstoff" <%= "waxstoff".equals(typ) ? "selected" : "" %>>Nur Waxstoffe</option>
        <option value="fertig"   <%= "fertig".equals(typ) ? "selected" : "" %>>Nur fertige Waxstoffe</option>
    </select>

    <select name="geschlecht">
        <option value="alle"   <%= "alle".equals(geschlecht) ? "selected" : "" %>>Alle</option>
        <option value="Herren" <%= "Herren".equals(geschlecht) ? "selected" : "" %>>Nur Herren</option>
        <option value="Damen"  <%= "Damen".equals(geschlecht) ? "selected" : "" %>>Nur Damen</option>
    </select>

    <select name="sortierung">
        <option value="keine"     <%= "keine".equals(sortierung) ? "selected" : "" %>>Sortierung</option>
        <option value="preisAsc"  <%= "preisAsc".equals(sortierung) ? "selected" : "" %>>Preis aufsteigend</option>
        <option value="preisDesc" <%= "preisDesc".equals(sortierung) ? "selected" : "" %>>Preis absteigend</option>
    </select>

    <button type="submit">Filtern</button>
</form>

<%
    WaxstoffBean waxstoffBean = new WaxstoffBean();
    out.println(waxstoffBean.getKatalogAlsHtml(typ, geschlecht, sortierung));
%>

<%@ include file="footer.jspf" %>
<%-- footer.jspf bindet script.js ein und schliesst </body></html> --%>