<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-9
  Time: 上午11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书馆管理系统</title>
    <link rel="icon" href="images/04.ico" type="images/x-icon"/>
    <link rel="short cut" href="images/04.ico" type="images/x-icon"/>
    <link type="text/css" href="css/logined.css" rel="stylesheet">
    <script type="text/javascript">
    </script>
</head>

<body>
<%

    String sname = (String) request.getAttribute("name");
    if(session.getAttribute("flag")==null){
        session.setAttribute("flag","on");
        session.setAttribute("num","");
        session.setAttribute("num",session.getAttribute("num")+sname);
    }

%>

<div id="banner">
    <p id="data">欢迎<span style="color: #E94D38"><%=session.getAttribute("num")%></span>登陆 | <a href="exit.jsp">退出</a></p>
    <!--搜索框开始-->
    <div class="search">
        <form action="display_query.jsp" method="post">
            <input id="find" type="text" name="squery" value="图书的名字、作者、ISBN" />
            <input type="submit" name="search" value="搜索" width="20px"/>
        </form>
    </div>
    <!--搜索框结束-->
    <!--导航栏开始-->
    <div id="nav">
        <ul>
            <li><a href="#"><span>首页</span></a></li>
            <li><a href="renewed.jsp"><span>续借</span></a></li>
            <li><a href="modify.jsp"><span>修改信息</span></a></li>
        </ul>
    </div>
