/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Indunil
 */
public class UserMessages_Class {

    private int message_id;
    private String msg_from;
    private String msg_to;
    private String content;
    private String time_stamp;

    Db_Class db = new Db_Class();

    /**
     * @return the message_id
     */
    public int getMessage_id() {
        return message_id;
    }

    /**
     * @param message_id the message_id to set
     */
    public void setMessage_id(int message_id) {
        this.message_id = message_id;
    }

    /**
     * @return the msg_from
     */
    public String getMsg_from() {
        return msg_from;
    }

    /**
     * @param msg_from the msg_from to set
     */
    public void setMsg_from(String msg_from) {
        this.msg_from = msg_from;
    }

    /**
     * @return the msg_to
     */
    public String getMsg_to() {
        return msg_to;
    }

    /**
     * @param msg_to the msg_to to set
     */
    public void setMsg_to(String msg_to) {
        this.msg_to = msg_to;
    }

    /**
     * @return the content
     */
    public String getContent() {
        return content;
    }

    /**
     * @param content the content to set
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * @return the time_stamp
     */
    public String getTime_stamp() {
        return time_stamp;
    }

    /**
     * @param time_stamp the time_stamp to set
     */
    public void setTime_stamp(String time_stamp) {
        this.time_stamp = time_stamp;
    }

    public int unreadMessagesCount(String login) throws SQLException {
        int count = 0;

        User_Class user = new User_Class();

        if (user.userValidate(login)) {
            String username = user.requetUsername(login);
            db.getConnection();

            String query = "SELECT COUNT(*) FROM messageview WHERE msg_to = ? AND read_state = 0";

            PreparedStatement pstmt = db.conn.prepareStatement(query);
            pstmt.setString(1, username);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                count = rs.getInt(1);
            }

            db.endConnection();
        }

        return count;
    }

    public boolean sendMessage(String sender, String receiver, String message) throws SQLException {
        boolean sent = false;

        TimeStamp tStamp = new TimeStamp();
        String stamp = tStamp.getTimestamp();

        try {
            db.getConnection();

            String sql = "call `sendMessage`(?, ?, ?, ?)";
            CallableStatement cstmt = db.conn.prepareCall(sql);
            cstmt.setString(1, sender);
            cstmt.setString(2, receiver);
            cstmt.setString(3, message);
            cstmt.setString(4, stamp);

            if (cstmt.executeUpdate() > 0) {
                System.out.println("Message Sent!");
                sent = true;
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        }

        return sent;
    }

    public boolean deleteConversation(String user, String otherParty) {
        boolean deleted = true;

        try {
            db.getConnection();

            //delete inbox
            String sql1 = "call `getInbox`(?, ?)";

            CallableStatement inbox = db.conn.prepareCall(sql1);
            inbox.setString(1, user);
            inbox.setString(2, otherParty);

            ResultSet rs = inbox.executeQuery();

            while (rs.next()) {
                String query = "DELETE FROM `user_messages_inbox` WHERE `message_id` = " + rs.getInt(1);
                Statement stmt = db.conn.createStatement();
                stmt.executeUpdate(query);
            }

            //delete outbox
            String sql2 = "call `getOutbox`(?, ?)";

            CallableStatement outbox = db.conn.prepareCall(sql2);
            outbox.setString(1, otherParty);
            outbox.setString(2, user);

            ResultSet rs1 = outbox.executeQuery();

            while (rs1.next()) {
                String query = "DELETE FROM `user_messages_outbox` WHERE `message_id` = " + rs1.getInt(1);
                Statement stmt = db.conn.createStatement();
                stmt.executeUpdate(query);
            }

            db.endConnection();
        } catch (Exception e) {
            deleted = false;
            System.out.println("Class Exception[" + this.getClass().getName() + "]: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return deleted;
    }

}
