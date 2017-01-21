/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Indunil
 */
public class ItemInquiry_Class {

    private int inquiry_id;
    private int item_number;
    private String message_to;
    private String message_from;
    private String inquiry_message;
    private String inquiry_time_stamp;
    private String inquiry_response;
    private String response_time_stamp;
    private int inquiry_state;

    Db_Class db = new Db_Class();

    /**
     * @return the inquiry_id
     */
    public int getInquiry_id() {
        return inquiry_id;
    }

    /**
     * @param inquiry_id the inquiry_id to set
     */
    public void setInquiry_id(int inquiry_id) {
        this.inquiry_id = inquiry_id;
    }

    /**
     * @return the item_number
     */
    public int getItem_number() {
        return item_number;
    }

    /**
     * @param item_number the item_number to set
     */
    public void setItem_number(int item_number) {
        this.item_number = item_number;
    }

    /**
     * @return the message_to
     */
    public String getMessage_to() {
        return message_to;
    }

    /**
     * @param message_to the message_to to set
     */
    public void setMessage_to(String message_to) {
        this.message_to = message_to;
    }

    /**
     * @return the message_from
     */
    public String getMessage_from() {
        return message_from;
    }

    /**
     * @param message_from the message_from to set
     */
    public void setMessage_from(String message_from) {
        this.message_from = message_from;
    }

    /**
     * @return the inquiry_message
     */
    public String getInquiry_message() {
        return inquiry_message;
    }

    /**
     * @param inquiry_message the inquiry_message to set
     */
    public void setInquiry_message(String inquiry_message) {
        this.inquiry_message = inquiry_message;
    }

    /**
     * @return the inquiry_time_stamp
     */
    public String getInquiry_time_stamp() {
        return inquiry_time_stamp;
    }

    /**
     * @param inquiry_time_stamp the inquiry_time_stamp to set
     */
    public void setInquiry_time_stamp(String inquiry_time_stamp) {
        this.inquiry_time_stamp = inquiry_time_stamp;
    }

    /**
     * @return the inquiry_response
     */
    public String getInquiry_response() {
        return inquiry_response;
    }

    /**
     * @param inquiry_response the inquiry_response to set
     */
    public void setInquiry_response(String inquiry_response) {
        this.inquiry_response = inquiry_response;
    }

    /**
     * @return the response_time_stamp
     */
    public String getResponse_time_stamp() {
        return response_time_stamp;
    }

    /**
     * @param response_time_stamp the response_time_stamp to set
     */
    public void setResponse_time_stamp(String response_time_stamp) {
        this.response_time_stamp = response_time_stamp;
    }

    /**
     * @return the inquiry_state
     */
    public int getInquiry_state() {
        return inquiry_state;
    }

    /**
     * @param inquiry_state the inquiry_state to set
     */
    public void setInquiry_state(int inquiry_state) {
        this.inquiry_state = inquiry_state;
    }

    //class methods
    public int unreadInquriesCount(String login) throws SQLException {
        int count = 0;

        User_Class user = new User_Class();

        if (user.userValidate(login)) {
            String username = user.requetUsername(login);
            db.getConnection();
            
            String query = "SELECT COUNT(*) FROM item_inquiry WHERE message_to = ? AND inquiry_state = 0";
            
            PreparedStatement pstmt=db.conn.prepareStatement(query);
            pstmt.setString(1, username);
            
            ResultSet rs= pstmt.executeQuery();
            
            while(rs.next()){
                count = rs.getInt(1);
            }               
            
            db.endConnection();
        }

        return count;
    }

    //class ethods end
}