</div>
<!--导航栏结束-->
<!--主体内容开始-->
<div id="calender">
    <script type="text/javascript">
        function fixDate(date) {
            var base = new Date(0);
            var skew = base.getTime();
            if (skew > 0)
                date.setTime(date.getTime() - skew);
        }

        function getTime() {
            var now = new Date();
            var hour = now.getHours();
            var minute = now.getMinutes();
            now = null;
            var ampm = "";
            if (hour >= 12) {
                hour -= 12;
                ampm = "PM";
            } else
                ampm = "AM";
            hour = (hour == 0) ? 12 : hour;
            if (minute < 10)
                minute = "0" + minute;
            return hour + ":" + minute + " " + ampm;
        }
        var timer=setInterval(getTime,0);
        function leapYear(year) {
            if (year % 4 == 0)
                return true;
            return false;
        }

        function getDays(month, year) {
            var ar = new Array(12);
            ar[0] = 31;
            ar[1] = (leapYear(year)) ? 29 : 28;// February
            ar[2] = 31;
            ar[3] = 30;
            ar[4] = 31;
            ar[5] = 30;
            ar[6] = 31;
            ar[7] = 31;
            ar[8] = 30;
            ar[9] = 31;
            ar[10] = 30;
            ar[11] = 31;
            return ar[month];
        }
        function getMonthName(month) {
            var ar = new Array(12);
            ar[0] = "January";
            ar[1] = "February";
            ar[2] = "March";
            ar[3] = "April";
            ar[4] = "May";
            ar[5] = "June";
            ar[6] = "July";
            ar[7] = "August";
            ar[8] = "September";
            ar[9] = "October";
            ar[10] = "November";
            ar[11] = "December";
            return ar[month];
        }

        function setCal() {
            var now = new Date();
            var year = now.getYear()+1900;
            var month = now.getMonth();
            var monthName = getMonthName(month);
            var date = now.getDate();
            now = null;
            var firstDayInstance = new Date(year, month, 1);
            var firstDay = firstDayInstance.getDay();
            firstDayInstance = null;
            var days = getDays(month, year);
            drawCal(firstDay + 1, days, date, monthName, year);
        }
        function drawCal(firstDay, lastDate, date, monthName, year) {
            var headerHeight = 45;
            var border = 1;
            var cellspacing = 4;
            var headerColor = "#E94D38";
            var headerSize = "+3";
            var colWidth = 35;
            var dayCellHeight = 20;
            var dayColor = "#292929";
            var cellHeight =35;
            var todayColor = "#E94D38";
            var timeColor = "#292929";
            var text = "";
            text += '<CENTER>';
            text += '<TABLE BORDER=' + border + ' CELLSPACING=' + cellspacing + '>';
            text +=         '<TH COLSPAN=7 HEIGHT=' + headerHeight + ' BACKGROUND-COLOR="' + headerColor + '" >';
            text +=                 '<FONT COLOR="' + headerColor + '" SIZE=' + headerSize + '>';
            text +=                         monthName + ' ' + year;
            text +=                 '</FONT>';
            text +=         '</TH>';
            var openCol = '<TD WIDTH=' + colWidth + ' HEIGHT=' + dayCellHeight + '>';
            openCol += '<FONT COLOR="' + dayColor + '">';
            var closeCol = '</FONT></TD>';
            var weekDay = new Array(7);
            weekDay[0] = "Sun";
            weekDay[1] = "Mon";
            weekDay[2] = "Tues";
            weekDay[3] = "Wed";
            weekDay[4] = "Thu";
            weekDay[5] = "Fri";
            weekDay[6] = "Sat";
            text += '<TR ALIGN="center" VALIGN="center">';
            for (var dayNum = 0; dayNum < 7; ++dayNum) {
                text += openCol + weekDay[dayNum] + closeCol;
            }
            text += '</TR>';
            var digit = 1;
            var curCell = 1;
            for (var row = 1; row <= Math.ceil((lastDate + firstDay - 1) / 7); ++row) {
                text += '<TR ALIGN="right" VALIGN="top">';
                for (var col = 1; col <= 7; ++col) {
                    if (digit > lastDate)
                        break;
                    if (curCell < firstDay) {
                        text += '<TD></TD>';
                        curCell++;
                    } else {
                        if (digit == date) {
                            text += '<TD HEIGHT=' + cellHeight + '>';
                            text += '<FONT COLOR="' + todayColor + '">';
                            text += '<A HREF="javascript:getInput(' + digit + ', \'' + monthName + '\')" onMouseOver="window.status = \'Store or retrieve data for ' + monthName + ' ' + digit + '\'; return true"><FONT COLOR="' + todayColor + '">' + digit + '</FONT></A>';
                            text += '<BR>';
                            text += '<FONT COLOR="' + timeColor + '" SIZE=2>';

                            text += '</FONT>';
                            text += '</TD>';
                        } else
                            text += '<TD HEIGHT=' + cellHeight + '><A HREF="javascript:getInput(' + digit + ', \'' + monthName + '\')" onMouseOver="window.status = \'Store or retrieve data for ' + monthName + ' ' + digit + '\'; return true">' + digit + '</A></TD>';
                        digit++;
                    }
                }
                text += '</TR>';
            }
            text += '</TABLE>';
            text += '</CENTER>';
            document.write(text);
        }
        setCal();

    </script>
</div>
<div id="new">新书快递</div>
<div id="new_book">
    <table border="1">
        <tr>
            <td><a href="http://book.douban.com/subject/26278687/?from=tag_all"><img src="images/1.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/26358169/?from=tag_all"><img src="images/2.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/1200840/?from=tag_all"><img src="images/3.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/26384746/?from=tag_all"><img src="images/4.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/2035162/?from=tag_all"><img src="images/5.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/26309691/?from=tag_all"><img src="images/6.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/1767945/?from=tag_all"><img src="images/7.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/2297697/?from=tag_all"><img src="images/8.jpg" ></a></td>
        </tr>
        <tr>
            <td><a href="http://book.douban.com/subject/3018339/?from=tag_all"><img src="images/8.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/25854872/?from=tag_all"><img src="images/9.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/4180711/?from=tag_all"><img src="images/20.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/25862578/?from=tag_all"><img src="images/21.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/4238362/?from=tag_all"><img src="images/22.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/25756947/?from=tag_all"><img src="images/23.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/4718973/?from=tag_all"><img src="images/24.jpg" ></a></td>
            <td><a href="http://book.douban.com/subject/26232736/?from=tag_all"><img src="images/25.jpg" ></a></td>


        </tr>

    </table>

</div>
</body>
</html>

