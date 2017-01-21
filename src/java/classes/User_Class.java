/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Indunil
 */
public class User_Class {

    private String username;
    private String pass;
    private String user_type;
    private String email;
    private String voice;

    public User_Class() {
        //default calss constructor
    }

    //db class object
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
     * @return the pass
     */
    public String getPass() {
        return pass;
    }

    /**
     * @param pass the pass to set
     */
    public void setPass(String pass) {
        this.pass = pass;
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

    //class methods
    /**
     *
     * Returns 'true' if match found for provided login details, both username
     * and email fields consider when finding the user. Returns 'false' in case
     * of no record found.
     *
     * @param login
     * @param pass
     * @return
     * @throws SQLException
     */
    public boolean login(String login, String pass) throws SQLException, NoSuchAlgorithmException {
        boolean x = false;

        db.getConnection();

        String query = "Select count(*) from user WHERE (username = ? AND pass = ?) OR (email = ? AND pass = ?)";

        PreparedStatement stmt = db.conn.prepareStatement(query);
        stmt.setString(1, login);
        stmt.setString(2, toMd5(pass));
        stmt.setString(3, login);
        stmt.setString(4, toMd5(pass));

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int count = Integer.parseInt(rs.getString("count(*)"));

            if (count == 1) {
                x = true;
                System.out.println("User_Class, login | 1 Matching Record Found..");

                UserAccountStatus_Class account = new UserAccountStatus_Class();
                if ("Activated".equals(account.accountStatus(requetUsername(login)))) {
                    UserInfo_Class userInfo = new UserInfo_Class();
                    userInfo.recordLastLogin(requetUsername(login));
                }

            } else {
                x = false;
                System.out.println("User_Class, login | No Matching Record Found..");
            }
        }

        db.endConnection();
        return x;
    }

    /**
     * Returns 'true' if user exist on the DB, otherwise returns 'false'.
     *
     * @param login
     * @return boolean
     * @throws SQLException
     */
    public boolean userValidate(String login) throws SQLException {
        boolean x = false;

        db.getConnection();

        String query = "Select count(*) from user WHERE username = ? OR email = ?";

        PreparedStatement stmt = db.conn.prepareStatement(query);
        stmt.setString(1, login);
        stmt.setString(2, login);

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int count = Integer.parseInt(rs.getString("count(*)"));

            if (count == 1) {
                x = true;
                System.out.println("User_Class, userValidate | 1 Matching Record Found..");
            } else {
                x = false;
                System.out.println("User_Class, userValidate | No Matching Record Found..");
            }
        }

        db.endConnection();

        return x;
    }

    /**
     * Returns username according to provided login.
     *
     * @param login
     * @return
     * @throws SQLException
     */
    public String requetUsername(String login) throws SQLException {
        String username = null;

        if (userValidate(login)) {
            db.getConnection();

            String query = "Select username from user WHERE username = ? OR email = ?";

            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, login);
            stmt.setString(2, login);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                username = rs.getString(1);
                System.out.println("User_Class, requetUsername | 1 Matching Record Found..");
            }

            db.endConnection();
        } else {
            System.out.println("User_Class, requetUsername | User Name Not Exist..");
            return null;
        }

        return username;
    }

    /**
     * Returns email according to provided login.
     *
     * @param login
     * @return
     * @throws SQLException
     */
    public String requetEmail(String login) throws SQLException {
        String email = null;

        if (userValidate(login)) {
            db.getConnection();

            String query = "Select email from user WHERE username = ? OR email = ?";

            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, login);
            stmt.setString(2, login);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                email = rs.getString(1);
                System.out.println("User_Class, requetEmail | 1 Matching Record Found..");
            }

            db.endConnection();
        } else {
            System.out.println("User_Class, requetEmail | Not Exist..");
            return null;
        }

        return email;
    }

    public String requestAccountType(String login) throws SQLException {
        String type = null;

        if (userValidate(login)) {
            db.getConnection();

            String query = "Select user_type from user WHERE username = ? OR email = ?";

            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, login);
            stmt.setString(2, login);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                type = rs.getString(1);
                System.out.println("User_Class, requestAccountType | 1 Matching Record Found..");
            }

            db.endConnection();
        } else {
            System.out.println("User_Class, requestAccountType | Not Exist..");
            return null;
        }

        return type;
    }

    public boolean createAccount(String username, String email, String password) {
        boolean created = false;

        TimeStamp tStamp = new TimeStamp();

        try {
            db.getConnection();

            String createUser = "INSERT INTO `user`(`username`, `pass`, `user_type`, `email`) VALUES (?,?,?,?)";
            String recordUserInfo = "INSERT INTO `user_info`(`username`, `registration`) VALUES (?,?)";
            String recordAccountStatus = "INSERT INTO `user_account_status`(`username`, `status`) VALUES (?,?)";
            String recordCurrentState = "INSERT INTO `user_current_state`(`username`, `Chat`) VALUES (?,?)";

            PreparedStatement createUserStmt = db.conn.prepareStatement(createUser);
            createUserStmt.setString(1, username);
            createUserStmt.setString(2, toMd5(password));
            createUserStmt.setString(3, "Member");
            createUserStmt.setString(4, email);

            PreparedStatement recordUserInfoStmt = db.conn.prepareStatement(recordUserInfo);
            recordUserInfoStmt.setString(1, username);
            recordUserInfoStmt.setString(2, tStamp.getTimestamp());

            PreparedStatement recordAccountStatusStmt = db.conn.prepareStatement(recordAccountStatus);
            recordAccountStatusStmt.setString(1, username);
            recordAccountStatusStmt.setString(2, "Inactive");

            PreparedStatement recordCurrentStateStmt = db.conn.prepareStatement(recordCurrentState);
            recordCurrentStateStmt.setString(1, username);
            recordCurrentStateStmt.setString(2, "Online");

            if (createUserStmt.executeUpdate() > 0 && recordUserInfoStmt.executeUpdate() > 0 && recordAccountStatusStmt.executeUpdate() > 0 && recordCurrentStateStmt.executeUpdate() > 0) {
                UserAccountStatus_Class account = new UserAccountStatus_Class();

                created = true;
                return true;
            } else {
                created = false;
                return false;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return created;
    }

    //end of class methods
    public boolean updateContactNumber(String login, String number) {
        boolean updated = false;

        try {
            db.getConnection();

            String query = "UPDATE `user` SET `voice`= ? WHERE `username` = ? OR `email` = ?";

            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, number);
            stmt.setString(2, login);
            stmt.setString(3, login);

            if (stmt.executeUpdate() > 0) {
                updated = true;
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception[" + this.getClass().getName() + "]: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return updated;
    }

    public boolean changePassword(String login, String oldPass, String newPass) {
        boolean updated = false;

        try {
            db.getConnection();

            String query = "UPDATE `user` SET `pass`= ? WHERE (`username` = ? OR `email` = ?) AND `pass` = ?";

            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, toMd5(newPass));
            stmt.setString(2, login);
            stmt.setString(3, login);
            stmt.setString(4, toMd5(oldPass));

            if (stmt.executeUpdate() > 0) {
                updated = true;
            }

            db.endConnection();
        } catch (SQLException e) {
            System.out.println("Class Exception[" + this.getClass().getName() + "]: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return updated;
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
