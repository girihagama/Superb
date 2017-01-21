/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Indunil
 */
public class Category_Class {

    private String category_main;
    private String categorySub;
    private String category;
    private int itemCount;

    Db_Class db = new Db_Class();

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
     * @return the categorySub
     */
    public String getCategorySub() {
        return categorySub;
    }

    /**
     * @param categorySub the categorySub to set
     */
    public void setCategorySub(String categorySub) {
        this.categorySub = categorySub;
    }

    /**
     * @return the category
     */
    public String getCategory() {
        return category;
    }

    /**
     * @param category the category to set
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * @return the itemCount
     */
    public int getItemCount() {
        return itemCount;
    }

    /**
     * @param itemCount the itemCount to set
     */
    public void setItemCount(int itemCount) {
        this.itemCount = itemCount;
    }

    //class methods
    public ArrayList allCategories() {
        ArrayList all = new ArrayList();

        try {
            db.getConnection();

            String sql = "SELECT * FROM `category` ORDER BY `main` ASC";
            Statement stmt = db.conn.createStatement();

            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Category_Class cat = new Category_Class();

                cat.setCategory_main(rs.getString("main"));
                cat.setCategorySub(rs.getString("sub"));

                all.add(cat);
            }

            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        } finally {
            if (db.conn != null) {
                db.endConnection();
            }
        }

        return all;
    }

    public ArrayList mainCategoriesWithSubCategories() {
        ArrayList allCategories = new ArrayList();

        List mainCategories = this.allMainCategories();
        for (Object mainCategory : mainCategories) {
            ArrayList cat = new ArrayList();
            
            cat.add(mainCategory);
            cat.add(subCategoriesOfMainCategory(mainCategory.toString()));
            
            allCategories.add(cat);
        }

        return allCategories;
    }

    public List allMainCategories() {
        List mainCategories = new ArrayList();

        try {
            db.getConnection();

            String sql = "SELECT * FROM `category_main`";

            Statement stmt = db.conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                mainCategories.add(rs.getString(1));
            }

            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        }

        return mainCategories;
    }

    public List allSubCategories() {
        List subCategories = new ArrayList();

        try {
            db.getConnection();

            String sql = "SELECT sub FROM `category`";

            Statement stmt = db.conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                subCategories.add(rs.getString(1));
            }

            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        }

        return subCategories;
    }

    public List subCategoriesOfMainCategory(String mainCategory) {
        List subCategories = new ArrayList();

        try {
            db.getConnection();

            String sql = "SELECT sub FROM `category` WHERE `main` = ?";

            PreparedStatement pstmt = db.conn.prepareStatement(sql);
            pstmt.setString(1, mainCategory);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                subCategories.add(rs.getString(1));
            }

            db.endConnection();
        } catch (Exception ex) {
            System.out.println("Class Exception: " + ex.getMessage());
        }

        return subCategories;
    }

    public List categoriesOfResults(ArrayList results) {
        List resultCategories = new ArrayList();

        for (Object result : results) {
            ItemView_Class item = (ItemView_Class) result;
            String itemCategory = item.getCategory_main() + ">" + item.getCategory_sub();

            if (resultCategories.size() > 0) {
                for (Object rc : resultCategories) {
                    Category_Class list = (Category_Class) rc;

                    if (itemCategory.equalsIgnoreCase(list.category)) {
                        list.itemCount++;
                        rc = list;
                    } else {
                        Category_Class newItem = new Category_Class();

                        list.setCategory(itemCategory);
                        list.setItemCount(1);

                        resultCategories.add(newItem);
                    }
                }
            } else {
                Category_Class list = new Category_Class();

                list.setCategory(itemCategory);
                list.setItemCount(1);

                resultCategories.add(list);
            }

        }

        return resultCategories;
    }

    //class methods end
}
