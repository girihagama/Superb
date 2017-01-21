/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Properties;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Indunil
 */
public class SendMail {

    public boolean sendActivationCode(String receiverAddress, long activationCode) throws SQLException {
        //to get username of the user
        User_Class user = new User_Class();

        Date curDate = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("dd, MMMM yyyy", Locale.ENGLISH);
        String timeZone = "Asia/Colombo";

        sdf.setTimeZone(TimeZone.getTimeZone(timeZone));

        String DateToStr = sdf.format(curDate);
        int result = 1;

        Properties props = new Properties();
        props.setProperty("mail.host", "mail.superb.lk");
        props.setProperty("mail.smtp.port", "25");
        props.setProperty("mail.smtp.auth", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                //TODO Auto-generated method stub
                return new PasswordAuthentication("support@superb.lk", "support@ishan");
            }
        };

        Session session = Session.getInstance(props, auth);
        Message msg = new MimeMessage(session);

        String mailSubject = "Superb.lk Activation Code For Your Account!";
        String mailBody = "<html>\n"
                + "    <head>\n"
                + "        <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n"
                + "        <title>Nettuts Email Newsletter</title>\n"
                + "        <style type='text/css'>\n"
                + "            a {color: #4A72AF;}\n"
                + "            body, #header h1, #header h2, p {margin: 0; padding: 0;}\n"
                + "            #main {border: 1px solid #cfcece;}\n"
                + "            img {display: block;}\n"
                + "            #top-message p, #bottom-message p {color: #3f4042; font-size: 12px; font-family: Arial, Helvetica, sans-serif; }\n"
                + "            #header h1 {color: #ffffff !important; font-family: 'Lucida Grande', 'Lucida Sans', 'Lucida Sans Unicode', sans-serif; font-size: 24px; margin-bottom: 0!important; padding-bottom: 0; }\n"
                + "            #header h2 {color: #ffffff !important; font-family: Arial, Helvetica, sans-serif; font-size: 24px; margin-bottom: 0 !important; padding-bottom: 0; }\n"
                + "            #header p {color: #ffffff !important; font-family: 'Lucida Grande', 'Lucida Sans', 'Lucida Sans Unicode', sans-serif; font-size: 12px;  }\n"
                + "            h1, h2, h3, h4, h5, h6 {margin: 0 0 0.8em 0;}\n"
                + "            h3 {font-size: 28px; color: #444444 !important; font-family: Arial, Helvetica, sans-serif; }\n"
                + "            h4 {font-size: 22px; color: #4A72AF !important; font-family: Arial, Helvetica, sans-serif; }\n"
                + "            h5 {font-size: 18px; color: #444444 !important; font-family: Arial, Helvetica, sans-serif; }\n"
                + "            p {font-size: 12px; color: #444444 !important; font-family: 'Lucida Grande', 'Lucida Sans', 'Lucida Sans Unicode', sans-serif; line-height: 1.5;}\n"
                + "            tr.four-px { height:30px;  }\n"
                + "            button {display: inline-block;border-radius: 4px;  background-color: #4C649B;  border: none;  color: #FFFFFF;  text-align: center;  font-size: auto;  padding: 10px;  width: auto;  transition: all 0.5s;  cursor: pointer;  margin: 5px;}\n"
                + "            button span {  cursor: pointer;  display: inline-block;  position: relative;  transition: 0.5s;}\n"
                + "            button span:after {  content: '»';  position: absolute;  opacity: 0;  top: 0;  right: -20px;  transition: 0.5s;}\n"
                + "            button:hover span {  padding-right: 25px;}\n"
                + "            button:hover span:after {  opacity: 1;  right: 0;}\n"
                + "        </style>\n"
                + "    </head>\n"
                + "\n"
                + "\n"
                + "\n"
                + "    <body>\n"
                + "\n"
                + "\n"
                + "        <table width='100%' cellpadding='0' cellspacing='0' bgcolor='e4e4e4'><tr><td>\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "                    <table id='main' width='600' align='center' cellpadding='0' cellspacing='15' bgcolor='ffffff'>\n"
                + "                        <tr>\n"
                + "                            <td>\n"
                + "                                <table id='header' cellpadding='10' cellspacing='0' align='center' bgcolor='8fb3e9'>\n"
                + "                                    <tr>\n"
                + "                                        <td width='570' bgcolor='2273F8'><img src='http://superb.lk/ng-admin/images/logo.png' width='170' /></td>\n"
                + "                                    </tr>\n"
                + "                                    <tr>\n"
                + "                                        <td width='570' bgcolor='2273F8' ><h5 style='color:#ffffff!important'>Superb Classifieds in Sri Lanka</h5></td>\n"
                + "                                    </tr>\n"
                + "                                    <tr>\n"
                + "                                        <td width='570' align='right' bgcolor='7aa7e9'><p style='color:#ffffff!important'>" + DateToStr + "</p></td>\n"
                + "                                    </tr>\n"
                + "                                </table><!-- header -->\n"
                + "                            </td>\n"
                + "                        </tr><!-- header -->\n"
                + "\n"
                + "                        <tr>\n"
                + "                            <td></td>\n"
                + "                        </tr>\n"
                + "                        <tr>\n"
                + "                            <td>\n"
                + "                                <table id='content-1' cellpadding='0' cellspacing='0' align='center'>\n"
                + "                                    <tr>\n"
                + "                                        <td  valign='top'  align='center'>\n"
                + "                                            <h4><u>Superb.lk Activation Code For Your Account!</u></h4>\n"
                + "                                        </td>\n"
                + "                                    </tr>\n"
                + "                                </table><!-- content 1 -->\n"
                + "                            </td>\n"
                + "                        </tr><!-- content 1 -->\n"
                + "                        <tr>\n"
                + "                            <td>\n"
                + "                                <table id='content-2' cellpadding='0' cellspacing='0' align='center'>\n"
                + "                                    <tr style='height: 40px;'><td><h2>Hello " + user.requetUsername(receiverAddress) + ",</h2></td></tr>\n"
                + "                                    <tr><td></td></tr>\n"
                + "                                    <tr>\n"
                + "                                        <td width='570'>"
                + "                                             - Following number is your account activation code."
                + "                                             <br>"
                + "                                             - Copy it and go to Superb.lk and try login."
                + "                                             <br>"
                + "                                             - Then you can see the account activation form."
                + "                                             <br>"
                + "                                             - Paste your number and click 'Activate' Button."
                + "                                             <br>"
                + "                                             - If the code doesn't work, Request a new code using 'Request New' button."
                + "                                             <br>"
                + "                                             - If you can't activate your account please do not hesitate to contact support."
                + "                                             <br>"
                + "					<center>"
                + "					<div style='padding: 5px; margin: 5px; border-radius:5px;'>"
                + "					<h5 style='text-align: center; color:red;'>"
                + "					Your Activation Code is : " + activationCode
                + "					</h5>"
                + "					</div>"
                + "					</center>"
                + "					</td>\n"
                + "                                    </tr>\n"
                + "				       <tr style='height: 30px;'><td><center><h5>"
                + "					Or"
                + "					</h5></center></td></tr>"
                + "                                    <tr style='height: 30px;'><td><center><span><a  style=\"color:white; text-decoration: none;\" href='http://www.superb.lk/web/index.jsp?uy1actecd=" + activationCode + "&act=true&usdsp=" + user.requetUsername(receiverAddress) + "&ref=73quy' target='_blank'><button style=\"vertical-align:middle\">Please click here to activaite your account directly</button></a></span><center></td></tr>\n"
                + "				       <tr style='height: 30px;'><td><center><h5>"
                + "					Thank You!"
                + "					</h5></center></td></tr>"
                + "                                    <tr style='height: 40px;'><td><p>Regards,</p></td></tr>\n"
                + "                                    <tr><td><p>The support team at Superb.lk</p></td></tr>\n"
                + "                                </table><!-- content-2 -->\n"
                + "                            </td>\n"
                + "                        </tr><!-- content-2 -->\n"
                + "                        <tr class='four-px'></tr>\n"
                + "                        <tr>\n"
                + "                            <td style='margin-top: 300px;'>\n"
                + "                                <table id='content-6' cellpadding='0' cellspacing='0' align='center'>\n"
                + "                                    <p align='center'>--------------------------------------------</p>\n"
                + "                                    <p align='center'>\n"
                + "                                        Did you know that Superb.lk has the best mobile deals in Sri Lanka? </p>\n"
                + "                                    <p align='center'><a target='blank' href='http://www.Superb.lk'>Visit Superb.lk</a></p>\n"
                + "                                </table>\n"
                + "                            </td>\n"
                + "                        </tr>\n"
                + "\n"
                + "                    </table><!-- main -->\n"
                + "                    <table id='bottom-message' cellpadding='0' cellspacing='0' width='300' align='center'>\n"
                + "                        <tr style='height: 0px;'>\n"
                + "                            <td></td>\n"
                + "                            <td align='center'>\n"
                + "                                <p>Follow us on</p>\n"
                + "\n"
                + "                            </td>\n"
                + "                        </tr>\n"
                + "                        <tr>\n"
                + "\n"
                + "                            <td align='center'><a target='blank' href='#'><img src='http://superb.lk/ng-admin/images/facebook.png' width='40' /></a></td>\n"
                + "                            <td align='center'><a target='blank' href='#'><img src='http://superb.lk/ng-admin/images/twitter.png' width='40' /></a></td>\n"
                + "                            <td align='center'><a target='blank' href='#'><img src='http://superb.lk/ng-admin/images/google.png' width='40' /></a></td>\n"
                + "                        </tr>\n"
                + "                    </table><!-- top message -->\n"
                + "                </td></tr></table><!-- wrapper -->\n"
                + "\n"
                + "\n"
                + "\n"
                + "    </body>\n"
                + "</html>";

