/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author Indunil
 */
public class Db_Class {
    //connection object
    public Connection conn = null;

    //sql url
    protected final String URL = "jdbc:mysql://localhost:3306/";// [jdbc:mysql://localhost:3306/] OR [jdbc:mysql://localhost/]
    //sql database name
    protected String dbName = "superb_classified";// [superb_classified]
    //username
    protected String username = "root";// [root] OR [superb_ngs]
    //password
    protected String password = ""; // [next#0714233441pa$$word@superb]

    //open connection
    public boolean getConnection() {
        boolean state = false;

        try {
            System.out.println("Connecting..");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = (Connection) DriverManager.getConnection(URL + dbName + "?noAccessToProcedureBodies=true", username, password);
                if (conn != null) {
                    System.out.println("Database Connected..");
                }

            } catch (ClassNotFoundException ex) {

                Logger.getLogger(classes.Db_Class.class.getName()).log(Level.SEVERE, null, ex);
                JOptionPane.showMessageDialog(null, ex);
                System.out.println(ex.toString());
            }

        } catch (SQLException ex) {
            Logger.getLogger(classes.Db_Class.class.getName()).log(Level.SEVERE, null, ex);
            //JOptionPane.showMessageDialog(null, ex);
            System.out.println("DB CLASS EXCEPTION: "+ex.toString());
        }

        if (this.conn != null) {
            state = true;
        }

        return state;
    }

    //close connection
    public void endConnection() {

        System.out.println("Closing..");

        try {
            //closing db connection
            conn.close();

            if (conn == null) {
                System.out.println("Connection Closed..");
            }

        } catch (SQLException ex) {
            Logger.getLogger(classes.Db_Class.class.getName()).log(Level.SEVERE, null, ex);
            //JOptionPane.showMessageDialog(null, ex);
            System.out.println("DB CLASS EXCEPTION: "+ex.toString());
        }
    }
}
