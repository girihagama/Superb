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
public class UserFavorite_Class {

    private int record_id;
    private String favorite_of;
    private int item_number;

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

    public int favoriteItemsCount(String login) throws SQLException {
        int count = 0;

        User_Class user = new User_Class();

        if (user.userValidate(login)) {
            String username = user.requetUsername(login);
            db.getConnection();

            String query = "SELECT COUNT(*) FROM user_favorite WHERE favorite_of = ?";

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

    public boolean checkSaved(String login, int itemNumber) {
        boolean exist = false;
        User_Class user = new User_Class();

        try {
            login = user.requetUsername(login);
            db.getConnection();

            String sql = "SELECT count(*) FROM `user_favorite` WHERE `favorite_of` = ? AND `item_number` = ?";
            
            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setString(1, login);
            pstmt.setInt(2, itemNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                if(rs.getInt(1)>0){
                    exist = true;
                }
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception(" + this.getClass() + "): " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return exist;
    }

    public boolean addFavorite(String login, int itemNumber) {
        boolean added = false;
        User_Class user = new User_Class();
        
        try {
            login = user.requetUsername(login);
            db.getConnection();

            String sql = "INSERT INTO `user_favorite`(`favorite_of`, `item_number`) VALUES (?,?)";
            
            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setString(1, login);
            pstmt.setInt(2, itemNumber);

            if(pstmt.executeUpdate()>0){
                added = true;
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception(" + this.getClass() + "): " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return added;
    }

    public boolean removeFavorite(String login, int itemNumber) {
        boolean removed = false;
        
        User_Class user = new User_Class();
        
        try {
            login = user.requetUsername(login);
            db.getConnection();

            String sql = "DELETE FROM `user_favorite` WHERE `favorite_of` = ? AND `item_number` = ?";
            
            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setString(1, login);
            pstmt.setInt(2, itemNumber);

            if(pstmt.executeUpdate()>0){
                removed = true;
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception(" + this.getClass() + "): " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return removed;
    }
}
