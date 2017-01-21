/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;

/**
 *
 * @author Indunil
 */
public class AdminReportedItems_Class {

    private int item_number;
    private String reporter_email;
    private String report_reason;
    private String reporter_message;

    //db class object
    Db_Class db = new Db_Class();

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
     * @return the reporter_email
     */
    public String getReporter_email() {
        return reporter_email;
    }

    /**
     * @param reporter_email the reporter_email to set
     */
    public void setReporter_email(String reporter_email) {
        this.reporter_email = reporter_email;
    }

    /**
     * @return the report_reason
     */
    public String getReport_reason() {
        return report_reason;
    }

    /**
     * @param report_reason the report_reason to set
     */
    public void setReport_reason(String report_reason) {
        this.report_reason = report_reason;
    }

    /**
     * @return the reporter_message
     */
    public String getReporter_message() {
        return reporter_message;
    }

    /**
     * @param reporter_message the reporter_message to set
     */
    public void setReporter_message(String reporter_message) {
        this.reporter_message = reporter_message;
    }

    //class methods
    public boolean reportItem(int itemNumber, String reporter_email, String report_reason, String reporter_message) {
        boolean reported = false;
        
        try {
            db.getConnection();
            
            String sql= "INSERT INTO `admin_reported_items`(`item_number`, `reporter_email`, `report_reason`, `reporter_message`) VALUES (?,?,?,?)";
            
            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setInt(1,itemNumber);
            pstmt.setString(2, reporter_email);
            pstmt.setString(3, report_reason);
            pstmt.setString(4, reporter_message);
            
            if(pstmt.executeUpdate()>0){
                reported = true;
                System.out.println("Item Reported!");
                SendMail feedback = new SendMail();
                feedback.reporterFeedback(itemNumber, reporter_email, report_reason, reporter_message);
            }else{
                System.out.println("Cannot Report Item!");
            }
            
            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return reported;
    }
}
