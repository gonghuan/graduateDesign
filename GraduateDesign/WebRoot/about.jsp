<%@ page language="java" import="java.util.*,entity.User" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username="登录";
String href="login.jsp";
 
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>关于本网站</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="Shortcut Icon" type="image/x-icon" href="img/icon.PNG">
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<script language="javascript">   
      window.onbeforeunload = function() {   
            var n = window.event.screenX - window.screenLeft;   
            var b = n > document.documentElement.scrollWidth-20;   
            if(b && window.event.clientY < 0 || window.event.altKey){   
                 session.invalidate();
            }
       };
    </script>
  </head>
  
  <body>
  <div class="top" style="height: 30px;">
   <p>
    <a class="primepage" href="index.jsp" style="text-decoration:none">首页</a>
    <% Object obj=session.getAttribute("User");
       if(obj==null){}
       else{User user=(User)obj; username=user.getUserName();href="UserInfo.jsp";}
     %>
    <a class="login" href=<%= href%> style="text-decoration:none"><%= username %></a>
    <font class="incent" size="5">|</font>
    <a class="register" href="register.jsp" style="text-decoration:none">注册</a>
   </p>
    </div>
   
   <div class="logo" style="height:100px">
      <img src="img/logo.PNG" style="height:20%; width:30%;">
      <form  class="search" action="search.action" method="post">
        <input type="text" name="search_text" size="30" style="height: 40px; ">
        <input type="submit" class="search_submit" value="搜索" style="height: 40px; width:60px">
      </form>
  </div>
  <div style="margin:40px 0;width:100%;height:500px;">
  <center>
   <h1>谢谢全体老师对我们的谆谆教导，老师们辛苦了！</h1><br><br><br><br>
   <ul>
   <li><font size="4">本系统主要使用的技术有：HTML,CSS,Javascript,Jquery,AJAX,JAVA,JSP,Servlet</font><br><br></li>
   <li><font size="4">开发平台：Myeclipse2014；应用服务器：TomCat7.0；底层数据库：MySQL5.5.25</font><br><br></li>
   <li><font size="4">主体开发：2014年12月-2015年1月；中间历经数次修改</font><br><br></li>
   <li><font size="4">衷心感谢我的指导老师程绍辉老师以及全体老师给予我的帮助，谢谢我的舍友，我的女朋友和我身边所有好朋友，大学有你们已经没有遗憾</font><br><br></li>
   </ul>
   <br>
   <h1>大学已经告一段落,让我们共同迎接明天的挑战！</h1>
  </center>
  </div>
  <div class="foot" style="width:100%">
     <ul>
      
      <li style="width:0px;"><a></a></li>
      <li style="width:0px;"><a></a></li>
      <li ><a href="#" class="links">友情链接</a></li>
      <li ><a href="#" class="privacy">隐私条款</a></li>
      <li ><a href="#" class="contact">联系我们</a></li>
      <li ><a href="#" class="policy">相关政策</a></li>
     </ul>
    </div>
    
     <div class="footer" style="background-color:#e0e0e0; height:60px;width:100%;padding-top:20px;">
    <p align="center" style="color:black;height:60px;font-size:12px">
         Copyright@ 东北大学秦皇岛分校-4110309-贡欢 技术支持：&nbsp;&nbsp;&nbsp;程绍辉老师<br>
                           联系方式：18233562573&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         E-mail:1131474643 @ qq.com
    </p>
    </div>
  </body>
</html>
  