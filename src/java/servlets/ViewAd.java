/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.ItemInfo_Class;
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
public class ViewAd extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        //response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        ItemView_Class item = new ItemView_Class();
        User_Class user = new User_Class();

        try {
            if (request.getParameter("itemNumber") == null) {
                out.println("No item number");
                
                request.setAttribute("ViewAd", null);
            } else if (request.getParameter("itemNumber").equalsIgnoreCase("")) {
                out.println("No item number");
                
                request.setAttribute("ViewAd", null);
            } else {
                int itemNumber = Integer.parseInt(request.getParameter("itemNumber"));
                
                out.println("Item number: " + itemNumber);

                if (item.itemExist(itemNumber)) {
                    out.println("Item exist: " + item.itemExist(itemNumber));

                    if (getLogin(request) != null) {
                        out.print("Login as " + user.requestAccountType(getLogin(request)));

                        if ((user.requestAccountType(getLogin(request))).equalsIgnoreCase("admin")) {
                            out.println(" - ADMIN");
                            request.setAttribute("ViewAd", item.viewItemAsAdmin(itemNumber));

                        } else if ((user.requestAccountType(getLogin(request))).equalsIgnoreCase("member")) {
                            out.println(" - MEMBER");
                            request.setAttribute("ViewAd", item.viewItemAsNormal(itemNumber));

                            if (session.getAttribute("adViewCount" + itemNumber) == null) {
                                ItemInfo_Class info = new ItemInfo_Class();

                                if (info.updateViewCount(itemNumber)) {
                                    session.setAttribute("adViewCount" + itemNumber, true);
                                }
                            } else {
                                session.setAttribute("adViewCount" + itemNumber, true);
                            }
                        }
                    } else {
                        out.println("Generic Viewer");
                        request.setAttribute("ViewAd", item.viewItemAsNormal(itemNumber));

                        if (session.getAttribute("adViewCount" + itemNumber) == null) {
                            ItemInfo_Class info = new ItemInfo_Class();

                            if (info.updateViewCount(itemNumber)) {
                                session.setAttribute("adViewCount" + itemNumber, true);
                            }
                        } else {
                            session.setAttribute("adViewCount" + itemNumber, true);
                        }

                    }
                } else {
                    out.println("Item exist: " + item.itemExist(itemNumber));
                    request.setAttribute("ViewAd", null);
                }
            }
            
            //getting related ads
            
            

        } catch (NumberFormatException ex) {

            System.out.println("Servlet Exception: " + ex.getMessage());
            request.setAttribute("ViewAd", null);

        } finally {

            RequestDispatcher rd = request.getRequestDispatcher("viewAd.jsp");
            rd.forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewAd.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ViewAd.class.getName()).log(Level.SEVERE, null, ex);
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
