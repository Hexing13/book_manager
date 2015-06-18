<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-16
  Time: 下午10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<html>
<head>
  <title>添加学生</title>
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
  <form id="onload" action="<%=request.getContextPath()%>/add_student" method="post">
    <h2>添加学生</h2>
    <p><span>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 号</span><input type="text" name="userid" /></p>
    <p><span>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 名</span><input type="text" name="sname" /></p>
    <p><span>专&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 业</span><input type="text" name="smajor" /></p>
    <p><span>班&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 级</span><input type="text" name="sclass" /></p>

    <p><span>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 码</span><input type="password" name="password1" id="password1"/></p>
    <p><span>确认密码</span><input type="password" name="password2"  id="password2"/></p>
    <p style="width:500px;height:35px;" id="button">
      <input type="submit" style="width:100px;height:35px;line-height:35px;margin-left:170px;" name="regist" value="注册"/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="reset" style="width:100px;height:35px;line-height:35px;margin-left: 20px;" name="reset" value="重置"/>
    </p>

  </form>
  <%
    String message = " ";
    String msg = (String) request.getAttribute("msg");
    if(msg != null){
      message = msg;
    }
  %>
  <b><%=message%></b>
</div>
</body>
</html>
