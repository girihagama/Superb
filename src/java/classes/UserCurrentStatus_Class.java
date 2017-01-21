/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Indunil
 */
public class UserCurrentStatus_Class {

    private String username;
    private String lastSeen;
    private String chat;

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
     * @return the lastSeen
     */
    public String getLastSeen() {
        return lastSeen;
    }

    /**
     * @param lastSeen the lastSeen to set
     */
    public void setLastSeen(String lastSeen) {
        this.lastSeen = lastSeen;
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

    //class methods
    public boolean updateChat(String login) throws SQLException {
        boolean updated = false;

        User_Class user = new User_Class();
        TimeStamp tStamp = new TimeStamp();

        if (user.userValidate(login)) {
            String username = user.requetUsername(login);

            db.getConnection();
            String query = "UPDATE `user_current_state` SET `last_seen`= ? WHERE username= ? AND chat='Online'";
            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, tStamp.getTimestamp());
            stmt.setString(2, username);

            if (stmt.executeUpdate() != 0) {
                updated = true;
            }

            db.endConnection();
        }

        System.out.println("UserCurrentStatus_Class, update chat | update :" + updated);
        return updated;
    }

    public String currentStatus(String login) throws SQLException {
        String status = null;

        User_Class user = new User_Class();

        if (user.userValidate(login)) {
            String username = user.requetUsername(login);

            db.getConnection();

            String query = "SELECT `Chat` FROM `user_current_state` WHERE `username` = ? LIMIT 1";

            PreparedStatement stmt = db.conn.prepareStatement(query);
            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                status = rs.getString(1);
            }

            db.endConnection();
        }
        return status;
    }

    public boolean toggleChatOnline(String login) {
        boolean updated = false;

        User_Class user = new User_Class();

        try {
            if (user.userValidate(login)) {
                String username = user.requetUsername(login);
                db.getConnection();
                String query = "UPDATE `user_current_state` SET `Chat`= 'Online' WHERE `username` = ?";

                PreparedStatement stmt = db.conn.prepareStatement(query);
                stmt.setString(1, username);

                if (stmt.executeUpdate() != 0) {
                    updated = true;
                }
            } else {
                updated = false;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            updated = false;
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        System.out.println("UserCurrentStatus_Class, toggleChatOnline | update : " + updated);
        return updated;
    }

    public boolean toggleChatOffline(String login) {
        boolean updated = false;

        User_Class user = new User_Class();

        try {
            if (user.userValidate(login)) {
                String username = user.requetUsername(login);
                db.getConnection();
                String query = "UPDATE `user_current_state` SET `Chat`= 'Offline' WHERE `username` = ?";

                PreparedStatement stmt = db.conn.prepareStatement(query);
                stmt.setString(1, username);

                if (stmt.executeUpdate() != 0) {
                    updated = true;
                }
            } else {
                updated = false;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            updated = false;
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        System.out.println("UserCurrentStatus_Class, toggleChatOffline | update : " + updated);
        return updated;
    }
    
    public long timeDifference(String login) throws ParseException, SQLException {
        String currentTime;
        
        long x = 0;

        TimeStamp time = new TimeStamp();
        currentTime = time.getTimestamp();

        //Date d1 = convertTo24DateObject(currentTime);
        Date d1 = convertTo24DateObject(currentTime);
        Date d2 = convertTo24DateObject(memberLastSeenTimestamp(login));

        x = (d1.getTime() - d2.getTime()) / 1000;

        return x+1;
    }

    public Date convertTo24DateObject(String timestamp) throws ParseException {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date dateTime = format.parse(timestamp);
        return dateTime;
    }
    
    public String memberLastSeenTimestamp(String login) throws SQLException{
        String seen = null;
        String username = null;
        
        User_Class user=new User_Class();
        username = user.requetUsername(login);
        
        try{
            
            String query = "SELECT `last_seen` FROM `user_current_state` WHERE `username` = ?";
            
            db.getConnection();
            
            PreparedStatement pstmt = db.conn.prepareStatement(query);
            pstmt.setString(1, login);
            
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()){
                seen = rs.getString(1);
            }
        
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            db.endConnection();
        }
        
        
        System.out.println("UserCurrentStatus_Class, memberLastSeenTimestamp | time : " + seen);
        return seen;
    }

    //class methods end    
}
