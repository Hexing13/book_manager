<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-15
  Time: 上午9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>图书馆员还书系统</title>
  <script src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <link type="text/css" href="css/borrow.css" rel="stylesheet">
  <style type="text/css"> @import "css/bootstrap.min.css";</style>
</head>
<body>
<%
  if(session.getAttribute("flag1")==null){
    response.sendRedirect("l_index.jsp");
  }
%>
<p style="width:100px;height:20px;margin-left:1220px;margin-top: 5px;"><a href="l_logined.jsp">返回主界面</a></p>
<h1 style="margin-left:65px;margin-top:30px;">图书管员还书系统</h1>
<form id="form-horizontal" action="returned.jsp" method="post">
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-3">学号</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputEmail3" placeholder="学号" name="snum">
    </div>
  </div>
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-3">书号</label>
    <div class="col-sm-10">
      <input type="text" class="form-control"  placeholder="书号" name="bid">
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-3">密码</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="inputPassword3" placeholder="密码" name="spassword">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-default">提 交</button>
    </div>
  </div>
</form>
<%
  String message = " ";
  String msg = (String) request.getAttribute("msg");
  if(msg != null){
    message = msg;
  }
%>
<b><%=message%></b>
</body>
</html>
