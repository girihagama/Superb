package classes;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

/**
 *
 * @author Indunil Tharanga
 */

/*
 USEAGE KEY

 YY = year in 2 digits
 YYYY = year in 4 digits

 MM = month in 2 digits
 MMM = month name in 3 letters (like Jan, Feb, ...)
 MMMM = full month name (like August, December, ....)

 d/dd = date in 2 digits

 EE = day name in 3 letters(like Sun, Mon, ...)
 EEEE = full day name (like sunday. monday, ....)

 --------------

 H/HH = hour in digits according to 24 hours
 h/hh = hour in digits according to 12 hours

 m/mm = minute in digits

 s/ss = second in digits
 S/SS/SSS = millisecons

 a = shows AM/PM

 ---------------

 z/zz/zzz = shows time zone short format (like BST, GMT)
 zzzz = shows time zone long format (like British Summer Time, Greenwich Mean Time, ....)

 Z = shows time zone offset (like +0530, -0200)
----------------
 */


public class TimeStamp {

    String timeZone = "Asia/Colombo";

    public String getTimestamp() {
        Date date = new Date();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        // Use time zone to format the date in
        df.setTimeZone(TimeZone.getTimeZone(timeZone));

        System.out.println(df.format(date));

        return (df.format(date));
    }

    public String getDateTimeByFormat(String format) {
        Date date = new Date();
        DateFormat df = new SimpleDateFormat(format);

        // Use time zone to format the date in
        df.setTimeZone(TimeZone.getTimeZone(timeZone));

        System.out.println(df.format(date));

        return (df.format(date));
    }
}
