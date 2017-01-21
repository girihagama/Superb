/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Indunil
 */
public class UserInfo_Class {
    private String username;
    private String status;
    private String activationCode;
    private String activated_time_stamp;
    
    Db_Class db=new Db_Class();

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
     * @return the activationCode
     */
    public String getActivationCode() {
        return activationCode;
    }

    /**
     * @param activationCode the activationCode to set
     */
    public void setActivationCode(String activationCode) {
        this.activationCode = activationCode;
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
    
    public boolean recordLastLogin(String login) throws SQLException {
        User_Class user=new User_Class();
        
        if (user.userValidate(login)) {
            db.getConnection();
            TimeStamp tStamp = new TimeStamp();

            String query = "UPDATE `user_info` SET `last_login`= ? WHERE `username`= ?";

            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, tStamp.getTimestamp());
            stmt.setString(2, login);
            
            int res = stmt.executeUpdate();
            
            db.endConnection();

            if (res > 0) {
                System.out.println("UserInfo_Class, recordLastLogin | Record : true");
                return true;
            } else {
                System.out.println("UserInfo_Class, recordLastLogin | Record : false");
                return false;
            }                  
        } else {
            System.out.println("UserInfo_Class, recordLastLogin | Record : false");
            return false;
        }
    }
}
