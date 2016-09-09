<%@ page language="java" import="java.util.*,entity.*,java.sql.*;" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username="登录";
String href="login.jsp";
Object obj2=request.getSession().getAttribute("Goods");
List<GoodsInfo> list=new ArrayList<GoodsInfo>();
if(obj2!=null){ list=(List<GoodsInfo>)obj2;}
else list=null;

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="Shortcut Icon" type="image/x-icon" href="img/icon.PNG">
    <title>搜索结果</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
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
  <div class="searchResult" style="margin:40px 20%;width:60%;height:600px;">
  <table class="searchResult" >
  <tr>
    <th>商品名称</th>
    <th>起拍价格</th>
    <th>起始时间</th>
    <th>终止时间</th>
  </tr>
  <%  
    //一页放15个  
    String tName=new String();  //控制表格每行颜色 
    int pageCount;  
    int curPage = 1; 
    int PAGESIZE=15;//一页最大有15条记录
    int size = list.size();
    pageCount = (size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1);  
    String tmp = request.getParameter("curPage");  
    if(tmp==null){  
         tmp="1";  
     }  
    curPage = Integer.parseInt(tmp);  
    if(curPage>=pageCount) curPage = pageCount;
    else if(curPage-1<=0) curPage=1;   
    int count = 0;  
    Iterator<GoodsInfo> a=list.iterator();
    if(list.isEmpty()){}
    else{
    while(a.hasNext()){  
            if(count>=PAGESIZE)break;
            GoodsInfo goods=a.next();  
            String  name=goods.getGoodsName(); 
            double price = goods.getBeginPrice(); 
            java.util.Date beginTime=goods.getBeginTime();
            java.util.Date endTime=goods.getEndTime();
            if(count%2!=0){tName="alt";}
            else tName=null;
            count++;  
  %>  
    <tr class=<%=tName %>> 
       <td><%=name%></td>  
       <td><%=price%></td>  
       <td><%=beginTime%></td>  
       <td><%=endTime%></td>  
    </tr>  
  <%  
        } 
        }
%>  
</table>
  </div>
  <div style="margin-bottom:20px;margin-left:33%">
     <a href = "SearchResult.jsp?curPage=1" style="text-decoration:none;color:#ff3300;">
                           首页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>  
     <a href = "SearchResult.jsp?curPage=<%=curPage %>" style="text-decoration:none;color:#ff3300">
                         上一页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>  
     <a href = "SearchResult.jsp?curPage=<%=curPage %>" style="text-decoration:none;color:#ff3300">
                        下一页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>  
     <a href = "SearchResult.jsp?curPage=<%=pageCount %>" style="text-decoration:none;color:#ff3300">
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
  