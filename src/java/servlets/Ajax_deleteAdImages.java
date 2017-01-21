/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.ItemView_Class;
import classes.User_Class;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Indunil
 */
public class Ajax_deleteAdImages extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
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

        try {
            String root = getServletContext().getRealPath("/");
            String folder = "media/item_images/";
            String itemNumber = request.getParameter("item") + File.separator;

            //# of files
            File[] items = new File(root + folder + itemNumber).listFiles();
            myObj.addProperty("files", items.length);

        } finally {
            out.println(myObj.toString());
            out.close();
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
        response.setContentType("text/html;charset=UTF-8");
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

        try {
            String root = getServletContext().getRealPath("/");
            String folder = "media/item_images/";
            String itm = request.getParameter("item");
            String itemNumber = itm + File.separator;
            String image = request.getParameter("name");

            File path = new File(root + folder + itemNumber + image);
            path.setExecutable(true, true);
            path.setReadable(true, true);
            path.setWritable(true, true);

            //user authentication
            ItemView_Class item = new ItemView_Class();
            boolean auth = item.checkEditAuthentication(getLogin(request), Integer.parseInt(itm));

            if (!auth) {
                return;
            }

            //remove item
            if (path.exists() && path.delete()) {
                myObj.addProperty("action", true);
            } else {
                myObj.addProperty("action", false);
            }

            //rename cover.jpg to 0.jpg
            File oldFile = new File(root + folder + itemNumber + "cover.jpg");
            oldFile.setExecutable(true, true);
            oldFile.setReadable(true, true);
            oldFile.setWritable(true, true);

            if (oldFile.exists()) {
                File newFile = new File(oldFile.getParent(), "0.jpg");
                newFile.setExecutable(true, true);
                newFile.setReadable(true, true);
                newFile.setWritable(true, true);
                Files.move(oldFile.toPath(), newFile.toPath());
            }

            //sort start
            File sortPath = new File(root + folder + itemNumber);
            File[] list = sortPath.listFiles();

            int i = 0;

            for (File list1 : list) {
                oldFile = new File(list1.getAbsolutePath());
                oldFile.setExecutable(true, true);
                oldFile.setReadable(true, true);
                oldFile.setWritable(true, true);
                if (oldFile.exists()) {
                    File newFile = new File(oldFile.getParent(), i + ".jpg");
                    newFile.setExecutable(true, true);
                    newFile.setReadable(true, true);
                    newFile.setWritable(true, true);
                    Files.move(oldFile.toPath(), newFile.toPath());
                }
                i++;
            }
            //sort end

            //rename 0.jpg to cover.jpg
            oldFile = new File(root + folder + itemNumber + "0.jpg");
            oldFile.setExecutable(true, true);
            oldFile.setReadable(true, true);
            oldFile.setWritable(true, true);
            if (oldFile.exists()) {
                File newFile = new File(oldFile.getParent(), "cover.jpg");
                newFile.setExecutable(true, true);
                newFile.setReadable(true, true);
                newFile.setWritable(true, true);
                Files.move(oldFile.toPath(), newFile.toPath());
            }

            //# of files
            File[] items = new File(root + folder + itemNumber).listFiles();
            myObj.addProperty("files", items.length);

            //new Image data
            ArrayList newData = new ArrayList();
            list = sortPath.listFiles();
            for (File list1 : list) {
                List file = new ArrayList();
                file.add(list1.getName());
                file.add(list1.getParentFile().getParentFile().getParentFile().getName() + "/" + list1.getParentFile().getParentFile().getName() + "/" + list1.getParentFile().getName() + "/" + list1.getName());
                newData.add(file);
            }
            myObj.add("newData", gson.toJsonTree(newData));

            //fix 0.jpg to cover.jpg
            File fixBefore = new File(root + folder + itemNumber + "0.jpg");
            fixBefore.setExecutable(true, true);
            fixBefore.setReadable(true, true);
            fixBefore.setWritable(true, true);

            System.out.println("[delete] - " + fixBefore.getAbsolutePath() + " -- " + fixBefore.exists());

            File fixAfter = new File(root + folder + itemNumber + "cover.jpg");
            fixAfter.setExecutable(true, true);
            fixAfter.setReadable(true, true);
            fixAfter.setWritable(true, true);

            System.out.println("[delete] - " + fixAfter.getAbsolutePath() + " -- " + fixAfter.exists());

            //Files.move(fixBefore.toPath(), fixAfter.toPath());
            if (fixBefore.exists()) {
                //Files.move(fixBefore.toPath(), fixAfter.toPath(), REPLACE_EXISTING);  
                fixBefore.renameTo(fixAfter);
            }            
        } catch (SQLException ex) {
            System.out.println("Servlet Exception: " + ex.getMessage());
        } finally {
            out.println(myObj.toString());
            out.close();
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
