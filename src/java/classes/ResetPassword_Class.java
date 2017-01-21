/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Indunil
 */
public class ResetPassword_Class {

    private String username;
    private long reasetCode;

    private Db_Class db = new Db_Class();

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the reasetCode
     */
    public long getReasetCode() {
        return reasetCode;
    }

    /**
     * @param reasetCode the reasetCode to set
     */
    public void setReasetCode(long reasetCode) {
        this.reasetCode = reasetCode;
    }

    public boolean resetPassword(String login, long code, String password) {
        boolean reset = false;

        try {
            db.getConnection();

            //System.out.println("[Reset] - Check 1");
            //check weather the combination s correct
            String confirmStart = "SELECT count(*) FROM `reset_password` WHERE `username` = ? AND `reset_code` = ? LIMIT 1";
            PreparedStatement pstmt = db.conn.prepareStatement(confirmStart);
            String un = new User_Class().requetUsername(login);
            pstmt.setString(1, un);
            pstmt.setLong(2, code);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getInt(1) == 0) {
                    //System.out.println("[Reset] - Wrong combination");
                    return false;
                }else{
                    //System.out.println("[Reset] - Check 1 passed");
                }
            }
            //System.out.println("[Reset] - Check 1 OK");

            //System.out.println("[Reset] - Reset");
            //reset password if the combination is correct
            String sql = "call `resetPassword`(?, ?, ?)";
            CallableStatement cstmt = db.conn.prepareCall(sql);
            cstmt.setString(1, login);
            cstmt.setLong(2, code);
            cstmt.setString(3, toMd5(password));

            int queryExecute = cstmt.executeUpdate();
            //System.out.println("[Reset] - Reset OK");

            //System.out.println("[Reset] - Check 2");
            //secondry confirmation
            String confirmEnd = "SELECT count(*) FROM `reset_password` WHERE 'reset_code'= ?";
            PreparedStatement pstmt1 = db.conn.prepareStatement(confirmEnd);
            pstmt1.setLong(1, code);

            ResultSet rs1 = pstmt1.executeQuery();
            while (rs1.next()) {
                reset = rs1.getInt(1) == 0;
            }
            //System.out.println("[Reset] - Check 2 OK");

            if (queryExecute > 0 && reset) {
                //new SendMail().passwordResetMail(login);
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception[" + this.getClass().getName() + "]: " + e.getMessage());
            System.out.println("[Reset] - " + e.getMessage());
            reset = false;
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return reset;
    }

    public boolean addNewCode(String login) throws SQLException {
        boolean sent = false;
        login = new User_Class().requetUsername(login);
        long code = new CodeGenerator().generatePasswordResetCode();

        try {
            db.getConnection();

            String sql = "INSERT INTO `reset_password`(`username`, `reset_code`) VALUES (?,?) ON DUPLICATE KEY UPDATE `reset_code` = ? ";
            PreparedStatement cstmt = db.conn.prepareStatement(sql);
            cstmt.setString(1, login);
            cstmt.setLong(2, code);
            cstmt.setLong(3, code);

            if (cstmt.executeUpdate() > 0) {
                sent = true;
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception[" + this.getClass().getName() + "]: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }

            if (sent) {
                System.out.println("Adding code! [" + login + "," + code + "]");
                sent = emailResetCode(login);
            } else {
                System.out.println("Cannot add the reset code!");
            }
        }

        return sent;
    }

    private boolean emailResetCode(String login) {
        long code = 0;
        boolean sent = true;

        try {
            db.getConnection();

            String sql = "SELECT `reset_code` FROM `reset_password` WHERE `username` = ? LIMIT 1";
            PreparedStatement cstmt = db.conn.prepareStatement(sql);
            cstmt.setString(1, login);

            ResultSet rs = cstmt.executeQuery();
            while (rs.next()) {
                code = rs.getLong(1);
                System.out.println("Sending code! [" + login + "," + code + "]");
            }

            if (code > 0) {
                if (new SendMail().sendPasswordResetCode(login, code)) {
                    System.out.println("Code sent! [" + login + "," + code + "]");
                }
            } else {
                sent = false;
                System.out.println("Cannot send the reset code!");
            }
        } catch (SQLException ex) {
            sent = false;
            System.out.println("Class Exception[" + this.getClass().getName() + "]: " + ex.getMessage());
        }

        return code > 0 && sent;
    }

    private String toMd5(String plainText) {
        String ret = null;

        try {
            MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5");
            mdAlgorithm.update(plainText.getBytes());

            byte[] digest = mdAlgorithm.digest();
            StringBuilder hexString = new StringBuilder();

            for (int i = 0; i < digest.length; i++) {
                plainText = Integer.toHexString(0xFF & digest[i]);

                if (plainText.length() < 2) {
                    plainText = "0" + plainText;
                }

                hexString.append(plainText);
            }

            ret = hexString.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(ResetPassword_Class.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ret;
    }
}
