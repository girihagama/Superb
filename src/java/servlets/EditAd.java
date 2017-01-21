/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.ItemView_Class;
import classes.User_Class;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Indunil
 */
public class EditAd extends HttpServlet {

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

        String login = null;
        int itemNumber = 0;

        try {
            User_Class user = new User_Class();

            if (getLogin(request) == null) {
                response.setContentType("text/html;charset=UTF-8");
                out.println("<h1><center>Invalid Login Details!</center></h1>");
                out.println("<center><a href='SignProcess.jsp' target=\"_blank\">Click here to see sign process page.</a></center>");
                out.println("<center>Complete sign process and reload this page.</center>");
                return;
            } else {
                login = getLogin(request);
            }

            if (request.getParameter("itemNumber") == null) {
                response.setContentType("text/html;charset=UTF-8");
                out.println("<h1><center>Sorry, Invalid Item Details!</center></h1>");
                out.println("<center>Try With Different Item Of Yours.</center>");
                return;
            } else {
                itemNumber = Integer.parseInt(request.getParameter("itemNumber"));
            }

            ItemView_Class item = new ItemView_Class();

            if (user.userValidate(login) && item.checkEditAuthentication(login, itemNumber)) {
                RequestDispatcher rd = request.getRequestDispatcher("editAd.jsp");
                rd.forward(request, response);                
            }else{
                response.setContentType("text/html;charset=UTF-8");
                out.println("<h1><center>Sorry, Invalid Item Details!</center></h1>");
                out.println("<center>Try With Different Item Of Yours.</center>");
            }           
        } catch (SQLException ex) {
            out.println(ex.getMessage());
            Logger.getLogger(EditAd.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            response.setContentType("text/html;charset=UTF-8");
            out.println("<h1><center>Sorry, Invalid Item Details!</center></h1>");
            out.println("<center>Try With Different Item Of Yours.</center>");
            Logger.getLogger(EditAd.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
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

    private boolean sessionUpdate(HttpServletRequest request) throws SQLException {
        //session update
        HttpSession session = request.getSession();
        String login = null;

        if (session.getAttribute("login") != null) {
            login = (String) session.getAttribute("login");

            User_Class x = new User_Class();

            if (x.userValidate(login) == false) {
                login = null;
                session.setAttribute("login", null);
                return false;
            } else {
                session.setAttribute("login", login);
                return true;
            }
        } else {
            return false;
        }
        //session update end
    }

    private String getLogin(HttpServletRequest request) throws SQLException {
        HttpSession session = request.getSession();
        String login = null;

        if (sessionUpdate(request)) {
            login = (String) session.getAttribute("login");
        } else {
            login = null;
        }

        return login;
    }

}
