/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Indunil
 */
public class UserAccountStatus_Class {

    private String username;
    private String status;
    private int activate_code;
    private String activated_time_stamp;

    Db_Class db = new Db_Class();

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
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the activate_code
     */
    public int getActivate_code() {
        return activate_code;
    }

    /**
     * @param activate_code the activate_code to set
     */
    public void setActivate_code(int activate_code) {
        this.activate_code = activate_code;
    }

    /**
     * @return the activated_time_stamp
     */
    public String getActivated_time_stamp() {
        return activated_time_stamp;
    }

    /**
     * @param activated_time_stamp the activated_time_stamp to set
     */
    public void setActivated_time_stamp(String activated_time_stamp) {
        this.activated_time_stamp = activated_time_stamp;
    }

    public String accountStatus(String login) throws SQLException {
        String status = null;

        db.getConnection();

        String query = "Select status from userview WHERE username = ? OR email = ?";

        PreparedStatement stmt = db.conn.prepareStatement(query);
        stmt.setString(1, login);
        stmt.setString(2, login);

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            return rs.getString(1);
        }

        db.endConnection();

        return status;
    }

    public boolean ativateAccount(String login, String code) throws SQLException {
        boolean activation = false;
        User_Class user = new User_Class();
        TimeStamp tStamp = new TimeStamp();

        db.getConnection();

        String query = "UPDATE `user_account_status` SET `status`= ?,`activated_time_stamp`= ? WHERE `username`= ? && `activate_code`= ?";

        PreparedStatement stmt = db.conn.prepareStatement(query);
        stmt.setString(1, "Activated");
        stmt.setString(2, tStamp.getTimestamp());
        stmt.setString(3, user.requetUsername(login));
        stmt.setString(4, code);

        int res = stmt.executeUpdate();
        db.endConnection();
        
        if (res > 0) {            
            activation = true;
        } else {
            activation = false;
        }

        return activation;
    }

    public boolean sendActivationCode(String login) throws SQLException {

        boolean sent = false;

        SendMail mail = new SendMail();
        CodeGenerator code = new CodeGenerator();
        User_Class user = new User_Class();
        long activationCode = code.generateActivationCode();

        try {
            db.getConnection();

            String query = "UPDATE user_account_status SET activate_code = " + activationCode + " WHERE username = '" + user.requetUsername(login) + "' AND status = 'Inactive'";

            Statement stmt = db.conn.createStatement();
            //pstmt.setString(1, user.requetUsername(login));

            if (stmt.executeUpdate(query) != 0 && mail.sendActivationCode(user.requetEmail(login), activationCode)) {
                sent = true;
                System.out.println("updated");
            } else {
                sent = false;
                System.out.println("not updated");
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return sent;
    }

    //end of class methods
}
