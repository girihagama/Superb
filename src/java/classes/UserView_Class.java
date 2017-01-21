/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Indunil
 */
public class UserView_Class {

    private String username;
    private String password;
    private String user_type;
    private String email;
    private String voice;
    private String status;
    private String activate_code;
    private String activated_time_stamp;
    private String registration;
    private String last_login;
    private int total_ads;
    private String last_seen;
    private String chat;

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
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the user_type
     */
    public String getUser_type() {
        return user_type;
    }

    /**
     * @param user_type the user_type to set
     */
    public void setUser_type(String user_type) {
        this.user_type = user_type;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the voice
     */
    public String getVoice() {
        return voice;
    }

    /**
     * @param voice the voice to set
     */
    public void setVoice(String voice) {
        this.voice = voice;
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
    public String getActivate_code() {
        return activate_code;
    }

    /**
     * @param activate_code the activate_code to set
     */
    public void setActivate_code(String activate_code) {
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

    /**
     * @return the registration
     */
    public String getRegistration() {
        return registration;
    }

    /**
     * @param registration the registration to set
     */
    public void setRegistration(String registration) {
        this.registration = registration;
    }

    /**
     * @return the last_login
     */
    public String getLast_login() {
        return last_login;
    }

    /**
     * @param last_login the last_login to set
     */
    public void setLast_login(String last_login) {
        this.last_login = last_login;
    }

    /**
     * @return the total_ads
     */
    public int getTotal_ads() {
        return total_ads;
    }

    /**
     * @param total_ads the total_ads to set
     */
    public void setTotal_ads(int total_ads) {
        this.total_ads = total_ads;
    }

    /**
     * @return the last_seen
     */
    public String getLast_seen() {
        return last_seen;
    }

    /**
     * @param last_seen the last_seen to set
     */
    public void setLast_seen(String last_seen) {
        this.last_seen = last_seen;
    }

    /**
     * @return the chat
     */
    public String getChat() {
        return chat;
    }

    /**
     * @param chat the chat to set
     */
    public void setChat(String chat) {
        this.chat = chat;
    }

    public List loadProfile(String login) {
        List profile = new ArrayList();

        try {
            db.getConnection();

            String query = "Select * from userview WHERE username = ? OR email = ?";

            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, login);
            stmt.setString(2, login);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                profile.add(rs.getString("username"));
                profile.add(rs.getString("user_type"));
                profile.add(rs.getString("email"));
                profile.add(rs.getString("voice"));
                profile.add(rs.getString("registration"));
                profile.add(rs.getString("last_login"));
                profile.add(rs.getInt("total_ads"));
                profile.add(rs.getString("Chat"));
            }

            db.endConnection();

        } catch (SQLException e) {
            System.out.println("Class Exception[" + this.getClass().getName() + "]: " + e.getMessage());
        } catch (NumberFormatException e) {
            System.out.println("Class Exception[" + this.getClass().getName() + "]: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return profile;
    }
}
