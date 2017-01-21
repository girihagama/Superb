/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Indunil
 */
public class Location_Class {

    private String district;
    private String city;
    private String location;
    private int itemCount;

    Db_Class db = new Db_Class();

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
     * @return the location
     */
    public String getLocation() {
        return location;
    }

    /**
     * @param location the location to set
     */
    public void setLocation(String location) {
        this.location = location;
    }   

    /**
     * @return the itemCount
     */
    public int getItemCount() {
        return itemCount;
    }

    /**
     * @param itemCount the itemCount to set
     */
    public void setItemCount(int itemCount) {
        this.itemCount = itemCount;
    }

    //class methods
    
    public List allDistricts() {
        List districts = new ArrayList();

        try {
            db.getConnection();

            String sql = "SELECT * FROM location_district";

            Statement stmt = db.conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            while(rs.next()){
                districts.add(rs.getString(1));
            }

            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        }finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return districts;
    }

    public List allCities() {
        List cities = new ArrayList();

        try {
            db.getConnection();

            String sql = "SELECT * FROM location_city";

            Statement stmt = db.conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            while(rs.next()){
                cities.add(rs.getString(1));
            }

            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        }finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return cities;
    }
    
    public ArrayList districtsWithCities(){
        ArrayList allLocations = new ArrayList();
        
        List Districts = this.allDistricts();
        for (Object dis : Districts) {
            ArrayList loc = new ArrayList();
            
            loc.add(dis);
            loc.add(citiesOfDistrict(dis.toString()));
            
            allLocations.add(loc);
        }
        
        return allLocations;
    }
    
    public List citiesOfDistrict(String district) {
        List cities = new ArrayList();

        try {
            db.getConnection();

            String sql = "SELECT city FROM location WHERE district = ?";

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setString(1, district);
            
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()){
                cities.add(rs.getString(1));
            }

            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        }finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return cities;
    }

    //class methods end 
}
