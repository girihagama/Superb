/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.UserAccountStatus_Class;
import classes.User_Class;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Indunil
 */
public class Ajax_login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NoSuchAlgorithmException {

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Cache-control", "no-cache, no-store");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "-1");

        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setHeader("Access-Control-Max-Age", "86400");

        Gson gson = new Gson();
        JsonObject myObj = new JsonObject();

        User_Class user = new User_Class();
        UserAccountStatus_Class account = new UserAccountStatus_Class();

        String login = request.getParameter("login");
        String password = request.getParameter("password");

        //check wheather the user name is valid
        boolean userExist = user.userValidate(login);

        //checks the account status
        String accountStatus = account.accountStatus(login);

        //checks the enterd username and the password is matched
        boolean userLogin = user.login(login, password);
        myObj.addProperty("combination", userLogin);

        //checking start
        if (userExist == false) { //if user name is wrong            
            myObj.addProperty("userExist", false); //sets userExist = false
            myObj.addProperty("accountStatus", accountStatus); //sets accountStatus = null
            myObj.addProperty("userLogin", false);  //sets userLogin = false

            session.setAttribute("login", null);
        } else {                //if user name is correct
            myObj.addProperty("userExist", true); //sets userExist = true

            //checks account status
            if ("Inactive".equals(accountStatus)) {
                myObj.addProperty("accountStatus", accountStatus); //sets accountStatus = Inactive
                myObj.addProperty("userLogin", false); //sets userLogin = false

                session.setAttribute("login", null);

            } else if ("Blocked".equals(accountStatus)) {
                myObj.addProperty("accountStatus", accountStatus);//sets accountStatus = Blocked
                myObj.addProperty("userLogin", false); //sets userLogin = false

                session.setAttribute("login", null);

            } else if ("Activated".equals(accountStatus)) {
                myObj.addProperty("accountStatus", accountStatus);//sets accountStatus = Activated

                if (userLogin == true) {    //if user login is true
                    myObj.addProperty("userLogin", userLogin);  //sets userLogin = true

                    session.setAttribute("login", login);
                    session.setMaxInactiveInterval(0);
                } else {
                    myObj.addProperty("userLogin", false);//sets userLogin = false

                    session.setAttribute("login", null);
                }
            } else {
                myObj.addProperty("accountStatus", accountStatus);//sets accountStatus = null
                myObj.addProperty("userLogin", false);  //sets userLogin = false

                session.setAttribute("login", null);
            }

//            JsonElement userData = gson.toJsonTree(user.loadUserInfo(login, password));
//            myObj.add("UserData", userData);
        }

        out.println(myObj.toString());
        out.close();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Ajax_login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Ajax_login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Ajax_login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Ajax_login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
