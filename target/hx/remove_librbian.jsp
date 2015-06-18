<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-16
  Time: 下午10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<html>
<head>
  <title>删除图管</title>
  <link rel="icon" href="images/04.ico" type="images/x-icon"/>
  <link rel="short cut" href="images/04.ico" type="images/x-icon"/>
  <link href="css/regist.css" rel="stylesheet" />
  <script src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <style type="text/css"> @import "css/bootstrap.min.css";</style>
</head>

<body>
<%
  if(session.getAttribute("flag2")==null){
    response.sendRedirect("m_index.jsp");
  }
%>

<p style="width:100px;height:20px;margin-left:1220px;margin-top: 5px;"><a href="m_logined.jsp">返回主界面</a></p>
<div id="ibody">
  <form id="onload" action="<%=request.getContextPath()%>/remove_librbian" method="post">
    <h2>删除图管</h2>
    <p style="margin-top:70px;"><span style="font-size:16px;line-height:35px;">工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 号</span><input type="text" style="width:320px;
	height:35px;" name="userid" /></p>
    <p style="padding-top:20px;margin-top:50px; margin-left:150px;" id="button">
      <input type="submit" name="regist" value="删除" style="width: 100px"/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="reset" name="reset" value="重置" style="width: 100px"/>
    </p>

  </form>
  <%
    String message = " ";
    String msg = (String) request.getAttribute("msg");
    if(msg != null){
      message = msg;
    }
  %>
  <p><%=message%></p>
</div>
</body>
</html>