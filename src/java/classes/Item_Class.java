/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Indunil
 */
public class Item_Class {

    private String item_number;
    private String username;
    private String time_stamp;
    private String status;
    private String category_main;
    private String category_sub;
    private String district;
    private String city;

    Db_Class db = new Db_Class();

    /**
     * @return the item_number
     */
    public String getItem_number() {
        return item_number;
    }

    /**
     * @param item_number the item_number to set
     */
    public void setItem_number(String item_number) {
        this.item_number = item_number;
    }

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
     * @return the category_main
     */
    public String getCategory_main() {
        return category_main;
    }

    /**
     * @param category_main the category_main to set
     */
    public void setCategory_main(String category_main) {
        this.category_main = category_main;
    }

    /**
     * @return the category_sub
     */
    public String getCategory_sub() {
        return category_sub;
    }

    /**
     * @param category_sub the category_sub to set
     */
    public void setCategory_sub(String category_sub) {
        this.category_sub = category_sub;
    }

    /**
     * @return the district
     */
    public String getDistrict() {
        return district;
    }

    /**
     * @param district the district to set
     */
    public void setDistrict(String district) {
        this.district = district;
    }

    /**
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    //methods 
    /**
     * Using to update ad count by category in index page. Don't make any
     * changes.
     *
     * @param category_main
     * @return
     * @throws SQLException
     */
    public int getItemCount(String category_main) throws SQLException {
        int count = 0;

        db.getConnection();

        Statement stmt = db.conn.createStatement();

        String query = "Select count(*) from item WHERE category_main='" + category_main + "'";

        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
            count = Integer.parseInt(rs.getString("count(*)"));
            System.out.println(category_main + ": " + count);
        }

        db.endConnection();

        return count;
    }

    /**
     * Returns all listed ads count according to provided username.
     *
     * @param login
     * @return
     * @throws SQLException
     */
    public int myItemsCount(String login) throws SQLException {
        int count = 0;

        User_Class user = new User_Class();

        if (user.userValidate(login)) {
            String username = user.requetUsername(login);
            db.getConnection();

            String query = "SELECT COUNT(*) FROM item WHERE username = ?";

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

    public boolean removeItem(int itemNumber, String login) {
        boolean removed = false;

        try {
            User_Class user = new User_Class();
            login = user.requetUsername(login);

            db.getConnection();

            String sql = "DELETE FROM `item` WHERE `item_number` = ? AND `username` = ?";

            PreparedStatement pstmt = db.conn.prepareCall(sql);
            pstmt.setInt(1, itemNumber);
            pstmt.setString(2, login);

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

    public boolean insertNewItem(String username, String category_main, String category_sub, String district, String city, String ad_form) {
        boolean result = false;

        try {
            TimeStamp tStamp = new TimeStamp();
            String timeStamp = tStamp.getTimestamp();

            db.getConnection();

            String sql = "INSERT INTO `item`(`username`, `time_stamp`, `category_main`, `category_sub`, `district`, `city`, `ad_form`) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement pstmt = db.conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pstmt.setString(1, username);
            pstmt.setString(2, timeStamp);
            pstmt.setString(3, category_main);
            pstmt.setString(4, category_sub);
            pstmt.setString(5, district);
            pstmt.setString(6, city);
            pstmt.setString(7, ad_form);

            if (pstmt.executeUpdate() > 0) {
                result = true;
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    setItem_number(rs.getString(1));
                }

                ItemApproval_Class approval = new ItemApproval_Class();
                approval.requestNewApproval(getItem_number());
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return result;
    }

    public boolean updateItem(int itemNumber, String username, String category_main, String category_sub, String district, String city, String ad_form) {
        boolean result = false;

        TimeStamp tStamp = new TimeStamp();
        String timeStamp = tStamp.getTimestamp();
        try {
            db.getConnection();

            String sql = "UPDATE `item` SET `category_main`= ?,`category_sub`= ?,`district`= ?,`city`= ?,`ad_form`= ?,`time_stamp`=? WHERE `item_number` = ? AND `username` = ?";
            PreparedStatement pstmt = db.conn.prepareStatement(sql);

            pstmt.setString(1, category_main);
            pstmt.setString(2, category_sub);
            pstmt.setString(3, district);
            pstmt.setString(4, city);
            pstmt.setString(5, ad_form);
            pstmt.setString(6, timeStamp);
            pstmt.setInt(7, itemNumber);
            pstmt.setString(8, username);
            

            if (pstmt.executeUpdate() > 0) {
                result = true;

                ItemApproval_Class approval = new ItemApproval_Class();
                approval.modifyApproval(Integer.toString(itemNumber));
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return result;
    }

    //class methods end
}