        try {
            msg.setSubject(mailSubject);

            msg.setContent(mailBody, "text/html; charset=utf-8");

            msg.setFrom(new InternetAddress("support@superb.lk", "Superb.lk - Support"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(receiverAddress));
            Transport.send(msg);
        } catch (MessagingException ex) {
            result = 0;
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);

        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (result == 1) {
            return true;
        } else {
            return false;
        }
    }

    public boolean sendEmailToAdvertiser(String receiverAddress, String message_content, String sender_address, int itemNumber) {
        boolean sent = true;

        //to get username of the user
        User_Class user = new User_Class();

        Properties props = new Properties();
        props.setProperty("mail.host", "mail.superb.lk");
        props.setProperty("mail.smtp.port", "25");
        props.setProperty("mail.smtp.auth", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                //TODO Auto-generated method stub
                return new PasswordAuthentication("support@superb.lk", "support@ishan");
            }
        };

        Session session = Session.getInstance(props, auth);
        Message msg = new MimeMessage(session);

        try {
            String mailSubject = "Someone is interested in your advertistment!";
            String mailBody = "<h2>Hello " + user.requetUsername(receiverAddress) + ", <small>You have received a message to your advertistment <a href='http://www.Superb.lk/ViewAd?itemNumber=" + itemNumber + "'>[Item Number:" + itemNumber + "]</a></small></h2>"
                    + "<div><b style='color:blue;'>Message: </b>" + message_content + "</div>"
                    + "<div><b style='color:blue;'>Sender Email Address: </b><a href='mailto:" + sender_address + "' target=\"_top\">" + sender_address + "</a></div>";

            msg.setSubject(mailSubject);

            msg.setContent(mailBody, "text/html; charset=utf-8");

            msg.setFrom(new InternetAddress("support@superb.lk", "Superb.lk - Support"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(receiverAddress));
            Transport.send(msg);
        } catch (MessagingException e) {
            System.out.println("Class Exception: " + e.getMessage());
            sent = false;
        } catch (UnsupportedEncodingException e) {
            System.out.println("Class Exception: " + e.getMessage());
            sent = false;
        } catch (SQLException ex) {
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);
            sent = false;
        }

