<%@ page language="java" import="java.util.* ,entity.User" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username="登录";
String href="login.jsp";
String src="img/defaultOne.jpg";
long id=0;String nickname=" ";String address=" ";String passHint=" ";
String telephone=" ";String email=" ";String truName=" ";String postBoy=" ";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户信息</title>
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
       else{User user=(User)obj; 
       username=user.getUserName();
       href="UserInfo.jsp";
       if(user.getImagePath()!=null)
       src=user.getImagePath();}
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
  
  <div class="con_UserInfo" style="height:600px;">
   <div class="aside" style="margin-left:5%;width:150px ;height:100% ;background:#e3f4d5">
   <center><h1 style="color:blue; font:Arial;">用户信息</h1></center>
   <a class="img" href="UploadImgs.jsp"><img src=<%= src %> style="margin:15px;width:120px;height:120px;"  ></a>
   <table>
    <tr >
      <td align="center" style="width:150px;height: 60px; border-top:solid 2px orange"><a href="UserInfo.jsp" style="text-decoration:none">修改个人信息</a></td>
    </tr>
    <tr>
      <td align="center" style="width:150px;height: 60px; border-top:solid 2px orange"><a href="#" style="text-decoration:none">我的订单</a></td>
    </tr>
    <tr>
      <td align="center" style="width:150px;height: 60px; border-top:solid 2px orange"><a href="#" style="text-decoration:none">我的购物车</a></td>
    </tr>
     <tr>
      <td align="center" style="width:150px;height: 60px; border-top:solid 2px orange"><a href="#" style="text-decoration:none">我的拍卖品</a></td>
    </tr>
     <tr>
      <td align="center" style="width:150px;height: 60px; border-top:solid 2px orange"><a href="exit.jsp" style="text-decoration:none">退出登录</a></td>
    </tr>
   </table>
   </div>
   <div class="frames">
   <form class="update" action="modify.action" method="post">
   <% Object Obj=session.getAttribute("User");
       if(Obj==null){request.getRequestDispatcher("login.jsp").forward(request, response);}
       else{User user=(User)obj;
           id=user.getUserId();nickname=user.getUserName();truName=user.getTruName();
           telephone=user.getTelephone();email=user.geteMail();address=user.getAddress();
           postBoy=user.getPostBoy();passHint=user.getPassHint();}  %>
   <table class="update">
     <tr align="center" height="60px">
       <td>用 户 ID：</td>
       <td><input name="userId" style="height:45px;width:200px;" type="text" value=<%= id %> readonly="readonly"></input></td>
       <td width="100px" align="right">用户昵称：</td>
       <td><input style="height:45px;width:200px;" type="text" name="userName" value=<%= nickname %>></input></td>
     </tr>
     <tr align="center" height="60px">
       <td>旧 密 码：</td>
       <td><input style="height:45px;width:200px;" name="password1" type="password" ></input></td>
       <td width="100px" align="right">新 密 码：</td>
       <td><input style="height:45px;width:200px;" name="password2" type="password"></input></td>
     </tr>
     <tr align="center" height="60px">
       <td>手机号码：</td>
       <td><input style="height:45px;width:200px;" name="telephone" value=<%= telephone %> type="text" ></input></td>
       <td width="100px" align="right">E - mail：</td>
       <td><input style="height:45px;width:200px;" name="email" value=<%= email %> type="text" ></input></td>
     </tr>
     <tr align="center" height="60px">
       <td>真实姓名：</td>
       <td><input style="height:45px;width:200px;" name="truName" value=<%= truName %> type="text"></input></td>
       <td width="100px" align="right">邮&nbsp;&nbsp;&nbsp;&nbsp;编：</td>
       <td><input style="height:45px;width:200px;" name="postBoy" value=<%= postBoy %> type="text"></input></td>
     </tr >
     <tr align="center" height="60px">
       <td>邮寄地址：</td>
       <td colspan="3"><input style="height:45px;width:500px;" name="address" value=<%= address %> type="text" ></input></td>  
     </tr>
     <tr align="center" height="60px">
       <td>密码提示：</td>
       <td colspan="3"><input style="height:45px;width:500px;" name="passHint" type="text" value=<%= passHint %> ></input></td>
     </tr>
   </table>
   <input type="submit" value="保存" class="submit" style="width:80px;height:40px;" ></input>
   </form>
   </div>
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
         Copyright@ 东北大学秦皇岛分校-4110309-贡欢&nbsp;&nbsp;&nbsp; 技术支持：程绍辉老师<br>
                           联系方式：18233562573&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         E-mail:1131474643 @ qq.com
    </p>
    </div>
  </body>
</html>
