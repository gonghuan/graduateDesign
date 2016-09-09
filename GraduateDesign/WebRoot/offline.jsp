<%@ page language="java" import="java.util.*,java.sql.*,util.*,entity.*,java.text.*" 
   contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username="登录";
String href="login.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>线下拍卖</title>
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
      </form></div> 
      
    <div id="offlineInfo" class="offlineInfo" style="width:80%;height:800px">
       <table class="tbOfflineInfo" style="width:100%;border-spacing:0px;border-collapse:collapse;">
        <tr style="background:#A7C942;border:1px solid #98bf21;text-align:center;padding:5px;">
          <th>预展标题</th>
          <th>预展开始时间</th>
          <th>预展结束时间</th>
          <th>预展地址</th>
        </tr>
        <%! 
             public static final String DRIVER = "com.mysql.jdbc.Driver";  
             public static final String USER = "root";  
             public static final String PASS = "";  
             public static final String URL = "jdbc:mysql://localhost:3306/GraduateDesign?useUnicode=true&characterEncoding=UTF-8";  
        %>
        <%   Connection conn=null;
             PreparedStatement pst=null;
             ResultSet rs=null;
             int count=0;
             String alt=new String();//count 和alt用来改变table每行的颜色
        try{
            Class.forName(DRIVER);
             conn = DriverManager.getConnection(URL,USER,PASS);  
             String sql = "select * from offlineInfo order by previewBegin desc";
		     pst = conn.prepareStatement(sql);
		     rs = pst.executeQuery();
		    while(rs.next()){
		      String previewName=rs.getString("previewName");
		      java.sql.Date previewBegin=rs.getDate("previewBegin");
		      java.sql.Date previewEnd=rs.getDate("previewEnd");
		      String previewLocate=rs.getString("previewLocate");
		      String name=rs.getString("name");
		      String locate=rs.getString("locate");
		      long id=rs.getLong("id");
		      Timestamp Time=rs.getTimestamp("time");
		      SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		      String time=sdf.format(Time);
		      alt=(count%2==0)?"":"alt";
		      count++;   
         %>
         <tr class="<%=alt %>">
          <td><%=previewName %></td>
          <td><%=previewBegin %></td>
          <td><%=previewEnd %></td>
          <td><%=previewLocate %></td>
         </tr>
         <%     } 
            
            } catch(Exception e){
             e.printStackTrace();
            }finally{DBUtil.release(rs, pst, conn);}
         
         %>
          
       </table>
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