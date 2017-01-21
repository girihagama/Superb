/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.Item_Class;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Indunil
 */
public class Ajax_updateItemCount extends HttpServlet {

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
        doGet(request, response);
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
            Item_Class item = new Item_Class();

            String electronics = Integer.toString(item.getItemCount("Electronics"));
            String vehicles = Integer.toString(item.getItemCount("Vehicles"));
            String property = Integer.toString(item.getItemCount("Property"));
            String jobVacancies = Integer.toString(item.getItemCount("Job Vacancies"));
            String businessServicesIndustry = Integer.toString(item.getItemCount("Business, Services & Industry"));
            String education = Integer.toString(item.getItemCount("Education"));
            String homeGarden = Integer.toString(item.getItemCount("Home & Garden"));
            String petsAnimals = Integer.toString(item.getItemCount("Pets & Animals"));
            String foodAgriculture = Integer.toString(item.getItemCount("Food & Agriculture"));
            String fashionHealthBeauty = Integer.toString(item.getItemCount("Fashion, Health & Beauty"));
            String hobbySportKids = Integer.toString(item.getItemCount("Hobby, Sport & Kids"));

            response.setContentType("text/xml");
            response.setCharacterEncoding("UTF-8");

            String content = "<details>\n"
                    + "<detail>\n"
                    + "     <category>Electronics</category>\n"
                    + "     <items>" + electronics + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Vehicles</category>\n"
                    + "     <items>" + vehicles + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Property</category>\n"
                    + "     <items>" + property + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Job Vacancies</category>\n"
                    + "     <items>" + jobVacancies + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Business, Services, Industry</category>\n"
                    + "     <items>" + businessServicesIndustry + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Education</category>\n"
                    + "     <items>" + education + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Home, Garden</category>\n"
                    + "     <items>" + homeGarden + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Pets, Animals</category>\n"
                    + "     <items>" + petsAnimals + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Food, Agriculture</category>\n"
                    + "     <items>" + foodAgriculture + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Fashion, Health, Beauty</category>\n"
                    + "     <items>" + fashionHealthBeauty + "</items>\n"
                    + "</detail>\n"
                    + "<detail>\n"
                    + "     <category>Hobby, Sport, Kids</category>\n"
                    + "     <items>" + hobbySportKids + "</items>\n"
                    + "</detail>\n"
                    + "</details>";

            response.getWriter().write(content);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
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
        doGet(request, response);
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
