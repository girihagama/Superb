/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.ItemView_Class;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
public class Search extends HttpServlet {

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
        //response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        try {
            String regex = "[0-9]+";

            String search = null;
            String adType = null;
            String categoryMain = null;
            String categorySub = null;
            String category = null;
            String district = null;
            String city = null;
            String location = null;
            int minPrice = 0;
            int maxPrice = 0;

            String sort = null;

            if (request.getParameter("searchTerm") != null) {
                search = request.getParameter("searchTerm");
                out.println("Search: " + search);
            }

            if (request.getParameter("adType") != null) {
                adType = request.getParameter("adType");
                out.println("AD Type: " + adType);
            }

            if (request.getParameter("adType") != null && request.getParameter("adType").equalsIgnoreCase("All Ads")) {
                adType = null;
            }

            if (request.getParameter("categoryMain") != null) {
                categoryMain = request.getParameter("categoryMain");
                out.println("Category Main: " + categoryMain);
            }

            if (request.getParameter("categorySub") != null) {
                categorySub = request.getParameter("categorySub");
                out.println("Category Sub: " + categorySub);
            }

            if (request.getParameter("category") != null) {
                category = request.getParameter("category");
                out.println("Category: " + category);
            }

            if (request.getParameter("district") != null) {
                district = request.getParameter("district");
                out.println("District: " + district);
            }

            if (request.getParameter("city") != null) {
                city = request.getParameter("city");
                out.println("City: " + city);
            }

            if (request.getParameter("location") != null) {
                location = request.getParameter("location");
                out.println("Location: " + location);
            }

            if (request.getParameter("location") == null && request.getParameter("district") != null) {
                String[] districts = district.split(",");
                session.setAttribute("selectedDistricts", districts);

            } else if (request.getParameter("location") != null) {
                String[] districts = location.split(">");

                String locationDistrict = null;

                for (int i = 0; i < 1; i++) {
                    locationDistrict = districts[i];
                }

                String[] locDist = new String[1];
                locDist[0] = locationDistrict;

                session.setAttribute("selectedDistricts", locDist);
            } else {
                session.setAttribute("selectedDistricts", null);
            }

            if (request.getParameter("minPrice") != null && (request.getParameter("minPrice")).matches(regex)) {
                minPrice = Integer.parseInt(request.getParameter("minPrice"));
                out.println("Min Price: " + minPrice);
            }

            if (request.getParameter("maxPrice") != null && (request.getParameter("maxPrice")).matches(regex)) {
                maxPrice = Integer.parseInt(request.getParameter("maxPrice"));
                out.println("Max Price: " + maxPrice);
            }

            ItemView_Class view = new ItemView_Class();
            ArrayList items = view.searchItems(search, adType, categoryMain, categorySub, category, district, city, location, minPrice, maxPrice);

            out.print("\n---\nResults: " + items.size() + "\n---");

            //---------//
            // sorting results
            //---------//
            if (items.size() > 0 && request.getParameter("sort") != null) {
                if (request.getParameter("sort").equalsIgnoreCase("newest")) {
                    items = view.sortByNew(items);
                } else if (request.getParameter("sort").equalsIgnoreCase("oldest")) {
                    items = view.sortByOld(items);
                } else if (request.getParameter("sort").equalsIgnoreCase("highest price")) {
                    items = view.sortByHighestPrice(items);
                } else if (request.getParameter("sort").equalsIgnoreCase("lowest price")) {
                    items = view.sortByLowestPrice(items);
                } else if (request.getParameter("sort").equalsIgnoreCase("highest views")) {
                    items = view.sortByHighestViews(items);
                } else if (request.getParameter("sort").equalsIgnoreCase("lowest views")) {
                    items = view.sortByLowestViews(items);
                }
            }

            //---------//
            // generating location filters
            //---------//
            List resultDistricts = view.resultDistricts(items);
            List resultCities = view.resultCities(items);

            if (resultDistricts.size() > 1) {
                session.setAttribute("resultDistricts", resultDistricts);
            } else {
                session.setAttribute("resultDistricts", null);
            }

            if (resultDistricts.size() == 1 && resultCities.size() > 1) {
                session.setAttribute("resultCities", resultCities);
            } else {
                session.setAttribute("resultCities", null);
            }

            //---------//
            // generating category filters
            //---------//
            List resultMainCats = view.resultMainCats(items);
            List resultSubCats = view.resultSubCats(items);

            if (resultMainCats.size() > 1) {
                session.setAttribute("resultMainCats", resultMainCats);
            } else {
                session.setAttribute("resultMainCats", null);
            }

            if (resultMainCats.size() == 1 && resultSubCats.size() > 1) {
                session.setAttribute("resultSubCats", resultSubCats);
            } else {
                session.setAttribute("resultSubCats", null);
            }

            //---------//
            // pagination
            //---------//
            int size = items.size();

            if (size > 0) {
                session.setAttribute("searchResults", "yes");

                int rows_per_page = 10;
                int pages = 0;

                int flag = 0;
                int start = 0;
                int end = 0;

                if (0 < size % (int) rows_per_page) {
                    pages = (int) (size / (int) rows_per_page) + 1;
                    session.setAttribute("searchPageCount", pages);

                    for (int c = 1; c <= pages; c++) {
                        String session_id = Integer.toString(c);

                        int set = size - flag;

                        start = flag;
                        end = flag + (int) rows_per_page;

                        if (set < (int) rows_per_page) {
                            end = flag + set;
                        }

                        session.setAttribute("search" + session_id, items.subList(start, end));

                        flag = flag + (int) rows_per_page;
                    }
                } else {
                    pages = (int) (size / (int) rows_per_page);
                    session.setAttribute("searchPageCount", pages);

                    for (int c = 1; c <= pages; c++) {
                        String session_id = Integer.toString(c);

                        int set = size - flag;

                        start = flag;
                        end = flag + (int) rows_per_page;

                        if (set < (int) rows_per_page) {
                            end = flag + set;
                        }

                        session.setAttribute("search" + session_id, items.subList(start, end));

                        flag = flag + (int) rows_per_page;
                    }
                }

            } else {
                session.setAttribute("searchResults", "no");

                session.setAttribute("searchPageCount", 0);
            }
        } catch (NumberFormatException ex) {
            out.println("Servlet Exception: " + ex.getMessage());
        } catch (SQLException ex) {
            out.println("Servlet Exception: " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher("searchResults.jsp");
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
            Logger.getLogger(Search.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Search.class.getName()).log(Level.SEVERE, null, ex);
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
