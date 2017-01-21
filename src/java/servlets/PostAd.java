/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.ItemInfo_Class;
import classes.Item_Class;
import classes.TimeStamp;
import classes.User_Class;
import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.awt.image.RescaleOp;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Indunil
 */
@MultipartConfig
public class PostAd extends HttpServlet {

    //general
    int itemNumber = 0;

    //image process
    int imageNumber = 0;
    String destinationPath = "media/item_images/";

    //item process
    String adType;
    String categoryMain;
    String categorySub;
    String locationDistrict;
    String locationCity;

    //item info process
    String title;
    String description;
    String price;
    String negotiable;
    String voice;

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
            throws ServletException, IOException, Exception {
        //response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = getLogin(request);
        if (username == null) {
            response.setContentType("text/html;charset=UTF-8");
            out.println("<h1><center>Invalid Login Details!</center></h1>");
            out.println("<center><a href='SignProcess.jsp' target=\"_blank\">Click here to see sign process page.</a></center>");
            out.println("<center>Complete sign process and reload this page.</center>");
            return;
        }

        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = upload.parseRequest(request);//full list of request

        /*-----------------------
         Item Insertion Section
         -----------------------*/
        Iterator details = items.iterator();
        //getting details
        while (details.hasNext()) {
            FileItem item = (FileItem) details.next();

            if (item.getName() == null) {

                if (item.getFieldName().equalsIgnoreCase("adType")) {
                    adType = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("categoryMain")) {
                    categoryMain = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("categorySub")) {
                    categorySub = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("locationDistrict")) {
                    locationDistrict = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("locationCity")) {
                    locationCity = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("title")) {
                    title = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("description")) {
                    description = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("price")) {
                    price = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("negotiable")) {
                    negotiable = item.getString();
                } else if (item.getFieldName().equalsIgnoreCase("voice")) {
                    voice = item.getString();
                }
            }
        }

        try {
            //item insertion
            Item_Class newItem = new Item_Class();
            ItemInfo_Class info = new ItemInfo_Class();

            if (newItem.insertNewItem(username, categoryMain, categorySub, locationDistrict, locationCity, adType)) {
                //getting generated key for new item
                this.itemNumber = Integer.parseInt(newItem.getItem_number());
                out.println("Item " + this.itemNumber + " added!");

                //adding item info
                info.insertItem(this.itemNumber, title, description, price, negotiable, voice);
                out.println("Information for item " + this.itemNumber + " is added!");
            }
        } catch (Exception e) {
            System.out.println("Servlet Exception: " + e.getMessage());
        }

        /*-----------------------
         Image Upload Section
         ------------------------*/
        Iterator images = items.iterator();
        //getting images

        ArrayList imageList = new ArrayList();

        while (images.hasNext()) {
            FileItem item = (FileItem) images.next();

            if (item.getName() != null && "image/jpeg".equals(item.getContentType()) && !item.isFormField()) {
                //upload code
                imageList.add(item);
            }
        }

        uploadImages(imageList);

        //redirecting
        HttpSession session=request.getSession();
        session.setAttribute("submission", "true");
        response.sendRedirect("Home_myAds");
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        TimeStamp time = new TimeStamp();

        try {
            out.println("Unauthorise Access!<br>");
            out.println("Time: " + time.getTimestamp() + "<br>");
            out.println("IP: Saved");
        } catch (Exception e) {
            out.println(e.getMessage());
        } finally {
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
        //response.setContentType("text/html;charset=UTF-8");

        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(PostAd.class.getName()).log(Level.SEVERE, null, ex);
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

    private void uploadImages(ArrayList images) throws IOException {
        //PrintWriter out = response.getWriter();
        Iterator iterator = images.iterator();

        String root = getServletContext().getRealPath("/");

        this.imageNumber = 0;

        try {
            //creating folder
            File path = new File(root + destinationPath + itemNumber);
            path.setExecutable(true, true);
            path.setReadable(true, true);
            path.setWritable(true, true);

            if (path.isDirectory() && path.exists()) {
                String[] entries = path.list();
                for (String s : entries) {
                    File currentFile = new File(path.getPath(), s);
                    currentFile.delete();
                }
                path.delete();
                path.mkdir();
            } else {
                path.mkdir();
            }

            //adding images
            while (iterator.hasNext()) {
                FileItem item = (FileItem) iterator.next();

                String fileName = item.getName();

                if (this.imageNumber == 0) {
                    fileName = "cover.jpg";
                } else if (this.imageNumber > 0 && this.imageNumber < 5) {
                    fileName = this.imageNumber + ".jpg";
                }

                if (!path.exists()) {
                    boolean status = path.mkdirs();
                }

                File uploadedFile = new File(path.getAbsolutePath() + "/" + fileName);//saving file
                File copiedFile = new File(path.getAbsolutePath() + File.separator + fileName);//adding watermark

                item.write(uploadedFile);
                processImage(copiedFile);

                imageNumber++;
            }
        } catch (Exception e) {
            System.out.println("Servlet Exception: " + e.getMessage());
        }
    }

    private boolean processImage(File copiedFile) throws IOException {

        File inputFile = copiedFile; //input image        
        //File outputFile = copiedFile; //output image

        File outputFile = copiedFile;

        //entire path of file
        String fullPath = copiedFile.getAbsolutePath();
        //path without file name of file
        String filePath = FilenameUtils.getPath(copiedFile.getAbsolutePath());
        // file name without extension of file
        String fileName = FilenameUtils.getBaseName(copiedFile.getAbsolutePath());
        //extension of file
        String fileExtension = "." + FilenameUtils.getExtension(copiedFile.getAbsolutePath());

        String root = getServletContext().getRealPath("/");
        File watermark = new File(root + File.separator + "media/Watermark.png");//watermark image

        BufferedImage inputImage = null;

        inputImage = ImageIO.read(inputFile);
        BufferedImage watermarkImage = ImageIO.read(watermark);

        try {
            int watermarkX = 0;
            int watermarkY = 0;

            if (inputImage.getHeight() > inputImage.getWidth()) {
                int size = (int) (inputImage.getWidth() * 50 / 100);
                watermarkX = size;
                watermarkY = size;
            } else {
                int size = (int) (inputImage.getHeight() * 50 / 100);
                watermarkX = size;
                watermarkY = size;
            }

            System.out.println("Resising Watermark..");
            BufferedImage resizedImg = new BufferedImage(watermarkX, watermarkY, BufferedImage.TRANSLUCENT);
            Graphics2D g2 = resizedImg.createGraphics();
            g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
            g2.drawImage(watermarkImage, 0, 0, watermarkX, watermarkY, null);
            g2.dispose();
            watermarkImage = resizedImg;

            System.out.println("Drawing Watermark On Image..");
            // initializes necessary graphic properties
            Graphics2D g2d = (Graphics2D) inputImage.getGraphics();
            AlphaComposite alphaChannel = AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 0.15f);
            g2d.setComposite(alphaChannel);

            // calculates the coordinate where the image is painted
            int topLeftX = (int) (inputImage.getWidth() - watermarkImage.getWidth()) / 2;//(inputImage.getWidth() - watermarkImage.getWidth()) / 2;
            int topLeftY = (int) (inputImage.getHeight() - watermarkImage.getHeight()) / 2;//(inputImage.getHeight() - watermarkImage.getHeight()) / 2;

            // paints the image watermark
            g2d.drawImage(watermarkImage, topLeftX, topLeftY, null);

            //Adjesting Contrast & Brightness
            System.out.println("Adjesting Contrast & Brightness..");
            RescaleOp rescaleOp = new RescaleOp(1.05f, 15, null);
            rescaleOp.filter(inputImage, inputImage);
        } catch (Exception e) {
            System.out.println("CANNOT CREATE IMAGE..!");
            System.out.println("Image Process Exception: " + e.getMessage());
        }

        return ImageIO.write(inputImage, "jpg", outputFile);
    }
}
