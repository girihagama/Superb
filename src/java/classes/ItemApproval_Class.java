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
public class ItemApproval_Class {

    private int itemNumber;
    private String status;
    private String reason;

    Db_Class db = new Db_Class();

    /**
     * @return the itemNumber
     */
    public int getItemNumber() {
        return itemNumber;
    }

    /**
     * @param itemNumber the itemNumber to set
     */
    public void setItemNumber(int itemNumber) {
        this.itemNumber = itemNumber;
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
     * @return the reason
     */
    public String getReason() {
        return reason;
    }

    /**
     * @param reason the reason to set
     */
    public void setReason(String reason) {
        this.reason = reason;
    }

    //class methods
    public boolean requestNewApproval(String item_number) {
        boolean added = false;

        try {
            db.getConnection();

            String sql = "INSERT INTO `item_approval`(`item_number`) VALUES (?)";

            PreparedStatement pstmt = db.conn.prepareCall(sql);
            pstmt.setString(1, item_number);

            added = pstmt.executeUpdate() > 0;
            
            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return added;
    }
    
    public boolean modifyApproval(String item_number) {
        boolean modified = false;

        try {
            db.getConnection();

            String sql = "UPDATE `item_approval` SET `status`=? WHERE `item_number`= ?";

            PreparedStatement pstmt = db.conn.prepareCall(sql);
            pstmt.setString(1, "Pending");
            pstmt.setString(2, item_number);

            modified = pstmt.executeUpdate() > 0;
            
            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return modified;
    }

    public boolean removeItem(int itemNumber) {
        boolean removed = false;

        try {

            db.getConnection();

            String sql = "DELETE FROM `item_approval` WHERE `item_number` = ?";

            PreparedStatement pstmt = db.conn.prepareCall(sql);
            pstmt.setInt(1, itemNumber);

            removed = pstmt.executeUpdate() > 0;
            
            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        System.out.println("ItemApproval_Class | removeItem: " + removed);
        return removed;
    }

    //class methods end
}
