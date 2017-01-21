/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.UserCurrentStatus_Class;
import classes.User_Class;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
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
public class Ajax_toggleChatState extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
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
        
        UserCurrentStatus_Class userCurrentStatus = new UserCurrentStatus_Class();
        
        String setChat = request.getParameter("setChat");

        if(sessionUpdate(request)){
            String login = getLogin(request);
            
            if ("online".equalsIgnoreCase(setChat)) {
                if (userCurrentStatus.toggleChatOnline(login)) {
                    myObj.addProperty("updated", true);
                }
            } else if ("offline".equalsIgnoreCase(setChat)) {
                if (userCurrentStatus.toggleChatOffline(login)) {
                    myObj.addProperty("updated", true);
                }
            } else {
                myObj.addProperty("updated", false);
            }
        }else{
            myObj.addProperty("updated", false);
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
            Logger.getLogger(Ajax_toggleChatState.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Ajax_toggleChatState.class.getName()).log(Level.SEVERE, null, ex);
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
    
    private boolean sessionUpdate(HttpServletRequest request) throws SQLException{
        //session update
        HttpSession session = request.getSession();
        String login = null;
        
        if (session.getAttribute("login") != null) {
            login = (String) session.getAttribute("login");
            
            User_Class x=new User_Class();
            
            if(x.userValidate(login)== false){
                login = null;
                session.setAttribute("login", null);
                return false;
            }else{
                session.setAttribute("login", login);
                return true;
            }            
        }else{
            return false;
        }        
        //session update end
    }
    
    private String getLogin(HttpServletRequest request) throws SQLException{
        HttpSession session = request.getSession();
        String login = null;
        
        if(sessionUpdate(request)){
            login = (String) session.getAttribute("login");
        }else{
            login = null;
        }
        
        return login;
    }
}
