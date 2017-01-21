/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.FavoriteView_Class;
import classes.ItemInquiry_Class;
import classes.Item_Class;
import classes.UserCurrentStatus_Class;
import classes.UserMessages_Class;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Indunil
 */
public class Ajax_navbarCountsUpdate extends HttpServlet {

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
            throws ServletException, IOException {
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
        String login = null;
        
        if(session.getAttribute("login") != null){
            login = session.getAttribute("login").toString();
        }
        
        try {
            myObj.addProperty("updated", true);

            Item_Class item = new Item_Class();
            int itemsCount = item.myItemsCount(login);
            myObj.addProperty("itemsCount", itemsCount);

            UserMessages_Class message = new UserMessages_Class();
            int messagesCount = message.unreadMessagesCount(login);
            myObj.addProperty("msgCount", messagesCount);

            FavoriteView_Class favorite=new FavoriteView_Class();
            //UserFavorite_Class favorite=new UserFavorite_Class();
            int favoritesCount = favorite.favoriteItemsCount(login);
            myObj.addProperty("savedAdsCount", favoritesCount);
            
            ItemInquiry_Class inquiry = new ItemInquiry_Class();
            int inquriesCount = inquiry.unreadInquriesCount(login);
            myObj.addProperty("inquriesCount", inquriesCount);

            UserCurrentStatus_Class chat = new UserCurrentStatus_Class();
            String chatStatus = chat.currentStatus(login);
            myObj.addProperty("chat", chatStatus);

        } catch (Exception ex) {
            ex.getMessage();

            myObj.addProperty("updated", false);
        } finally {
            out.println(myObj.toString());
            out.close();
        }
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
        processRequest(request, response);
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
        processRequest(request, response);
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
