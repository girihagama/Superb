/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Indunil
 */
public class MessageView_Class {

    private int message_id;
    private String msg_from;
    private String msg_to;
    private String content;
    private String time_stamp;
    private String sender;
    private int readState;
    private String receiver;

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

    /**
     * @return the sender
     */
    public String getSender() {
        return sender;
    }

    /**
     * @param sender the sender to set
     */
    public void setSender(String sender) {
        this.sender = sender;
    }

    /**
     * @return the readState
     */
    public int getReadState() {
        return readState;
    }

    /**
     * @param readState the readState to set
     */
    public void setReadState(int readState) {
        this.readState = readState;
    }

    /**
     * @return the receiver
     */
    public String getReceiver() {
        return receiver;
    }

    /**
     * @param receiver the receiver to set
     */
    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    //class methods
    /**
     * Method returns the username list according to the current user of the
     * messages table.
     *
     * @param login
     * @return
     * @throws java.sql.SQLException
     */
    public List chatHeads(String login) throws SQLException {
        List users = new ArrayList();

        try {
            login = new User_Class().requetUsername(login);

            String sql = "SELECT distinct msg_to,msg_from FROM `messageview` WHERE (msg_to = ? AND sender is not null) OR (msg_from = ? AND receiver is not null) ORDER BY time_stamp DESC";

            db.getConnection();

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setString(1, login);
            pstmt.setString(2, login);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                if (!(rs.getString(1).equalsIgnoreCase(login))) {

                    String username = rs.getString(1);
                    boolean userExist = false;

                    for (Object user : users) {
                        if (user.toString().equalsIgnoreCase(username)) {
                            userExist = true;
                        }
                    }

                    if (!userExist) {
                        users.add(rs.getString(1));
                    }

                } else if (!(rs.getString(2).equalsIgnoreCase(login))) {

                    String username = rs.getString(2);
                    boolean userExist = false;

                    for (Object user : users) {
                        if (user.toString().equalsIgnoreCase(username)) {
                            userExist = true;
                        }
                    }

                    if (!userExist) {
                        users.add(rs.getString(2));
                    }

                }
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
            users = null;
        }

        return users;
    }

    public ArrayList conversation(String receiver, String sender, int limit, int offset) {
        ArrayList conversation = null;

        try {
            String sql = "SELECT * FROM `messageview` WHERE ((msg_from = ? AND msg_to = ? AND receiver IS NOT NULL) OR (msg_to = ? AND msg_from = ? AND sender IS NOT NULL)) ORDER BY time_stamp, message_id ASC LIMIT ? OFFSET ?";

            db.getConnection();

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setString(1, receiver);
            pstmt.setString(2, sender);
            pstmt.setString(3, receiver);
            pstmt.setString(4, sender);
            pstmt.setInt(5, limit);
            pstmt.setInt(6, offset);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                MessageView_Class msg = new MessageView_Class();

                msg.setMessage_id(rs.getInt("message_id"));
                msg.setMsg_to(rs.getString("msg_to"));
                msg.setMsg_from(rs.getString("msg_from"));
                msg.setContent(rs.getString("content"));
                msg.setTime_stamp(rs.getString("time_stamp"));
                msg.setSender(rs.getString("sender"));
                msg.setReadState(rs.getInt("read_state"));
                msg.setReceiver(rs.getString("receiver"));

                conversation.add(msg);
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        }

        return conversation;
    }

    public ArrayList AllMessages(String sender, String receiver) {
        ArrayList msgs = new ArrayList();

        try {
            db.getConnection();

            /* active incase of error
            String sql = "SELECT * FROM `messageview` WHERE ((msg_from = ? AND msg_to = ? AND receiver IS NOT NULL) OR (msg_to = ? AND msg_from = ? AND sender IS NOT NULL)) ORDER BY time_stamp ASC";
            */
            
            String sql = "SELECT * FROM `messageview` WHERE ((msg_from = ? AND msg_to = ?) OR (msg_to = ? AND msg_from = ?)) ORDER BY time_stamp ASC";

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setString(1, sender);
            pstmt.setString(2, receiver);
            pstmt.setString(3, sender);
            pstmt.setString(4, receiver);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                List msg = new ArrayList();
                ConvertTimeStamp tsConvert = new ConvertTimeStamp();

                msg.add(rs.getInt("message_id"));
                if (rs.getString("msg_to").equals(receiver)) {
                    msg.add("inbox");
                } else {
                    msg.add("outbox");
                }
                msg.add(rs.getString("msg_to"));
                msg.add(rs.getString("msg_from"));
                msg.add(tsConvert.timeStampIn12h(rs.getString("time_stamp")));
                msg.add(rs.getString("content"));
                msg.add(rs.getString("sender"));
                msg.add(rs.getString("receiver"));
                msg.add(rs.getInt("read_state"));

                msgs.add(msg);
            }

            db.endConnection();

        } catch (SQLException e) {
            System.out.println("Class Exception: " + e.getMessage());
        } catch (ParseException e) {
            System.out.println("Class Exception: " + e.getMessage());
        }

        return msgs;
    }

    public void updateSeen(int msgId) {
        String sql = "UPDATE `messageview` SET `read_state`= 1 WHERE `message_id` = ?";

        try {
            db.getConnection();

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setInt(1, msgId);
            
            pstmt.executeUpdate();

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        }

    }

    //class methods end
}
