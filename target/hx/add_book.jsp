<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-17
  Time: 上午12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<html>
<head>
  <title>添加图书</title>
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
  <form id="onload" action="<%=request.getContextPath()%>/add_book" method="post">
    <h2>添加图书</h2>
    <p><span>书&nbsp;&nbsp;&nbsp;&nbsp;号</span><input type="text" name="bid" /></p>
    <p><span>书&nbsp;&nbsp;&nbsp;&nbsp;名</span><input type="text" name="bname" /></p>
    <p><span>作&nbsp;&nbsp;&nbsp;&nbsp;者</span><input type="text" name="bauthor" /></p>
    <p><span>出&nbsp;版&nbsp;社</span><input type="text" name="bpublish" /></p>
    <p><span>&nbsp;&nbspISBN&nbsp;&nbsp;</span><input type="text" name="bisbn" /></p>
    <p><span>本&nbsp;&nbsp;&nbsp;&nbsp;数</span><input type="text" name="bcount" /></p>
    <p><span>种&nbsp;&nbsp;&nbsp;&nbsp;类</span><input type="text" name="btag" /></p>
    <p><span>详情链接</span><input type="text" name="blink" /></p>
    <p><span>图片链接</span><input type="text" name="bimg" /></p>
    <p style="width:500px;height:35px;" id="button">
      <input type="submit" style="width:100px;height:35px;line-height:35px;margin-left:170px;" name="regist" value="添加"/>
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