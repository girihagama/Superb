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
public class ItemInfo_Class {

    private int item_number;
    private String title;
    private String content;
    private String contact_number;
    private String negotiable;
    private int price;
    private int view_count;

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
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
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
     * @return the contact_number
     */
    public String getContact_number() {
        return contact_number;
    }

    /**
     * @param contact_number the contact_number to set
     */
    public void setContact_number(String contact_number) {
        this.contact_number = contact_number;
    }

    /**
     * @return the negotiable
     */
    public String getNegotiable() {
        return negotiable;
    }

    /**
     * @param negotiable the negotiable to set
     */
    public void setNegotiable(String negotiable) {
        this.negotiable = negotiable;
    }

    /**
     * @return the price
     */
    public int getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(int price) {
        this.price = price;
    }

    /**
     * @return the view_count
     */
    public int getView_count() {
        return view_count;
    }

    /**
     * @param view_count the view_count to set
     */
    public void setView_count(int view_count) {
        this.view_count = view_count;
    }

    //class methods
    public boolean updateViewCount(int itemNumber) {
        boolean updated = false;

        ItemView_Class view = new ItemView_Class();

        if (view.itemExist(itemNumber)) {
            try {
                db.getConnection();

                int currentViews = 0;
                String getCurrentViews = "SELECT `view_count` FROM `item_info` WHERE `item_number` = ?";

                PreparedStatement pstmt1 = db.conn.prepareStatement(getCurrentViews);
                pstmt1.setInt(1, itemNumber);

                ResultSet rs = pstmt1.executeQuery();

                while (rs.next()) {
                    currentViews = rs.getInt(1);
                }

                //update views
                String sql = "UPDATE `item_info` SET `view_count`= ? WHERE `item_number`= ?;";

                PreparedStatement pstmt2 = db.conn.prepareStatement(sql);
                pstmt2.setInt(1, currentViews + 1);
                pstmt2.setInt(2, itemNumber);

                if ((pstmt2.executeUpdate()) > 0) {
                    updated = true;
                }

                db.endConnection();

            } catch (Exception ex) {
                System.out.println("Class Exception: " + ex.getMessage());
            }
        }

        return updated;
    }
    
    //class methods
    public boolean removeItem(int itemNumber) {
        boolean removed = false;
        
        try {            
            db.getConnection();
            
            String sql = "DELETE FROM `item_info` WHERE `item_number` = ?";
            
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
        
        System.out.println("ItemInfo_Class | removeItem: "+removed);
        return removed;
    }

    public boolean insertItem(int itemNumber, String title, String description, String price, String negotiable, String voice) {
        boolean added = false;
        
        try {
            db.getConnection();
            
            String sql = "INSERT INTO `item_info`(`item_number`, `title`, `content`, `contact_number`, `negotiable`, `price`) VALUES (?,?,?,?,?,?)";
            
            PreparedStatement pstmt = db.conn.prepareCall(sql);
            pstmt.setInt(1, itemNumber);
            pstmt.setString(2, title);
            pstmt.setString(3, description);
            pstmt.setString(4, voice);
            pstmt.setString(5, negotiable);
            pstmt.setInt(6, Integer.parseInt(price));
            
            added = pstmt.executeUpdate() > 0;
            
            db.endConnection();
        } catch (SQLException e) {
            System.out.println("Class Exception: " + e.getMessage());
        } catch (NumberFormatException e) {
            System.out.println("Class Exception: " + e.getMessage());
        }finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }
        
        return added;
    }
    
    public boolean updateItem(int itemNumber, String title, String description, String price, String negotiable, String voice) {
        boolean updated = false;
        
        try {
            db.getConnection();
            
            String sql = "UPDATE `item_info` SET `title`=?,`content`=?,`contact_number`=?,`negotiable`=?,`price`=? WHERE `item_number`= ?";
            
            PreparedStatement pstmt = db.conn.prepareStatement(sql);            
            pstmt.setString(1, title);
            pstmt.setString(2, description);
            pstmt.setString(3, voice);
            pstmt.setString(4, negotiable);
            pstmt.setInt(5, Integer.parseInt(price));
            pstmt.setInt(6, itemNumber);
            
            updated = pstmt.executeUpdate() > 0;
            
            db.endConnection();
        } catch (SQLException e) {
            System.out.println("Class Exception: " + e.getMessage());
        } catch (NumberFormatException e) {
            System.out.println("Class Exception: " + e.getMessage());
        }finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }
        
        return updated;
    }
}
