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

/**
 *
 * @author Indunil
 */
public class FavoriteView_Class {

    private int record_id;
    private String favorite_of;
    private int item_number;
    private String seller;
    private String time_stamp;
    private String category_main;
    private String category_sub;
    private String district;
    private String city;
    private String ad_form;
    private String title;
    private String content;
    private String contact_number;
    private String negotiable;
    private int price;
    private int view_count;
    private String status;
    private String reason;

    Db_Class db = new Db_Class();

    /**
     * @return the record_id
     */
    public int getRecord_id() {
        return record_id;
    }

    /**
     * @param record_id the record_id to set
     */
    public void setRecord_id(int record_id) {
        this.record_id = record_id;
    }

    /**
     * @return the favorite_of
     */
    public String getFavorite_of() {
        return favorite_of;
    }

    /**
     * @param favorite_of the favorite_of to set
     */
    public void setFavorite_of(String favorite_of) {
        this.favorite_of = favorite_of;
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
     * @return the seller
     */
    public String getSeller() {
        return seller;
    }

    /**
     * @param seller the seller to set
     */
    public void setSeller(String seller) {
        this.seller = seller;
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

    /**
     * @return the ad_form
     */
    public String getAd_form() {
        return ad_form;
    }

    /**
     * @param ad_form the ad_form to set
     */
    public void setAd_form(String ad_form) {
        this.ad_form = ad_form;
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
    public ArrayList myFavoriteItems(String login) throws SQLException {
        ArrayList<FavoriteView_Class> items = new ArrayList();

        User_Class user = new User_Class();
        String username = user.requetUsername(login);

        try {
            String query = "SELECT * FROM favoriteview WHERE favorite_of = ? AND status = ? ORDER BY `record_id` DESC";

            db.getConnection();
            PreparedStatement psmt = db.conn.prepareStatement(query);
            psmt.setString(1, username);
            psmt.setString(2, "Active");

            ResultSet rs = psmt.executeQuery();

            while (rs.next()) {
                FavoriteView_Class newItem = new FavoriteView_Class();

                newItem.setRecord_id(rs.getInt("record_id"));
                newItem.setItem_number(rs.getInt("item_number"));
                newItem.setFavorite_of(rs.getString("favorite_of"));
                newItem.setSeller(rs.getString("seller"));
                newItem.setTime_stamp(rs.getString("time_stamp"));
                newItem.setCategory_main(rs.getString("category_main"));
                newItem.setCategory_sub(rs.getString("category_sub"));
                newItem.setDistrict(rs.getString("district"));
                newItem.setCity(rs.getString("city"));
                newItem.setAd_form(rs.getString("ad_form"));
                newItem.setTitle(rs.getString("title"));
                newItem.setContent(rs.getString("content"));
                newItem.setContact_number("contact_number");
                newItem.setNegotiable(rs.getString("negotiable"));
                newItem.setPrice(rs.getInt("price"));
                newItem.setView_count(rs.getInt("view_count"));
                newItem.setStatus(rs.getString("status"));

                if (rs.getString("reason") != null) {
                    newItem.setReason(rs.getString("reason"));
                } else {
                    newItem.setReason("");
                }

                items.add(newItem);
            }
            
            db.endConnection();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        System.out.println("FavoriteView_Class | myFavoriteItems : items - " + items.size());
        return items;
    }

    public int favoriteItemsCount(String login) throws SQLException {
        int count = 0;

        User_Class user = new User_Class();

        if (user.userValidate(login)) {
            String username = user.requetUsername(login);
            db.getConnection();

            String query = "SELECT COUNT(*) FROM favoriteview WHERE favorite_of = ? AND status='Active'";

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

    //class methods end
}
