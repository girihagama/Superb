/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Indunil
 */
public class ConvertTimeStamp {

    public String timeStampIn12h(String timestamp) throws ParseException {

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date dateTime = format.parse(timestamp);

        SimpleDateFormat localDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
        String time = localDateFormat.format(dateTime);
        System.out.println(time);

        return time;
    }      
    
}
