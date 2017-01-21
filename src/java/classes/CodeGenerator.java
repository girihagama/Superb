/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Indunil
 */
public class CodeGenerator {

    Db_Class db = new Db_Class();

    /**
     * Generates and returns unique Activation Code
     *
     * @return
     * @throws SQLException
     */
    public long generateActivationCode() throws SQLException {
        long code = newCode();
        boolean unique = false;

        db.getConnection();

        while (unique) {
            String query = "Select count(*) from user_account_status WHERE activate_code = '" + code + "'";

            Statement stmt = db.conn.createStatement();

            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                if (0 == rs.getInt(1)) {
                    unique = true;
                } else {
                    code = newCode();
                    unique = false;
                }
            }
        }

        db.endConnection();

        return code;
    }

    public long generatePasswordResetCode() throws SQLException {
        long code = newCode();
        boolean unique = false;

        db.getConnection();

        while (unique) {
            String query = "SELECT count(*) FROM `reset_password` WHERE `reset_code` = '" + code + "'";

            Statement stmt = db.conn.createStatement();

            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                if (0 == rs.getInt(1)) {
                    unique = true;
                } else {
                    code = newCode();
                    unique = false;
                }
            }
        }

        db.endConnection();

        return code;
    }

    /**
     * Generates 9 Digit (long) Code.
     *
     * @return
     */
    private long newCode() {
        long Min = 100000000;
        long Max = 999999999;

        long code = Min + (int) (Math.random() * ((Max - Min) + 1));
        return code;
    }

}
