<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.WaxstoffBean" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.ModellBean" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.BestellungBean" %>
<%@ page import="de.hwg_lu.bwi520.yourwaxstoff.beans.KundeBean" %>
<%


    String action = request.getParameter("action");

    if ("schneidereiAuswahl".equals(action)) {
      
%>
        <jsp:forward page="SchneidereiAuswahlView.jsp" />  
<%
    } else if ("waxstoffAuswaehlen".equals(action)) {
        request.setAttribute("typ", "waxstoff");
%>
        <jsp:forward page="BestellFormularView.jsp" />
<%
    } else if ("fertigAuswaehlen".equals(action)) {
        request.setAttribute("typ", "fertig");
%>
        <jsp:forward page="BestellFormularView.jsp" />
<%
    } else if ("abschliessen".equals(action)) {
      
        KundeBean eingeloggterKunde = (KundeBean) session.getAttribute("eingeloggterKunde");

        if (eingeloggterKunde == null) {
            response.sendRedirect("StartseiteView.jsp?bitteEinloggen=1");
        } else {

        String typ = request.getParameter("typ");

        String waxstoffIdParam = request.getParameter("waxstoffId");
        Integer waxstoffId = (waxstoffIdParam != null && !waxstoffIdParam.isEmpty())  
                              ? Integer.valueOf(waxstoffIdParam) : null;

        String mengeParam = request.getParameter("menge");
        double menge = (mengeParam != null && !mengeParam.isEmpty())
                        ? Double.parseDouble(mengeParam) : 1;

        WaxstoffBean waxstoffBean = new WaxstoffBean();
        waxstoffBean.ladeAusDB(waxstoffId);
        double einzelpreis = waxstoffBean.getPreis();

        // Kontaktdaten kommen aus der Session - kein Formularfeld
        // dafür mehr nötig.
        BestellungBean bestellungBean = new BestellungBean();
        bestellungBean.setKundeId(eingeloggterKunde.getKundeId());
        bestellungBean.setVorname(eingeloggterKunde.getVorname());
        bestellungBean.setNachname(eingeloggterKunde.getNachname());
        bestellungBean.setEmail(eingeloggterKunde.getEmail());
        bestellungBean.setAdresse(eingeloggterKunde.getAdresse());
        bestellungBean.setZahlungsmethode(request.getParameter("zahlungsmethode"));
        bestellungBean.erstelleBestellung();

        int neuePositionId = bestellungBean.fuegePosition(typ, waxstoffId, null, null, menge, einzelpreis);

        response.sendRedirect("BestellBestaetigungView.jsp?bestellnummer=" + bestellungBean.getBestellungId()
                             + "&positionId=" + neuePositionId);
        }

    } else if ("schneidereiBestellen".equals(action)) { // bei ja

        KundeBean eingeloggterKunde = (KundeBean) session.getAttribute("eingeloggterKunde");

        if (eingeloggterKunde == null) {
            response.sendRedirect("StartseiteView.jsp?bitteEinloggen=1");
        } else {

        int waxstoffId = Integer.parseInt(request.getParameter("waxstoffId"));

        BestellungBean bestellungBean = new BestellungBean();
        bestellungBean.setKundeId(eingeloggterKunde.getKundeId());
        bestellungBean.setVorname(eingeloggterKunde.getVorname());
        bestellungBean.setNachname(eingeloggterKunde.getNachname());
        bestellungBean.setEmail(eingeloggterKunde.getEmail());
        bestellungBean.setAdresse(eingeloggterKunde.getAdresse());
        bestellungBean.setZahlungsmethode(request.getParameter("zahlungsmethode"));
        bestellungBean.erstelleBestellung();

        int letztePositionId = 0;

        for (int modellId = 1; modellId <= 8; modellId++) {
            String checkboxWert = request.getParameter("modell_check_" + modellId);

            if (checkboxWert != null) {
                // Diese Checkbox war angekreuzt -> Position anlegen

                String groesseParam = request.getParameter("groesse_" + modellId);
                Integer groesseId = (groesseParam != null && !groesseParam.isEmpty())
                                     ? Integer.valueOf(groesseParam) : null;

                String mengeParam = request.getParameter("menge_" + modellId);
                double menge = (mengeParam != null && !mengeParam.isEmpty())
                                ? Double.parseDouble(mengeParam) : 1;

                ModellBean modellBean = new ModellBean();
                modellBean.ladeAusDB(modellId);

                letztePositionId = bestellungBean.fuegePosition("schneiderei", waxstoffId, modellId,
                                                                  groesseId, menge, modellBean.getPreis());
            }
        }

        response.sendRedirect("BestellBestaetigungView.jsp?bestellnummer=" + bestellungBean.getBestellungId()
                             + "&positionId=" + letztePositionId);
        }
    }
%>