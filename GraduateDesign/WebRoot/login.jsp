<%@ page language="java" import="java.util.* ,entity.User" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    
    <title>用户登录</title>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="Shortcut Icon" type="image/x-icon" href="img/icon.PNG">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
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
        <input type="submit" class="search_submit" value="搜索" style="height: 40px; width:60px; ">
      </form>
  </div>
  <div class="login">
		<fieldset style="margin-left:30%;padding-top:50px;height:240px;width:500px;">
		<legend><font color="#ff6600" size="5">用户登录</font></legend>
		<center>
		<form action="login.action" method="post" name="loginForm" onsubmit="return checkValue();">
			<table align="center">
			<tr>
			  <td style="height: 37px; width: 54px; "><font color="#ff6600">*</font>邮箱 :</td>
			  <td style="height: 59px; "><input type="text" class="email" size="25" name="email" style="height: 40px"/></td>
			</tr>
			<tr>
			  <td style="height: 37px; width: 62px; "><font color="#ff6600">*</font>密码 :</td>
			  <td style="height: 48px; "><input type="password" class="password" size="25" name="password" style="height: 40px"/></td>
			</tr>
			</table>
			 <select name="type">
			  <option value="用户" selected="selected">用户</option>
			  <option value="后台人员">后台人员</option>
			 </select>
			<input type="submit" class="submit" value="登录" style="margin:10px;height: 34px; width: 74px;" />
			<input type="reset" class="reset" value="重置" style="margin:10px;height: 34px; width: 74px;" />
		</form></center></fieldset>
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
