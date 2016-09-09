<%@ page language="java" import="java.util.* ,entity.User" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
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
    
    <title>用户注册</title>
    <style type="text/css">
    </style>
    <link rel="Shortcut Icon" type="image/x-icon" href="img/icon.PNG">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	

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
  <div class="register">
  
  <fieldset style="margin-left:27%; width:600px;height:650px;">
<legend><font color="#ff6600" size="5">新用户注册</font></legend>
<form action="register.action" method="post" name="registerForm">
  <table  align="center">
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>用 户 名：</td>
     <td style="height: 60px; "><input type="text" size="25" name="userName" style="height: 38px; width: 220px; "></td>
    </tr>
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
     <td style="height: 60px; "><input type="text" size="25" name="password1" style="height: 38px; width: 220px; "></td>
    </tr>
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>确认密码：</td>
     <td style="height: 60px; "><input type="text" size="25" name="password2" style="height: 38px; width: 220px; "></td>
    </tr>
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>E - mail:</td>
     <td style="height: 60px; "><input type="text" size="25" name="email" style="height: 38px; width: 220px; "></td>
    </tr>
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>真实姓名:</td>
     <td style="height: 60px; "><input type="text" size="25" name="truName" style="height: 38px; width: 220px; "></td>
    </tr>
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>联系方式:</td>
     <td style="height: 60px; "><input type="text" size="25" name="telephone" style="height: 38px; width: 220px; "></td>
    </tr>
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>收件地址:</td>
     <td style="height: 60px; "><input type="text" size="25" name="address" style="height: 38px; width: 220px; "></td>
    </tr>
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>邮&nbsp;&nbsp;&nbsp;&nbsp;编:</td>
     <td style="height: 60px; "><input type="text" size="25" name="postBoy" style="height: 38px; width: 220px; "></td>
    </tr>
    <tr>
     <td style="height: 60px; "><font color="ff6600">*</font>密码提示:</td>
     <td style="height: 60px; "><input type="text" size="25" name="passHint" style="height: 38px; width: 220px; "></td>
    </tr>
  </table>
  <center><input type="submit" class="submit" value="提交" style="height: 42px; width: 69px; "></center>
  </form>
  </fieldset>
  
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