        return sent;
    }

    public boolean reporterFeedback(int itemNumber, String reporter_email, String report_reason, String reporter_message) {
        boolean sent = true;

        Properties props = new Properties();
        props.setProperty("mail.host", "mail.superb.lk");
        props.setProperty("mail.smtp.port", "25");
        props.setProperty("mail.smtp.auth", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                //TODO Auto-generated method stub
                return new PasswordAuthentication("support@superb.lk", "support@ishan");
            }
        };

        Session session = Session.getInstance(props, auth);
        Message msg = new MimeMessage(session);

        try {
            String mailSubject = "Your report has been received and is being reviewed by our support staff!";
            String mailBody = "<h2>You reported Superb.lk advertistment <a href='http://www.Superb.lk/ViewAd?itemNumber=" + itemNumber + "'>[Item Number:" + itemNumber + "]</a></h2>"
                    + "<br><b style='color:blue;'>Report Reason: </b>" + report_reason
                    + "<br><b style='color:blue;'>Your Message: </b>" + reporter_message;

            msg.setSubject(mailSubject);

            msg.setContent(mailBody, "text/html; charset=utf-8");

            msg.setFrom(new InternetAddress("support@superb.lk", "Superb.lk - Support"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(reporter_email));
            Transport.send(msg);
        } catch (MessagingException e) {
            System.out.println("Class Exception(" + this.getClass() + "): " + e.getMessage());
            sent = false;
        } catch (UnsupportedEncodingException e) {
            System.out.println("Class Exception(" + this.getClass() + "): " + e.getMessage());
            sent = false;
        }

        return sent;
    }

    public boolean sendPasswordResetCode(String receiverAddress, long resetCode) throws SQLException {
        User_Class user = new User_Class();
        receiverAddress = user.requetEmail(receiverAddress);

        Date curDate = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("dd, MMMM yyyy", Locale.ENGLISH);
        String timeZone = "Asia/Colombo";

        sdf.setTimeZone(TimeZone.getTimeZone(timeZone));

        String DateToStr = sdf.format(curDate);

        int result = 1;

        Properties props = new Properties();
        props.setProperty("mail.host", "mail.superb.lk");
        props.setProperty("mail.smtp.port", "25");
        props.setProperty("mail.smtp.auth", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                //TODO Auto-generated method stub
                return new PasswordAuthentication("support@superb.lk", "support@ishan");
            }
        };

        Session session = Session.getInstance(props, auth);
        Message msg = new MimeMessage(session);

        String mailSubject = "Superb.lk Password Reset Code!";
        String mailBody = "<html>\n"
                + "    <head>\n"
                + "        <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n"
                + "        <title>Nettuts Email Newsletter</title>\n"
                + "        <style type='text/css'>\n"
                + "            a {color: #4A72AF;}\n"
                + "            body, #header h1, #header h2, p {margin: 0; padding: 0;}\n"
                + "            #main {border: 1px solid #cfcece;}\n"
                + "            img {display: block;}\n"
                + "            #top-message p, #bottom-message p {color: #3f4042; font-size: 12px; font-family: Arial, Helvetica, sans-serif; }\n"
                + "            #header h1 {color: #ffffff !important; font-family: 'Lucida Grande', 'Lucida Sans', 'Lucida Sans Unicode', sans-serif; font-size: 24px; margin-bottom: 0!important; padding-bottom: 0; }\n"
                + "            #header h2 {color: #ffffff !important; font-family: Arial, Helvetica, sans-serif; font-size: 24px; margin-bottom: 0 !important; padding-bottom: 0; }\n"
                + "            #header p {color: #ffffff !important; font-family: 'Lucida Grande', 'Lucida Sans', 'Lucida Sans Unicode', sans-serif; font-size: 12px;  }\n"
                + "            h1, h2, h3, h4, h5, h6 {margin: 0 0 0.8em 0;}\n"
                + "            h3 {font-size: 28px; color: #444444 !important; font-family: Arial, Helvetica, sans-serif; }\n"
                + "            h4 {font-size: 22px; color: #4A72AF !important; font-family: Arial, Helvetica, sans-serif; }\n"
                + "            h5 {font-size: 18px; color: #444444 !important; font-family: Arial, Helvetica, sans-serif; }\n"
                + "            p {font-size: 12px; color: #444444 !important; font-family: 'Lucida Grande', 'Lucida Sans', 'Lucida Sans Unicode', sans-serif; line-height: 1.5;}\n"
                + "            tr.four-px { height:30px;  }\n"
                + "        </style>\n"
                + "    </head>\n"
                + "\n"
                + "\n"
                + "\n"
                + "    <body>\n"
                + "\n"
                + "\n"
                + "        <table width='100%' cellpadding='0' cellspacing='0' bgcolor='e4e4e4'><tr><td>\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "                    <table id='main' width='600' align='center' cellpadding='0' cellspacing='15' bgcolor='ffffff'>\n"
                + "                        <tr>\n"
                + "                            <td>\n"
                + "                                <table id='header' cellpadding='10' cellspacing='0' align='center' bgcolor='8fb3e9'>\n"
                + "                                    <tr>\n"
                + "                                        <td width='570' bgcolor='2273F8'><img src='http://superb.lk/ng-admin/images/logo.png' width='170' /></td>\n"
                + "                                    </tr>\n"
                + "                                    <tr>\n"
                + "                                        <td width='570' bgcolor='2273F8' ><h5 style='color:#ffffff!important'>Superb Classifieds in Sri Lanka</h5></td>\n"
                + "                                    </tr>\n"
                + "                                    <tr>\n"
                + "                                        <td width='570' align='right' bgcolor='7aa7e9'><p style='color:#ffffff!important'>" + DateToStr + "</p></td>\n"
                + "                                    </tr>\n"
                + "                                </table><!-- header -->\n"
                + "                            </td>\n"
                + "                        </tr><!-- header -->\n"
                + "\n"
                + "                        <tr>\n"
                + "                            <td></td>\n"
                + "                        </tr>\n"
                + "                        <tr>\n"
                + "                            <td>\n"
                + "                                <table id='content-1' cellpadding='0' cellspacing='0' align='center'>\n"
                + "                                    <tr>\n"
                + "                                        <td  valign='top'  align='center'>\n"
                + "                                            <h4><u>Superb.lk Password Reset Code</u></h4>\n"
                + "                                        </td>\n"
                + "                                    </tr>\n"
                + "                                </table><!-- content 1 -->\n"
                + "                            </td>\n"
                + "                        </tr><!-- content 1 -->\n"
                + "                        <tr>\n"
                + "                            <td>\n"
                + "                                <table id='content-2' cellpadding='0' cellspacing='0' align='center'>\n"
                + "                                    <tr style='height: 40px;'><td><h2>Hello " + user.requetUsername(receiverAddress) + ",</h2></td></tr>\n"
                + "                                    <tr><td></td></tr>\n"
                + "                                    <tr>\n"
                + "                                        <td width='570'>"
                + "					- Following number is your password reset code."
                + "					<br>"
                + "					- Please click following link to reset your password."
                + "					<br>"
                + "					- If the code doesn't work, Request a new code"
                + "					<br>"
                + "					- If you can't reset your password please do not hesitate to contact support."
                + "					<br>"
                + "					<center>"
                + "					<div style='padding: 5px; margin: 5px; border-radius:5px;'>"
                + "					<h5 style='text-align: center; color:red;'>"
                + "					Your Password Reset Code is : " + resetCode
                + "					</h5>"
                + "					<h5>"
                + "					Thank You!"
                + "					</h5>"
                + "					</div>"
                + "					</center>"
                + "					</td>\n"
                + "                                    </tr>\n"
                + "                                    <tr style='height: 30px;'><td><center><a href='http://www.superb.lk/web/index.jsp?uy1awqecd=" + resetCode + "&reset=true&ref=73quy' target='_blank'>Please click here to reset the password </a><center></td></tr>\n" //http://www.superb.lk/web/index.jsp?
                + "                                    <tr style='height: 40px;'><td><p>Regards,</p></td></tr>\n"
                + "                                    <tr><td><p>The support team at Superb.lk</p></td></tr>\n"
                + "                                </table><!-- content-2 -->\n"
                + "                            </td>\n"
                + "                        </tr><!-- content-2 -->\n"
                + "                        <tr class='four-px'></tr>\n"
                + "                        <tr>\n"
                + "                            <td style='margin-top: 300px;'>\n"
                + "                                <table id='content-6' cellpadding='0' cellspacing='0' align='center'>\n"
                + "                                    <p align='center'>--------------------------------------------</p>\n"
                + "                                    <p align='center'>\n"
                + "                                        Did you know that Superb.lk has the best mobile deals in Sri Lanka? </p>\n"
                + "                                    <p align='center'><a target='blank' href='http://www.Superb.lk'>Visit Superb.lk</a></p>\n"
                + "                                </table>\n"
                + "                            </td>\n"
                + "                        </tr>\n"
                + "\n"
                + "                    </table><!-- main -->\n"
                + "                    <table id='bottom-message' cellpadding='0' cellspacing='0' width='300' align='center'>\n"
                + "                        <tr style='height: 0px;'>\n"
                + "                            <td></td>\n"
                + "                            <td align='center'>\n"
                + "                                <p>Follow us on</p>\n"
                + "\n"
                + "                            </td>\n"
                + "                        </tr>\n"
                + "                        <tr>\n"
                + "\n"
                + "                            <td align='center'><a target='blank' href='#'><img src='http://superb.lk/ng-admin/images/facebook.png' width='40' /></a></td>\n"
                + "                            <td align='center'><a target='blank' href='#'><img src='http://superb.lk/ng-admin/images/twitter.png' width='40' /></a></td>\n"
                + "                            <td align='center'><a target='blank' href='#'><img src='http://superb.lk/ng-admin/images/google.png' width='40' /></a></td>\n"
                + "                        </tr>\n"
                + "                    </table><!-- top message -->\n"
                + "                </td></tr></table><!-- wrapper -->\n"
                + "\n"
                + "\n"
                + "\n"
                + "    </body>\n"
                + "</html>";

        try {
            msg.setSubject(mailSubject);

            msg.setContent(mailBody, "text/html; charset=utf-8");

            msg.setFrom(new InternetAddress("support@superb.lk", "Superb.lk - Support"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(receiverAddress));
            Transport.send(msg);
        } catch (MessagingException ex) {
            result = 0;
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            result = 0;
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result == 1;
        }
    }

    void passwordResetMail(String login) throws SQLException {
        User_Class user = new User_Class();
        login = user.requetEmail(login);

        int result = 1;

        Properties props = new Properties();
        props.setProperty("mail.host", "mail.superb.lk");
        props.setProperty("mail.smtp.port", "25");
        props.setProperty("mail.smtp.auth", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                //TODO Auto-generated method stub
                return new PasswordAuthentication("support@superb.lk", "support@ishan");
            }
        };

        Session session = Session.getInstance(props, auth);
        Message msg = new MimeMessage(session);

        String mailSubject = "Superb.lk Password Reset!";
        String mailBody = "<h2>Hello " + user.requetUsername(login) + ",</h2>"
                + "<br>"
                + "You just reset the password of your Superb.lk account!"
                + "<br>"
                + "- Thank You!"
                + "</h3>"
                + "</center>";

        try {
            msg.setSubject(mailSubject);

            msg.setContent(mailBody, "text/html; charset=utf-8");

            msg.setFrom(new InternetAddress("support@superb.lk", "Superb.lk - Support"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(login));
            Transport.send(msg);
        } catch (MessagingException ex) {
            result = 0;
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);

        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean contactSupport(String email, String message) {
        int result = 1;

        Properties props = new Properties();
        props.setProperty("mail.host", "mail.superb.lk");
        props.setProperty("mail.smtp.port", "25");
        props.setProperty("mail.smtp.auth", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                //TODO Auto-generated method stub
                return new PasswordAuthentication("support@superb.lk", "support@ishan");
            }
        };

        Session session = Session.getInstance(props, auth);
        Message msg = new MimeMessage(session);

        String mailSubject = "Superb.lk Support Request";
        String mailBody = "<html>"
                + "<head></head>"
                + "<body>"
                + "<center><h2>Support Needed!</h2></center>"
                + "<br>"
                + "<b><i>Sender's Mail:-</i></b> " + email
                + "<br><br>"
                + "<b><i>Reason For Contact:-</i></b> " + message
                + "<br>"
                + "<center>--End Of meaasge--</center>"
                + "</body>"
                + "</html>";

        try {
            msg.setSubject(mailSubject);

            msg.setContent(mailBody, "text/html; charset=utf-8");

            msg.setFrom(new InternetAddress("support@superb.lk", "Superb.lk - Contact Support"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress("ismadurasingha@gmail.com"));//
            Transport.send(msg);
        } catch (MessagingException ex) {
            result = 0;
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Class exception: " + ex.getMessage());
        } catch (UnsupportedEncodingException ex) {
            result = 0;
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Class exception: " + ex.getMessage());
        }

        return result > 0;
    }
}
