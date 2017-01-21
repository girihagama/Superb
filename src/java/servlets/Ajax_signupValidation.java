/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.User_Class;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Indunil
 */
public class Ajax_signupValidation extends HttpServlet {

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

        try {
            if (request.getParameter("validate") != null) {
                String validate = request.getParameter("validate");

                if (validate.equalsIgnoreCase("username")) {
                    String username = request.getParameter("username");

                    if (request.getParameter("username") != null) {
                        if (user.userValidate(username)) {
                            myObj.addProperty("check", true);
                            myObj.addProperty("exist", true);
                        } else {
                            myObj.addProperty("check", true);
                            myObj.addProperty("exist", false);
                        }
                    } else {
                        myObj.addProperty("check", false);
                    }
                } else if (validate.equalsIgnoreCase("email")) {

                    if (request.getParameter("email") != null) {
                        String email = request.getParameter("email");

                        if (user.userValidate(email)) {
                            myObj.addProperty("check", true);
                            myObj.addProperty("exist", true);
                        } else {
                            myObj.addProperty("check", true);
                            myObj.addProperty("exist", false);
                        }
                    } else {
                        myObj.addProperty("check", false);
                    }
                } else if (validate.equalsIgnoreCase("confirm")) {

                    if (request.getParameter("username") != null && request.getParameter("email") != null) {
                        String email = request.getParameter("email");
                        String username = request.getParameter("username");
                        System.out.println("methanata awa1");
                        if (user.userValidate(username)) {
                            System.out.println("methanata awa2");
                            myObj.addProperty("check", true);
                            myObj.addProperty("unameexist", true);
                        } else {
                            System.out.println("methanata awa3");
                            myObj.addProperty("check", true);
                            myObj.addProperty("unameexist", false);
                        }
                        if (user.userValidate(email)) {
                            System.out.println("methanata awa4");
                            myObj.addProperty("check", true);
                            myObj.addProperty("emailexist", true);
                        } else {
                            System.out.println("methanata awa5");
                            myObj.addProperty("check", true);
                            myObj.addProperty("emailexist", false);
                        }
                    } else {
                        myObj.addProperty("check", false);
                    }
                } else {
                    myObj.addProperty("check", false);
                }
            } else {
                myObj.addProperty("check", false);
            }
        } catch (Exception e) {
            out.print(e.getMessage());

            myObj = null;
            myObj.addProperty("check", false);
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
