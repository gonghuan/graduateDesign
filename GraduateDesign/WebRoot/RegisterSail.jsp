<%@ page language="java" import="java.util.* ,entity.User" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username="登录";
String href="login.jsp";
String src="img/defaultOne.jpg";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>申请拍卖</title>
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
  
  
      <script type="text/javascript" src="<%=basePath %>js/jquery-1.8.2.min.js"></script>
      <script type="text/javascript" src="<%=basePath %>js/ajaxfileupload.js"></script>
      <script type="text/javascript" src="<%=basePath %>js/jquery.imgareaselect.pack.js"></script>
      <script language="javascript" type="text/javascript"  
         src="js/My97DatePicker/WdatePicker.js"></script>
      <script type="text/javascript">
      function uploadImage(){
          var f=document.getElementById("file").value;
          if(!/.(gif|jpg|jpeg|png|bmp|JPG|PNG|BMP)$/.test(f))
          {
              alert("图片类型必须是.jpeg,jpg,png,bmp中的一种");
              return false;
          }
          $.ajaxFileUpload({
            url : '<%=basePath %>uploadGoods', //需要链接到服务器地址 
            fileElementId : 'file',// 文件选择框的id属性 
            dataType : 'json',// 服务器返回的格式，可以是json 
            data : {"operation":1}, 
            success : function(data){
             if (data['result'] == 1) { 
                    var imgPath=data.path;
                    imgPath=imgPath.toString();
					$(".img").attr("src","goodsTmp/"+imgPath);
					$(".img2").attr("src","goodsTmp/"+imgPath);
                $("#img").imgAreaSelect({ selectionColor: 'blue',minWidth: 100, minHeight:100,handles: true,
                selectionOpacity: 0.2, aspectRatio: '1:1', fadeSpeed: 200, 
                onInit:function(){$('input[name="width"]').val($("#img").width());
                                  $('input[name="height"]').val($("#img").height()); },
                onSelectChange: preview,x1:0,y1:0,x2:120,y2:120,
                onSelectEnd:function(img,selection){
                        $('input[name="x1"]').val(selection.x1); 
                        $('input[name="y1"]').val(selection.y1); 
                        $('input[name="x2"]').val(selection.x2); 
                        $('input[name="y2"]').val(selection.y2);
                        
                } 
                
                });
                $(".button").click(function(){cutImage(data['path']); });
                
             }else{alert("发生未知错误，请重新尝试");}
            },
            error:function(data,status,e){alert(e);} 
          });
         }
         
         function preview(img, selection) {
             if (!selection.width || !selection.height)
              return;

            var scaleX = 200 / selection.width;
            var scaleY = 200 / selection.height;
            
            $(".preview img").css({
            width: Math.round(scaleX*($("#img").width()))+"px",
            height: Math.round(scaleY*($("#img").height()))+"px",
            marginLeft: -Math.round(scaleX * selection.x1)+"px",
            marginTop: -Math.round(scaleY * selection.y1)+"px",
            });
            }    
            
         function cutImage(path) { 
          $.ajax( { 
            type : "POST", 
            url:"<%=basePath %>uploadGoods", 
            dateType:"json", 
            data:{"operation":2,"x1":$('input[name="x1"]').val(), 
            "x2":$('input[name="x2"]').val(), 
            "y1":$('input[name="y1"]').val(), 
            "y2":$('input[name="y2"]').val(),
            "width":$('input[name="width"]').val(), 
            "height":$('input[name="height"]').val(),
            "goodsName":$('input[name="goodsName"]').val(),
            "beginPrice":$('input[name="beginPrice"]').val(),
            "amount":$('input[name="amount"]').val(),
            "beginTime":$('input[name="beginTime"]').val(),
            "endTime":$('input[name="endTime"]').val(),
            "description":$('input[name="discription"]').val(),
            "path":path}, 
          success : function(data) { 
              //top.location.href="photo_view.vm?path="+data["path"]; 
              if(data["result"]==1)
              {alert("申请成功提交，请等待管理员确认");}
              else {alert("发生未知错误");}
          }, 
         error:function(data,e) { 
               alert(e);
         } 
    }); 
}
   </script>
  <div class="registerSail">
    <form class="uploadInfo" action="" method="post">
    
     <table class="goodsInfo">
      <tr align="center" height="60px">
       <td >拍品名称：</td>
       <td ><input name="goodsName" style="height:45px;width:200px;" type="text" /></td>
      </tr>
      <tr align="center" height="60px">
       <td>起始价格：</td>
       <td><input name="beginPrice" style="height:45px;width:200px;" type="text" /></td>
      </tr>
      <tr align="center" height="60px">
       <td>拍品数目：</td>
       <td><input name="amount" style="height:45px;width:200px;" type="text" /></td>
      </tr>
      <tr align="center" height="60px">
       <td>建议开拍时间:</td>
       <td><input name="beginTime" style="height:45px;width:200px;" type="text" 
               onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
      </tr>
      <tr align="center" height="60px">
       <td>建议结束时间:</td>
       <td><input name="endTime" style="height:45px;width:200px;" 
               type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
      </tr>
      <tr align="center" height="60px">
       <td>拍品描述</td>
       <td><input name="discription" style="height:45px;width:200px;" type="text" /></td>
      </tr>
     </table>
     <div class="goodsImgs">
      <input type="file" id="file" name="file" class="file" style="height:40px;width:100px;" onchange="uploadImage()" ></input><br />
      <p style="margin-top:-10px;">单击并拖动鼠标在图像上选择一个区域。</p>
      <div style="width:400px;height:400px;background:white"><img id="img" class="img"  src="" alt="" 
           style="max-height: 400px;max-width:400px;"/></div><br />
      <input type="button" class="button" value="提交" style="height:40px;width:60px;margin-top:50px;"></input>
      <div class="preview" style="width: 200px; height: 200px; overflow: hidden;background:white;">
      <img id="img2" class="img2" src="" alt="" style="width: 200px; height: 200px;" />
      <input type="hidden" id="x1" class="x1" name="x1" value="0" />  
      <input type="hidden" id="y1" class="y1" name="y1" value="0" />  
      <input type="hidden" id="x2" class="x2" name="x2" value="120" />  
      <input type="hidden" id="y2" class="y2" name="y2" value="120" />
      <input type="hidden" id="width" class="width" name="width" value="" />
      <input type="hidden" id="height" class="height" name="height" value="" />
     </div>
     </div>
    </form>
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
   