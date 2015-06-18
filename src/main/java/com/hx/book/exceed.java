package com.hx.book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by hexing on 15-6-15.
 */
@WebServlet(name = "exceed",urlPatterns = {"/exceed"})
public class exceed extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String bid = request.getParameter("bid");
        if(bid!=null){
            BookConn conn = new BookConn();
            String sql = "delete from borrow where bid = '"+bid+"'";
            String sql1 = "update book set bleftcount = bleftcount+1";
            conn.Excu(sql);
            conn.Excu(sql1);
            response.sendRedirect("exceed.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
