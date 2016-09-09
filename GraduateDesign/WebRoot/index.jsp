<%@ page language="java" import="java.util.*,java.sql.*,util.*,entity.User,java.text.*" 
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
    
    <title>在线拍卖网主界面</title>
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
        <input type="submit" class="search_submit" value="搜索" style="height: 40px; width:60px">
      </form></div> 
   <div class="background" style="width:80%;height:1000px;">
    <div class="container" style="width:80%;height:100%;">
    <div class="headline" style="width:100%;height:40px;">
    <ul>
    <li><a href="offline.jsp">线下拍卖</a></li>
    <li><a href="Venue.jsp">进入会场</a></li>
    <li><a href="RegisterSail.jsp">申请拍卖</a></li>
    <li><a href="about.jsp">关于网站</a></li>
    </ul>
    </div>
    <div class="slider" style="width:100%;height:30%;background:white;">
      <div class="discription" style="width:25%;height:100%;">
      <form>
      <input type="radio" class="first" checked="checked" name="select"><font color="white">正宗宜兴紫砂壶</font><br>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="white">起拍价：1000元</font><br><br><br><br>
      <input type="radio" class="second" name="select"><font color="white">正品iPhone6(64G)九成新</font><br>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="white">起拍价：4000元</font><br><br><br><br>
      <input type="radio" class="third" name="select"><font color="white">《spark大数据处理：技术、应用与性能优化》</font><br>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="white">起拍价：20元</font><br>
      </form>
      </div>
      <div class="goodsImg">
      <ul class="slider">
       <li><a href="#"><img class="1" src="img/t820227-14-.jpg"></a></li>
       <li><a href="#"><img class="2" src="img/5e84dafced70d2381c54625cd4f0be4a.jpg"></a></li>
       <li><a href="#"><img class="3" src="img/u=61715802,2917252957&amp;fm=11&amp;gp=0.jpg"></a></li>
      </ul>
      </div>
      <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
       <script type="text/javascript">
     var adHeight = $(".slider .goodsImg").height();
      $(document).ready(function(){
       var len=$(".goodsImg li").length;
       var index=0;
       var adTimer=0;
	   
       $(".goodsImg").hover(function(){
        clearInterval(adTimer);
       },function(){
          adTimer = setInterval(function(){
			    showImg(index);
				index++;
				if(index==len){index=0;}
			  } , 5000);}).trigger("mouseleave");
      });
      
      function showImg(index){
		$(".slider").stop(true,false).animate({top : -adHeight*index},500);
		
		
}
       </script>
      <div class="recommend" style="width:25%;height:219%">
      <center><h1 style="padding-top:10px;">猜你喜欢</h1></center>
      </div>
      <div class="onSail" style="width:75%;height:120%;">
      <div Style="background-color:#4499ee;height:30px;"><center style="color:white; padding-top:5px;">正在拍卖</center></div>
      <div style="width:100%">
       <table class="onSail" style="width:100%;border-spacing:0px;border-collapse:collapse;">
        <tr style="background:#A7C942;border:1px solid #98bf21;text-align:center;padding:5px;">
          <th>当前状态</th>
          <th>商品名称</th>
          <th>起始时间</th>
          <th>终止时间</th>
          <th>起拍价格</th>
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
             String sql = "select * from goodsinfo where EndTime>=now() or BeginTime>=now() "+ 
             "order by BeginTime limit 0,4";
		     pst = conn.prepareStatement(sql);
		     rs = pst.executeQuery();
		    while(rs.next()){
		      String statement=(rs.getTimestamp(7).before(new java.util.Date())&&
		      rs.getTimestamp(8).after(new java.util.Date()) ) ?"进行中" :"即将进行";
		      String name=rs.getString(2);
		      SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		      java.util.Date BeginTime=rs.getTimestamp(7);
		      String beginTime=sdf.format(BeginTime);
		      java.util.Date EndTime=rs.getTimestamp(8);
		      String endTime=sdf.format(EndTime);
		      double price=rs.getDouble(4);
		      long id=rs.getLong("GoodsId");
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
      </div>
      <div class="additions" style="width:75%;height:100%;">
        <div class="news" style="width:50%;height:98.4%;border-bottom:solid 1px grey">
        <div style="width:60px;height:20px; background:#ff1122; margin-left:20px;color:white;">
        <center>新闻</center></div> 
        <div class="newslist" style="margin:20px;background:;">
        <%
             Connection conn2=null;
             PreparedStatement pst2=null;
             ResultSet rs2=null;
             String sql2="select * from news order by time desc limit 0,4";
             try{
               conn2=DBUtil.getConnection();
               pst2=conn2.prepareStatement(sql2);
               rs2=pst2.executeQuery();
          %>
          <ul>
          <% 
               while(rs2.next()){
                 String context=rs2.getString("context");
                 String href2=rs2.getString("href");
                 java.sql.Date time=rs2.getDate("time"); 
           %>
          <li><a href=<%=href2 %> target="_blank"><%=context %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
               <font style="font-family:Times;font-style:italic;font-size:12px;"><%=time %><br><br></font>
           </li>
          <%
               }
             }catch(Exception e){
              e.printStackTrace();
             }finally{DBUtil.release(rs2, pst2, conn2);}
          %>
        </ul>
        </div>
        </div>
        <div class="notice" style="margin-top:-45.7%;width:50%;height:98.4%;
                    border-left:dotted 1px;border-bottom:solid 1px grey">
        <div style="width:60px;height:20px; background:#ff1122; margin-left:20px;color:white;">
        <center>公告</center></div>
        <div class="noticelist" style="margin:20px;background:;">
        <%
             Connection conn3=null;
             PreparedStatement pst3=null;
             ResultSet rs3=null;
             String sql3="select * from notice order by time desc limit 0,4";
             try{
               conn3=DBUtil.getConnection();
               pst3=conn3.prepareStatement(sql3);
               rs3=pst3.executeQuery();
          %>
          <ul>
          <% 
               while(rs3.next()){
                 String context=rs3.getString("context");
                 String href3=rs3.getString("href");
                 java.sql.Date time=rs3.getDate("time"); 
           %>
           <li><a href=<%=href3 %> target="_blank"><%=context %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
               <font style="font-family:Times;font-style:italic;font-size:12px;"><%=time %><br><br></font>
           </li>
          <%
               }
             }catch(Exception e){
              e.printStackTrace();
             }finally{DBUtil.release(rs3, pst3, conn3);}
          %>
        </ul>
        </div>
        </div>
      </div>
    
  </div>
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
         Copyright@ 东北大学秦皇岛分校-4110309-贡欢 技术支持：&nbsp;&nbsp;&nbsp;程绍辉老师<br>
                           联系方式：18233562573&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         E-mail:1131474643 @ qq.com
    </p>
    </div>
  </body>
</html>
