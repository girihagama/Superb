/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author Indunil
 */
public class ItemView_Class {

    private int item_number;
    private String username;
    private String time_stamp;
    private String category_main;
    private String category_sub;
    private String district;
    private String city;
    private String ad_form;
    private String title;
    private String content;
    private String contact_number;
    private String negotiable;
    private int price;
    private int view_count;
    private String status;
    private String reason;

//    protected List resultDistrictList;
//    protected List resultCityList;
//    protected List resultMainCategoryList;
//    protected List resultSubCategoryList;
    Db_Class db = new Db_Class();

    /**
     * @return the item_number
     */
    public int getItem_number() {
        return item_number;
    }

    /**
     * @param item_number the item_number to set
     */
    public void setItem_number(int item_number) {
        this.item_number = item_number;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the time_stamp
     */
    public String getTime_stamp() {
        return time_stamp;
    }

    /**
     * @param time_stamp the time_stamp to set
     */
    public void setTime_stamp(String time_stamp) {
        this.time_stamp = time_stamp;
    }

    /**
     * @return the category_main
     */
    public String getCategory_main() {
        return category_main;
    }

    /**
     * @param category_main the category_main to set
     */
    public void setCategory_main(String category_main) {
        this.category_main = category_main;
    }

    /**
     * @return the category_sub
     */
    public String getCategory_sub() {
        return category_sub;
    }

    /**
     * @param category_sub the category_sub to set
     */
    public void setCategory_sub(String category_sub) {
        this.category_sub = category_sub;
    }

    /**
     * @return the district
     */
    public String getDistrict() {
        return district;
    }

    /**
     * @param district the district to set
     */
    public void setDistrict(String district) {
        this.district = district;
    }

    /**
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * @return the ad_form
     */
    public String getAd_form() {
        return ad_form;
    }

    /**
     * @param ad_form the ad_form to set
     */
    public void setAd_form(String ad_form) {
        this.ad_form = ad_form;
    }

    /**
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return the content
     */
    public String getContent() {
        return content;
    }

    /**
     * @param content the content to set
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * @return the contact_number
     */
    public String getContact_number() {
        return contact_number;
    }

    /**
     * @param contact_number the contact_number to set
     */
    public void setContact_number(String contact_number) {
        this.contact_number = contact_number;
    }

    /**
     * @return the negotiable
     */
    public String getNegotiable() {
        return negotiable;
    }

    /**
     * @param negotiable the negotiable to set
     */
    public void setNegotiable(String negotiable) {
        this.negotiable = negotiable;
    }

    /**
     * @return the price
     */
    public int getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(int price) {
        this.price = price;
    }

    /**
     * @return the view_count
     */
    public int getView_count() {
        return view_count;
    }

    /**
     * @param view_count the view_count to set
     */
    public void setView_count(int view_count) {
        this.view_count = view_count;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the reason
     */
    public String getReason() {
        return reason;
    }

    /**
     * @param reason the reason to set
     */
    public void setReason(String reason) {
        this.reason = reason;
    }

    //class methods
    /**
     * Only admins can see ads that are currently under Modifying, Blocked if
     * viewerName = null they can view only active ads.
     *
     * @param itemNumber
     * @param viewer
     * @return
     * @throws java.sql.SQLException
     */
    public ItemView_Class viewItemAsAdmin(int itemNumber) throws SQLException {
        ItemView_Class item = new ItemView_Class();

        User_Class user = new User_Class();

        try {
            db.getConnection();

            String sql = "SELECT * FROM itemview WHERE item_number= ? ";

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setInt(1, itemNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                item.setItem_number(rs.getInt("item_number"));
                item.setUsername(rs.getString("username"));
                item.setTime_stamp(rs.getString("time_stamp"));
                item.setCategory_main(rs.getString("category_main"));
                item.setCategory_sub(rs.getString("category_sub"));
                item.setDistrict(rs.getString("district"));
                item.setCity(rs.getString("city"));
                item.setAd_form(rs.getString("ad_form"));
                item.setTitle(rs.getString("title"));
                item.setContent(rs.getString("content"));
                item.setContact_number(rs.getString("contact_number"));
                item.setNegotiable(rs.getString("negotiable"));
                item.setPrice(rs.getInt("price"));
                item.setView_count(rs.getInt("view_count"));
                item.setStatus(rs.getString("status"));

                if (rs.getString("reason") != null) {
                    item.setReason(rs.getString("reason"));
                } else {
                    item.setReason("");
                }
            }
            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Exception: " + ex.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return item;
    }

    public ItemView_Class viewItemAsNormal(int itemNumber) throws SQLException {
        ItemView_Class item = new ItemView_Class();

        User_Class user = new User_Class();

        try {
            db.getConnection();

            String sql = "SELECT * FROM itemview WHERE item_number= ? ";

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setInt(1, itemNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                item.setItem_number(rs.getInt("item_number"));
                item.setUsername(rs.getString("username"));
                item.setTime_stamp(rs.getString("time_stamp"));
                item.setCategory_main(rs.getString("category_main"));
                item.setCategory_sub(rs.getString("category_sub"));
                item.setDistrict(rs.getString("district"));
                item.setCity(rs.getString("city"));
                item.setAd_form(rs.getString("ad_form"));
                item.setTitle(rs.getString("title"));
                item.setContent(rs.getString("content"));
                item.setContact_number(rs.getString("contact_number"));
                item.setNegotiable(rs.getString("negotiable"));
                item.setPrice(rs.getInt("price"));
                item.setView_count(rs.getInt("view_count"));
                item.setStatus(rs.getString("status"));

                if (rs.getString("reason") != null) {
                    item.setReason(rs.getString("reason"));
                } else {
                    item.setReason("");
                }
            }
            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Exception: " + ex.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return item;
    }

    public ArrayList myAds(String login) throws SQLException {
        User_Class user = new User_Class();
        String username = user.requetUsername(login);

        ArrayList items = new ArrayList();

        try {
            String query = "SELECT * FROM itemview WHERE username = ? ORDER BY `time_stamp` DESC";//modified, remove 'order by `time_stamp` DESC' in case of error

            db.getConnection();
            PreparedStatement psmt = db.conn.prepareStatement(query);
            psmt.setString(1, username);

            ResultSet rs = psmt.executeQuery();

            while (rs.next()) {
                ItemView_Class newItem = new ItemView_Class();

                newItem.setItem_number(rs.getInt("item_number"));
                newItem.setUsername(rs.getString("username"));
                newItem.setTime_stamp(rs.getString("time_stamp"));
                newItem.setCategory_main(rs.getString("category_main"));
                newItem.setCategory_sub(rs.getString("category_sub"));
                newItem.setDistrict(rs.getString("district"));
                newItem.setCity(rs.getString("city"));
                newItem.setAd_form(rs.getString("ad_form"));
                newItem.setTitle(rs.getString("title"));
                newItem.setContent(rs.getString("content"));
                newItem.setContact_number("contact_number");
                newItem.setNegotiable(rs.getString("negotiable"));
                newItem.setPrice(rs.getInt("price"));
                newItem.setView_count(rs.getInt("view_count"));
                newItem.setStatus(rs.getString("status"));

                if (rs.getString("reason") != null) {
                    newItem.setReason(rs.getString("reason"));
                } else {
                    newItem.setReason("");
                }

                items.add(newItem);
            }
            db.endConnection();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        System.out.println("ItemView_Class | myAds : ads - " + items.size());
        return items;
    }

    /**
     * Returns results according to received parameters
     *
     * @param search
     * @param adType
     * @param categoryMain
     * @param categorySub
     * @param category
     * @param city
     * @param district
     * @param location
     * @param maxPrice
     * @param minPrice
     * @return
     */
    public ArrayList searchItems(String search, String adType, String categoryMain, String categorySub, String category, String district, String city, String location, int minPrice, int maxPrice) throws SQLException {
        //array list to load results
        ArrayList<ItemView_Class> items = new ArrayList();

        try {
            if (search == null) {
                search = "";
            } else {
                String term = search;
                search = "";
                //search = "MATCH(`title`) AGAINST('" + term + "') ";
                //search += "OR MATCH(`content`) AGAINST('" + term + "') ";
                //search += "OR item_number like '" + term + "'";

                String[] parts = term.split(" ");

                search += "title like '%" + term + "%' OR content like '%" + term + "%' OR item_number like '%" + term + "%'";
                for (int i = 0; i < parts.length; i++) {
                    search = search + " OR title like '%" + parts[i] + "%' OR content like '%" + parts[i] + "%' OR item_number like '%" + parts[i] + "%' OR category_main like '%" + parts[i] + "%' OR category_sub like '%" + parts[i] + "%' ";
                }
            }

            if (categoryMain == null) {
                categoryMain = "";
            } else if (categoryMain.equalsIgnoreCase("")) {
                categoryMain = "";
            } else {
                categoryMain = "category_main = '" + categoryMain + "'";
            }

            if (categorySub == null) {
                categorySub = "";
            } else if (categorySub.equalsIgnoreCase("")) {
                categorySub = "";
            } else {
                categorySub = "category_sub = '" + categorySub + "'";
            }

            if (category != null && !category.equalsIgnoreCase("")) {
                String[] parts = category.split(">");

                categoryMain = "category_main = '" + parts[0] + "'";
                categorySub = "category_sub = '" + parts[1] + "'";
            }

            System.out.println("Category Main:- " + categoryMain);
            System.out.println("Category Sub:- " + categoryMain);
            System.out.println("Category:- " + category);

            if (district == null) {
                district = "";
            } else if (district.equalsIgnoreCase("")) {
                district = "";
            } else {
                String[] districts = district.split(",");

                if (districts.length > 1) {
                    district = "";
                    for (int i = 0; i < districts.length; i++) {
                        district = district + "district = '" + districts[i] + "'";

                        if (i != districts.length - 1) {
                            district = district + " OR ";
                        }

                        city = null;
                    }
                } else {
                    district = "district= '" + district + "'";
                }
            }

            if (city == null) {
                city = "";
            } else if (city.equalsIgnoreCase("")) {
                city = "";
            } else {
                city = "city = '" + city + "'";
            }

            if (location != null && !location.equalsIgnoreCase("")) {
                String[] parts = location.split(">");

                district = "district = '" + parts[0] + "'";
                city = "city = '" + parts[1] + "'";
            }

            System.out.println("District :- " + district);
            System.out.println("City :- " + city);
            System.out.println("Loaction :- " + location);

            if (adType == null) {
                adType = "";
            } else if (adType.equalsIgnoreCase("")) {
                adType = "";
            } else {
                adType = "ad_form = '" + adType + "'";
            }

            System.out.println("Ad Type :- " + adType);

            String price = "";

            if (maxPrice < 0) {
                maxPrice = 0;
            }

            if (minPrice < 0) {
                minPrice = 0;
            }

            if (maxPrice > 0) {
                price = "price BETWEEN " + minPrice + " AND " + maxPrice;
            } else {
                price = "price >= " + minPrice;
            }

            System.out.println("Price :- " + price);

            //query execution
            String query = "SELECT * FROM itemview WHERE ";

            if (!search.equalsIgnoreCase("")) {
                query = query + "(" + search + ") AND ";
            }

            if (!district.equalsIgnoreCase("")) {
                query = query + "(" + district + ") AND ";
            }

            if (!city.equalsIgnoreCase("")) {
                query = query + "(" + city + ") AND ";
            }

            if (!categoryMain.equalsIgnoreCase("")) {
                query = query + "(" + categoryMain + ") AND ";
            }

            if (!categorySub.equalsIgnoreCase("")) {
                query = query + "(" + categorySub + ") AND ";
            }

            if (!adType.equalsIgnoreCase("")) {
                query = query + "(" + adType + ") AND ";
            }

            if (!price.equalsIgnoreCase("")) {
                query = query + "(" + price + ") AND ";
            }

            query = query + "status='Active'";
            //System.out.println("Query :"+query);

            if (db.getConnection()) {
                Statement stmt = db.conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    ItemView_Class item = new ItemView_Class();

                    item.setItem_number(rs.getInt("item_number"));
                    item.setUsername(rs.getString("username"));
                    item.setTime_stamp(rs.getString("time_stamp"));
                    item.setCategory_main(rs.getString("category_main"));
                    item.setCategory_sub(rs.getString("category_sub"));
                    item.setDistrict(rs.getString("district"));
                    item.setCity(rs.getString("city"));
                    item.setAd_form(rs.getString("ad_form"));
                    item.setTitle(rs.getString("title"));
                    item.setContent(rs.getString("content"));
                    item.setContact_number(rs.getString("contact_number"));
                    item.setNegotiable(rs.getString("negotiable"));
                    item.setPrice(rs.getInt("price"));
                    item.setView_count(rs.getInt("view_count"));
                    item.setStatus(rs.getString("status"));

//                    resultMainCategoryList.add(item.getCategory_main());
//                    resultSubCategoryList.add(item.getCategory_sub());
//                    resultDistrictList.add(item.getDistrict());
//                    resultCityList.add(item.getCity());
                    items.add(item);
                }

                System.out.println("Search Results :- " + items.size());
                db.endConnection();
            }
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return items;
    }

    public boolean itemExist(int itemNumber) {
        boolean exist = false;

        try {
            String query = "SELECT COUNT(*) FROM itemview WHERE item_number = ?";

            db.getConnection();
            PreparedStatement psmt = db.conn.prepareStatement(query);
            psmt.setInt(1, itemNumber);

            ResultSet rs = psmt.executeQuery();

            while (rs.next()) {
                if (rs.getInt(1) > 0) {
                    exist = true;
                }
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception: " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return exist;
    }

    public ArrayList topAds() {
        ArrayList items = new ArrayList();

        try {
            String sql = "Select distinct category_main As top_categories FROM (SELECT * FROM `itemview` where status = 'Active' Group By `category_main` ORDER BY `view_count` DESC) AS T LIMIT 5";

            db.getConnection();
            Statement stmt = db.conn.createStatement();

            ResultSet rs = stmt.executeQuery(sql);

            List top_categories = new ArrayList();

            while (rs.next()) {
                top_categories.add(rs.getString(1));
            }

            for (int i = 0; i < top_categories.size(); i++) {
                List category_items = new ArrayList();
                String query = "SELECT * FROM `itemview` WHERE `category_main` = ? AND status = 'Active' ORDER BY `view_count` DESC LIMIT 5";

                PreparedStatement pstmt = db.conn.prepareStatement(query);
                pstmt.setString(1, top_categories.get(i).toString());

                ResultSet resultSet = pstmt.executeQuery();

                while (resultSet.next()) {
                    List item = new ArrayList();

                    item.add(resultSet.getString("item_number"));
                    item.add(resultSet.getString("username"));
                    item.add(resultSet.getString("category_main"));
                    item.add(resultSet.getString("category_sub"));
                    item.add(resultSet.getString("district"));
                    item.add(resultSet.getString("city"));
                    item.add(resultSet.getString("title"));
                    item.add(resultSet.getString("ad_form"));
                    item.add(resultSet.getInt("price"));
                    item.add(resultSet.getString("view_count"));
                    item.add(resultSet.getString("time_stamp"));

                    category_items.add(item);
                }

                items.add(category_items);
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception | " + this.getClass() + ": " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return items;
    }

    public ArrayList relatedAds(String title, String category_main, String district) {
        ArrayList items = new ArrayList();

        String[] keywords = title.split(" ");
        String condition = "title like '%" + title + "%'";
        List exist = new ArrayList();

        for (String keyword : keywords) {
            condition += " OR title like '%" + keyword + "%'";

            String sql = "SELECT * FROM `itemview` WHERE (" + condition + ") AND category_main = ? AND status = 'Active' ORDER BY 'view_count' DESC, 'time_stamp' ASC LIMIT 6";
            System.out.println("Query: " + sql);

            try {
                db.getConnection();

                PreparedStatement pstmt = db.conn.prepareStatement(sql);
                pstmt.setString(1, category_main);
                //pstmt.setString(2, district);

                ResultSet resultSet = pstmt.executeQuery();

                while (resultSet.next()) {
                    if (!exist.contains(resultSet.getString("item_number"))) {

                        exist.add(resultSet.getString("item_number"));
                        List item = new ArrayList();

                        item.add(resultSet.getString("item_number"));
                        //item.add(resultSet.getString("username"));
                        item.add(resultSet.getString("title"));
                        item.add(resultSet.getString("ad_form"));
                        //item.add(resultSet.getInt("negotiable"));
                        item.add(resultSet.getInt("price"));
                        item.add(resultSet.getString("time_stamp"));
                        items.add(item);
                    }
                }

                System.out.println("Related: " + items.size());

                db.endConnection();
            } catch (Exception e) {
                System.out.println("Class Exception: " + e.getMessage());
            } finally {
                if (db.conn != null) {
                    db.endConnection();
                }
            }
        }

        return items;
    }

    public boolean checkEditAuthentication(String login, int itemNumber) throws SQLException {
        boolean res = false;

        User_Class user = new User_Class();
        login = user.requetUsername(login);

        String sql = "SELECT count(*) FROM `itemview` WHERE `item_number` = ? AND `username` = ?";

        try {
            db.getConnection();

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setInt(1, itemNumber);
            pstmt.setString(2, login);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                if (rs.getInt(1) > 0) {
                    res = true;
                }
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception(" + this.getClass() + "): " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return res;
    }

    public List adDetails(int itemNumber) {
        List item = new ArrayList();

        try {
            db.getConnection();

            String sql = "SELECT * FROM `itemview` WHERE `item_number` = ?";

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setInt(1, itemNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                item.add(rs.getInt("item_number"));
                item.add(rs.getString("username"));
                item.add(rs.getString("time_stamp"));
                item.add(rs.getString("category_main"));
                item.add(rs.getString("category_sub"));
                item.add(rs.getString("district"));
                item.add(rs.getString("city"));
                item.add(rs.getString("ad_form"));
                item.add(rs.getString("title"));
                item.add(rs.getString("content"));
                item.add(rs.getString("contact_number"));
                item.add(rs.getInt("price"));
                item.add(rs.getString("negotiable"));
                item.add(rs.getInt("view_count"));
                item.add(rs.getString("status"));
            }

            db.endConnection();
        } catch (Exception e) {
            System.out.println("Class Exception(" + this.getClass().getName() + "): " + e.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return item;
    }

    /**
     * sort items by date / new ads
     *
     * @param items
     * @return
     */
    public ArrayList sortByNew(ArrayList items) {
        Collections.sort(items, new Comparator<ItemView_Class>() {
            @Override
            public int compare(ItemView_Class o2, ItemView_Class o1) {
                return o1.getTime_stamp().compareTo(o2.getTime_stamp());
            }
        });

        return items;
    }

    /**
     * sort items by date / old ads
     *
     * @param items
     * @return
     */
    public ArrayList sortByOld(ArrayList items) {
        Collections.sort(items, new Comparator<ItemView_Class>() {
            @Override
            public int compare(ItemView_Class o1, ItemView_Class o2) {
                return o1.getTime_stamp().compareTo(o2.getTime_stamp());
            }
        });

        return items;
    }

    /**
     * sort items by lowest price
     *
     * @param items
     * @return
     */
    public ArrayList sortByLowestPrice(ArrayList items) {
        Collections.sort(items, new Comparator<ItemView_Class>() {
            public int compare(ItemView_Class o1, ItemView_Class o2) {
                return Integer.valueOf(o1.getPrice()).compareTo(o2.getPrice());
            }
        });

        return items;
    }

    /**
     * sort items by highest price
     *
     * @param items
     * @return
     */
    public ArrayList sortByHighestPrice(ArrayList items) {
        Collections.sort(items, new Comparator<ItemView_Class>() {
            public int compare(ItemView_Class o2, ItemView_Class o1) {
                return Integer.valueOf(o1.getPrice()).compareTo(o2.getPrice());
            }
        });

        return items;
    }

    /**
     * price sort items by lowest views
     *
     * @param items
     * @return
     */
    public ArrayList sortByLowestViews(ArrayList items) {
        Collections.sort(items, new Comparator<ItemView_Class>() {
            public int compare(ItemView_Class o1, ItemView_Class o2) {
                return Integer.valueOf(o1.getView_count()).compareTo(o2.getView_count());
            }
        });

        return items;
    }

    /**
     * sort items by highest views
     *
     * @param items
     * @return
     */
    public ArrayList sortByHighestViews(ArrayList items) {
        Collections.sort(items, new Comparator<ItemView_Class>() {
            public int compare(ItemView_Class o2, ItemView_Class o1) {
                return Integer.valueOf(o1.getView_count()).compareTo(o2.getView_count());
            }
        });

        return items;
    }

    public List resultDistricts(final List<ItemView_Class> items) {
        Set districts = new HashSet();
        for (final ItemView_Class dis : items) {
            districts.add(dis.getDistrict());
        }

        List<String> list = new ArrayList<String>(districts);
        Collections.sort(list);

        return list;
    }

    public List resultCities(final List<ItemView_Class> items) {
        Set districts = new HashSet();
        for (final ItemView_Class cit : items) {
            districts.add(cit.getCity());
        }

        List<String> list = new ArrayList<String>(districts);
        Collections.sort(list);

        return list;
    }

    public List resultMainCats(final List<ItemView_Class> items) {
        Set mainCats = new HashSet();
        for (final ItemView_Class mCat : items) {
            mainCats.add(mCat.getCategory_main());
        }

        List<String> list = new ArrayList<String>(mainCats);
        Collections.sort(list);

        return list;
    }

    public List resultSubCats(final List<ItemView_Class> items) {
        Set subCats = new HashSet();
        for (final ItemView_Class sCat : items) {
            subCats.add(sCat.getCategory_sub());
        }

        List<String> list = new ArrayList<String>(subCats);
        Collections.sort(list);

        return list;
    }

    //class methods end
}
