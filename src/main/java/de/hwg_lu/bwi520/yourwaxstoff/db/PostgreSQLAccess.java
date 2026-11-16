package de.hwg_lu.bwi520.yourwaxstoff.db;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class PostgreSQLAccess extends JDBCAccess {

    protected String dbSchema;

    public PostgreSQLAccess() throws SQLException {
        super();
    }

    @Override
    protected void setDBParameter() {
        Properties props = new Properties();
        try (InputStream in = getClass().getClassLoader().getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new RuntimeException("db.properties nicht im Classpath gefunden");
            }
            props.load(in);
        } catch (IOException e) {
            throw new RuntimeException("db.properties konnte nicht gelesen werden: " + e.getMessage(), e);
        }

        this.dbDrivername = "org.postgresql.Driver";
        this.dbServer     = props.getProperty("db.server");
        this.dbPort       = props.getProperty("db.port");
        this.dbName       = props.getProperty("db.name");
        this.dbUserid     = props.getProperty("db.user");
        this.dbPassword   = props.getProperty("db.password");
        this.dbSchema     = props.getProperty("db.schema");
    }

    @Override
    protected void setSchema() throws SQLException {
        Statement stmt = dbConn.createStatement();
        stmt.execute("set schema '" + dbSchema + "'");
        System.out.println("Schema gesetzt auf: " + dbSchema);
    }

    public static void main(String[] args) throws SQLException {
        new PostgreSQLAccess();
    }
}