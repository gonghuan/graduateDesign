<%@ page language="java" import="java.util.* ,java.sql.*,util.*,entity.User,java.text.*;" 
       contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    
    <title>会场</title>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="Shortcut Icon" type="image/x-icon" href="img/icon.PNG">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript">
	 function detailJsp(id){
	   //alert(id);
	   window.location.href='detail.jsp?id='+id;
	 }
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
        <input type="submit" class="search_submit" value="搜索" style="height: 40px; width:60px; ">
      </form>
  </div>
  <div style="margin:50px 10%;height:800px;">
   <table class="onSail" style="width:100%;border-spacing:0px;border-collapse:collapse;">
     <tr style="background:#A7C942;border:1px solid #98bf21;text-align:center;padding:5px;">
          <th>当前状态</th>
          <th>商品名称</th>
          <th>起始时间</th>
          <th>终止时间</th>
          <th>起拍价格</th>
     </tr><%! 
             public static final String DRIVER = "com.mysql.jdbc.Driver";  
             public static final String USER = "root";  
             public static final String PASS = "";  
             public static final String URL = "jdbc:mysql://localhost:3306/GraduateDesign?useUnicode=true&characterEncoding=UTF-8";
             int pageCount;    
        %>
        <%   Connection conn=null;
             PreparedStatement pst=null;
             ResultSet rs=null;
             int count=0;
             String alt=new String();//count 和alt用来改变table每行的颜色
             int curPage = 1; 
             int PAGESIZE=20;//一页最大有15条记录
        try{
            Class.forName(DRIVER);
             conn = DriverManager.getConnection(URL,USER,PASS);  
             String sql = "select * from goodsinfo where EndTime>=now() order by EndTime";
		     pst = conn.prepareStatement(sql);
		     rs = pst.executeQuery();
		     rs.last();
            int size = rs.getRow();
            rs.first();rs.previous();
            pageCount = (size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1);  
            String tmp = request.getParameter("curPage");  
            if(tmp==null){  
              tmp="1";  
             }  
            curPage = Integer.parseInt(tmp);  
            if(curPage>=pageCount) curPage = pageCount;
             else if(curPage-1<=0) curPage=1;   
		    while(rs.next()){
		     if(count>=PAGESIZE)break;
		      String statement=(rs.getTimestamp(7).before(new java.util.Date())&&
		      rs.getTimestamp(8).after(new java.util.Date()) ) ?"进行中" :"即将进行";
		      String name=rs.getString(2);
		      SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		      java.util.Date BeginTime=rs.getTimestamp(7);
		      String beginTime=sdf.format(BeginTime);
		      java.util.Date EndTime=rs.getTimestamp(8);
		      String endTime=sdf.format(EndTime);
		      long id=rs.getLong("GoodsId");
		      double price=rs.getDouble(4);
		      alt=(count%2==0)?"":"alt";
		      count++;   
         %>
          <tr class="<%=alt %>" onclick="detailJsp(<%=id %>)">
          <td><%=statement %></td>
          <td><%=name %></td>
          <td><%=beginTime %></td>
          <td><%=endTime %></td>
          <td><%=price %></td>
         </tr>
         
         <%     } 
            
            } catch(Exception e){
             e.printStackTrace();
            }finally{DBUtil.release(rs, pst, conn);}
         
         %>
   </table>
  </div>
  <div style="margin-bottom:20px;margin-left:33%">
     <a href = "Venue.jsp?curPage=1" style="text-decoration:none;color:#ff3300;">
                           首页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>  
     <a href = "Venue.jsp?curPage=<%=curPage %>" style="text-decoration:none;color:#ff3300">
                         上一页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>  
     <a href = "Venue.jsp?curPage=<%=curPage %>" style="text-decoration:none;color:#ff3300">
                        下一页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>  
     <a href = "Venue.jsp?curPage=<%=pageCount %>" style="text-decoration:none;color:#ff3300">
                       尾页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>  
               第<%=curPage%>页/共<%=pageCount%>页  
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
  