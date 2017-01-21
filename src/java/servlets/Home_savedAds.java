/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.FavoriteView_Class;
import classes.User_Class;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class Home_savedAds extends HttpServlet {

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

        try {

            if (sessionUpdate(request)) {

                FavoriteView_Class favoriteView = new FavoriteView_Class();
                ArrayList favorites = favoriteView.myFavoriteItems(getLogin(request));

                int size = favorites.size();

                if (size > 0) {
                    session.setAttribute("favorites", "yes");

                    int rows_per_page = 10;
                    int pages = 0;

                    int flag = 0;
                    int start = 0;
                    int end = 0;

                    if (0 < size % (int) rows_per_page) {
                        pages = (int) (size / (int) rows_per_page) + 1;
                        session.setAttribute("favoritePageCount", pages);

                        for (int c = 1; c <= pages; c++) {
                            String session_id = Integer.toString(c);

                            int set = size - flag;

                            start = flag;
                            end = flag + (int) rows_per_page;

                            if (set < (int) rows_per_page) {
                                end = flag + set;
                            }

                            session.setAttribute("favorite" + session_id, favorites.subList(start, end));

                            flag = flag + (int) rows_per_page;
                        }
                    } else {
                        pages = (int) (size / (int) rows_per_page);
                        session.setAttribute("favoritePageCount", pages);

                        for (int c = 1; c <= pages; c++) {
                            String session_id = Integer.toString(c);

                            int set = size - flag;

                            start = flag;
                            end = flag + (int) rows_per_page;

                            if (set < (int) rows_per_page) {
                                end = flag + set;
                            }

                            session.setAttribute("favorite" + session_id, favorites.subList(start, end));

                            flag = flag + (int) rows_per_page;
                        }
                    }
                } else {
                    session.setAttribute("favorites", "no");

                    session.setAttribute("favoritePageCount", 0);
                }

            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (SQLException ex) {
            ex.getMessage();

        } finally {
            RequestDispatcher rd = request.getRequestDispatcher("savedAds.jsp");
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
            if (sessionUpdate(request)) {
                processRequest(request, response);
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (SQLException ex) {
            response.sendRedirect("index.jsp");
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
            if (sessionUpdate(request)) {
                processRequest(request, response);
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (SQLException ex) {
            response.sendRedirect("index.jsp");
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
