package com.hx.book;

/**
 * Created by hexing on 15-6-10.
 */
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.File;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

public class writeInfoToDB {
    public static void main(String[] args) {
        File folder = new File("/home/hexing/book");
        File[] XMLS = folder.listFiles();
        SAXReader reader = new SAXReader();
        Statement statement = null;    //用这个执行sql语句
        try {
            Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
            statement = DriverManager.getConnection("jdbc:mysql://localhost:3306/book_manager?user=root&password=hx106107").createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        for (File f:XMLS) {
            if (f.isDirectory()) {
                continue;
            }
            Document document = null;
            try {
                document = reader.read(f);
            } catch (DocumentException e) {
                e.printStackTrace();
            }

            Element root = document.getRootElement();
            List<Element> books = root.elements();
            for (Element book:books) {
                String name = null;
                String author = null;
                String publish = null;
                String isbn = null;
                String count = null;
                String link = null;
                String img = null;
                List<Element> b = book.elements();
                for (Element info:b) {
                    if (info.getName().equals("name")) {
                        name = info.getText();
                    } else if (info.getName().equals("author")) {
                        author = info.getText();
                    } else if (info.getName().equals("publish")) {
                        publish = info.getText();
                    } else if (info.getName().equals("isbn")) {
                        isbn = info.getText();
                    } else if (info.getName().equals("count")) {
                        count = info.getText();
                    } else if (info.getName().equals("link")) {
                        link = info.getText();
                    } else if (info.getName().equals("img")) {
                        img = info.getText();
                    }
                }
                String sql = "INSERT INTO book(bpublish,bname,bauthor,btag,bisbn,bcount,bleftcount,blink,bimg) VALUES ('" + publish + "','" + name + "','" + author + "','" + f.getName().split("\\.")[0] + "','" + isbn + "','" + count + "','" + count + "','" + link + "','" + img + "');";
                try {
                    statement.execute(sql);
                } catch (SQLException e) {
                    System.err.println("sql语句处错误:" + e.getMessage());
                    System.err.println("sql语句:" + sql);
                }
            }
        }
    }
}