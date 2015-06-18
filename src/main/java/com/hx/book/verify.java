package com.hx.book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by hexing on 15-6-16.
 */
@WebServlet(name = "verify",urlPatterns = {"/verify"})
public class verify extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookConn conn = new BookConn();
        String num = request.getParameter("snum");
        conn.Excu("update student set verify = '1' where snum = '"+num+"'");
        response.sendRedirect("verify.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
