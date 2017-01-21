/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Indunil
 */
public class SiteVisits_Class {

    private String timeStamp;

    Db_Class db = new Db_Class();
    TimeStamp tStamp = new TimeStamp();

    /**
     * @return the timeStamp
     */
    public String getTimeStamp() {
        return timeStamp;
    }

    /**
     * @param timeStamp the timeStamp to set
     */
    public void setTimeStamp(String timeStamp) {
        this.timeStamp = timeStamp;
    }

    //class metods
    public boolean recordSiteVisit() throws SQLException {
        db.getConnection();

        String query = "INSERT INTO site_visits(`time_stamp`) VALUES(?)";

        PreparedStatement pstmt = db.conn.prepareStatement(query);
        pstmt.setString(1, tStamp.getTimestamp());

        int added = pstmt.executeUpdate();

        db.endConnection();

        if (added > 0) {
            return true;
        } else {
            return false;
        }

    }

    //class methods end
}
