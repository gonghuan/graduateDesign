<%@ page language="java" import="java.util.*,java.sql.*,util.*,entity.*,dao.*" 
      contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%
 String path = request.getContextPath();
 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 String username="登录";
 String href="login.jsp";
 String id=request.getQueryString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详细信息</title>
<link rel="Shortcut Icon" type="image/x-icon" href="img/icon.PNG">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
	<script language="javascript">   
      window.onbeforeunload = function() {   
            var n = window.event.screenX - window.screenLeft;   
            var b = n > document.documentElement.scrollWidth-20;   
            if(b && window.event.clientY < 0 || window.event.altKey){   
                 session.invalidate();
            }
       };
       var RemainSeconds;
       var InterValObj;
       var flush;
       $(function(){
         loadDiscuss();
         document.onkeydown = hotkey; //当onkeydown 事件发生时调用hotkey函数
         RemainSeconds=parseInt($('#remain').val()); //这里获取倒计时的起始时间  
         InterValObj = window.setInterval("SetRemainTime()", 1000); //间隔函数，1秒执行
          $.ajax({
             url:'<%=basePath %>loadBid.action',
             data:{"id":$('#goodsId').val()},
             dataType:"json",
             success:function(data){
               var obj=data;
               obj.sort(getSortFun('desc', 'price'));
               var newest=obj[0];
               var price=newest["price"];
               var bidder=newest["bidder"];
               $('#addPrice').attr("value",price);
               $('#price').attr("value",price);
             },
             error:function(){}
           });
         $('li').css("cursor","pointer");
         $('li').click(function(){
          var add=$(this).text();
          var addPrice=document.getElementById("addPrice").value;
          var adds=parseFloat(add);
          var addPrices=parseFloat(addPrice);
          addPrices=addPrices+adds;
          $('#addPrice').attr("value",addPrices.toString());
       });
       });
       
       function SetRemainTime(){
          if(RemainSeconds>600*1000){
            RemainSeconds=RemainSeconds-1;
             var second = Math.floor(RemainSeconds % 60);             // 计算秒    
             var minute = Math.floor((RemainSeconds / 60) % 60);      //计算分
             var hour = Math.floor((RemainSeconds / 3600) % 24);      //计算小时
             var day=Math.floor((RemainSeconds / 3600) / 24);
             hour=24*day+hour;
             if(second<10){second='0'+second.toString();}
             if(minute<10){minute='0'+minute.toString();}
             if(hour<10){hour='0'+hour.toString();}  
             $('#span_hours').html(hour);
             $('#span_minutes').html(minute);
             $('#span_seconds').html(second);
            }else{
             window.clearInterval(InterValObj);
             hour="00";
             minute="00";
             second=RemainSeconds%10;
             second='0'+second.toString();
             $('#span_hours').html("<font>"+hour+"</font>");
             $('#span_minutes').html("<font>"+minute+"</font>");
             $('#span_seconds').html("<font>"+second+"</font>");
           $.ajax({
             url:'<%=basePath %>loadBid.action',
             data:{"id":$('#goodsId').val()},
             dataType:"json",
             success:function(data){
               var obj=data;
               obj.sort(getSortFun('desc', 'price'));
               var newest=obj[0];
               var price=newest["price"];
               var bidder=newest["bidder"];
               $('#span_price').html(price);
               $('#span_bidder').html(bidder);
               $('#addPrice').attr("value",price);
               $('#price').attr("value",price);
               var table=document.getElementById("tbBidRecord");  //获取table
               var length=table.rows.length;                //获取行数
               if(length>1){
                for(var i=length-1;i>=1;i--)         //先将table的行全部清空
                   {  
                       table.deleteRow(i);     
                   } 
               }
               var len=obj.length;
               if(len>20){len=20;}
               for(var i=0;i<len;i++){                 //最多添加20行数据
                  var insert=table.insertRow();        //添加行
                  var insertCell1=insert.insertCell();   //添加行中的一列数据
                  var insertCell2=insert.insertCell();   //添加行中的第二列数据
                  insertCell1.innerHTML="<center><font color='blue' size='2' family='Times'>"
                      +obj[i].bidder+"</font></center>";   //第一个单元格存放竞拍人
                  insertCell2.innerHTML="<center><font size='2' family='Times'>"
                      +obj[i].price+"<font></center>";    //第二个单元格存放价格
               }
             },
             error:function(){}
           });
             flush=window.setInterval("fresh()", 1000);
            }
       }
       
       function fresh(){
        if(RemainSeconds>0){
          RemainSeconds=RemainSeconds-1;
           var hour="00";
           var minute="00";
           var second=RemainSeconds%10;
           if(second==0){
           second='0'+second.toString();
           $('#span_hours').html("<font Style='color:red;'>"+hour+"</font>");
           $('#span_minutes').html("<font Style='color:red;'>"+minute+"</font>");
           $('#span_seconds').html("<font Style='color:red;'>"+second+"</font>");
           
           $.ajax({
             url:'<%=basePath %>loadBid.action',
             data:{"id":$('#goodsId').val()},
             dataType:"json",
             success:function(data){
               var obj=data;
               obj.sort(getSortFun('desc', 'price'));
               var newest=obj[0];
               var price=newest["price"];
               var bidder=newest["bidder"];
               $('#span_price').html(parseFloat(price));
               $('#span_bidder').html(bidder);
               var table=document.getElementById("tbBidRecord");  //获取table
               var length=table.rows.length;                //获取行数
               if(length>1){
                for(var i=length-1;i>=1;i--)         //先将table的行全部清空
                   {  
                       table.deleteRow(i);     
                   } 
               }
               var len=obj.length;
               if(len>20){len=20;}
               for(var i=0;i<len;i++){                 //最多添加20行数据
                  var insert=table.insertRow();        //添加行
                  var insertCell1=insert.insertCell();   //添加行中的一列数据
                  var insertCell2=insert.insertCell();   //添加行中的第二列数据
                  insertCell1.innerHTML="<center><font color='blue' size='2' family='Times'>"
                      +obj[i].bidder+"</font></center>";   //第一个单元格存放竞拍人
                  insertCell2.innerHTML="<center><font size='2' family='Times'>"
                      +obj[i].price+"<font></center>";    //第二个单元格存放价格
               }
             },
             error:function(){}
           });
           }else{
            second='0'+second.toString();
            $('#span_hours').html(hour);
            $('#span_minutes').html(minute);
            $('#span_seconds').html(second);
           }
        }else{
          window.clearInterval(flush);
          
        }
       }
       
     function getSortFun(order, sortBy) {
       var ordAlpah = (order == 'asc') ? '>' : '<';
       var sortFun = new Function('a', 'b', 'return a.' + sortBy + ordAlpah + 'b.' + sortBy + '?1:-1');
       return sortFun;
}
       
       function showHidden(){
        var userId=$('#userId').val();
        if(userId==0){
          window.location.href="login.jsp";
        }else{
        $('#bt_bid').css("display","none");
        $('#div_bid').css("display","block");
        }
       }
       
      function bidForGoods(goodsId){
        var price=document.getElementById("addPrice").value;
        var oldPrice=$('#price').val();
        if(price<=oldPrice){alert("竞价不能少于初始价格！");return;}
        var time=new Date();
        time=time.format("yyyy-MM-dd HH:mm:ss");
        var id=$('#userId').val();
        var name=$('#userName').val();
        $.ajax({
         url:'bidForGoods.action',
         data:{"goodsId":goodsId,"price":price,"time":time,"id":id,"name":name},
         dataType:"json",
         success:function(data){
           if(data.success==true){
            alert("当前竞拍成功");
            $('#bt_bid').css("display","block");
            $('#div_bid').css("display","none");
           }else{
            alert("竞拍失败");
           }
         },
         error:function(data,status,e){
          alert(e);
         }
        });
      }
     
      Date.prototype.format = function(format) {
    var o = {
    "M+" : this.getMonth() + 1, //month
    "d+" : this.getDate(), //day
    "H+" : this.getHours(), //hour
    "m+" : this.getMinutes(), //minute
    "s+" : this.getSeconds(), //second
    "q+" : Math.floor((this.getMonth() + 3) / 3), //quarter
    "S" : this.getMilliseconds()
    //millisecond
    }
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
 
    for ( var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
        format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}

    function transDiscuss(){
      var text=$('#writeArea').val();
      var textLength=text.length;
      if(textLength>140){
       alert("字数超过限制！");
       return;
      }
      var time=new Date();
      time=time.format("yyyy-MM-dd HH:mm:ss");
      var name=$('#userName').val();
      var id=$('#userId').val();
      if(name=="null"){
        window.location.href="login.jsp";
      }else{
      if(!text){
       alert("您没有输入");
      }else{
       $.ajax({
         url:'transWords.action',
         data:{"id":$('#goodsId').val(),"time":time,"name":name,"text":text,"userId":id},
         dataType:"json",
         timeout:80000,
         success:function(data){
           if(data.success==true){
            text="";
            document.getElementById("writeArea").value=text;
           }
         },
         error:function(data,status,e){alert(e);}
       });
      }
      }
    }
    
    function loadDiscuss(){        //使用了ajax长轮询
     $.ajax({
          url:'loadWords.action',
          data:{"id":$('#goodsId').val()},
          dataType:"json",
          timeout:80000,
          success:function(data,status){
           if(data!=null){
             var obj=data;
             var length=obj.length;
             var textarea=document.getElementById("showArea");
             for(var i=0;i<length;i++){
              document.getElementById("showArea").value+=obj[i].time+"\n"+"     "+
                 obj[i].name+":"+obj[i].text+"\n\n";
             }
             setTimeout(loadDiscuss, 5000);
           }
          },
          error:function(data,status,e){
             setTimeout(loadDiscuss, 5000);
          }
         });
    }
    
    function hotkey(){
     var a=window.event.keyCode;  
     if((a==13)&&(event.ctrlKey))  
      {  
         transDiscuss(); 
      }  
     }// end hotkey  
     
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
      
      <div style="width:60%;height:800px;margin:50px 20%;">
        <%    
            IGoodsDao goodsDao=new GoodsDaoImpl();
            id=id.substring(id.indexOf('=')+1);
            long GoodsId=Long.parseLong(id);
            GoodsInfo goods=goodsDao.findByGoodsId(GoodsId);
            String goodsName=goods.getGoodsName();
            String description=goods.getGoodsDescription();
            String imagePath=goods.getImagePath();
            java.util.Date endTime=goods.getEndTime();
            java.util.Date now=new java.util.Date();
            long remain=(endTime.getTime()-now.getTime())/1000;
            Object objs=request.getSession().getAttribute("User");  
            User user=(User)objs;
            long userId=0;
            String userName=null;
            if(user!=null){
             userId=user.getUserId();
             userName=user.getUserName();
            }
        %>
        <div id="detailImg" class="detailImg" style="width:300px;height:300px;">
         <img src=<%=imagePath %> style="width:300px;height:300px;"/>
        </div>
        <div id="detailInfo" class="detailInfo" style="width:500px;height:300px;">
          <div id="detailTitle" class="detailTitle" style="width:100%;height:50px;">
             <h3><%=goodsName %>&nbsp;&nbsp;&nbsp;&nbsp;<%=description %></h3>
          </div>
          <div id="detailPrice" class="detailPrice" style="width:100%;height:50px;">
             <div>
             <label>当前拍卖价:</label>
             <span id="span_price" class="span_price"></span>
             </div>
             <div style="margin-top:10px;">
             <label>当前出价人:</label>
             <span id="span_bidder" class="span_bidder"></span>
             </div>
          </div>
          <div id="detailTime" class="detailTime" style="width:100%;height:120px;">
            <div>
            <label>剩余时间:</label>
            <input type="hidden" id="remain" class="remain" value=<%=remain %>>
            <input type="hidden" id="goodsId" class="goodsId" value=<%=GoodsId %>>
            <span id="span_hours" class="span_hours"></span>:<span id="span_minutes" class="span_hours"></span>
            :<span id="span_seconds" class="span_seconds"></span>
            <button class="bt_bid" id="bt_bid"  onclick="showHidden()">出价</button>
            <div id="div_bid" class="div_bid"  style="display:none;">
              <input type="hidden" id="userId" class="userId" value=<%=userId %>>
              <input type="hidden" id="userName" class="userName" value=<%=userName %>>
              <input type="hidden" id="price" class="price">
              <input id="addPrice" value="0" type="text" readonly="readonly" style="width:60px;height:30px;"/>
              <ul id="add" class="add" style="margin-left:-20px;margin-bottom:-5px;display:inline-block">
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>1</center></li>
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>5</center></li>
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>10</center></li>
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>50</center></li>
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>100</center></li>
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>200</center></li>
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>500</center></li>
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>1000</center></li>
               <li style="width:40px;height:20px;background:white;display:inline-block"><center>5000</center></li>
              </ul>
        <center><button id="bt_bidForGoods" class="bt_bidForGoods" onclick="bidForGoods('<%=id %>')">确认出价</button></center>
            </div>
            <label>选择相应的钱数卡,有<font color="#ff3300">1/5/10/50/100/200/500/1000/5000</font>这几种选项卡</label>
            </div>
          </div>
          <div id="detailTips" class="detailTips" style="width:100%;">
            <label>在倒计时<font color="#ff3300">10</font>秒内，每次出价→成交时间将回滚到<font color="#ff3300">10秒</font></label>
            <label>倒计时为<font color="#ff3300">0</font>→成交！最后出价者为该次竞拍的<font color="#ff3300">赢家</font></label>
          </div>
          <div id="detailTip" class="detailTip" style="width:100%;">
            <label>【赢家支付信息】 总价：成交价<span id="span_price" class="span_price">0.00</span> 元 + 运费费20.00元 = 
            <font color="#ff3300">20.00元</font></label>
          </div>
        </div>
        <div id="detailRecord" class="detailRecord" style="width:300px;height:400px;">
          <div id="detailTitle" class="detailTitle" style="width:100%;height:25px;">
          <div style="width:25%;height:100%;background:white;"><label>出价记录</label></div>
          </div>
          <div id="detailBidRecord" class="detailBidRecord" style="width:100%">
            <table class="tbBidRecord" id="tbBidRecord" style="width:100%;">
              <tr>
               <th>出价人</th>
               <th>出价(元)</th>
              </tr>
            </table>
          </div>
        </div>
        <div id="leaveWords" class="leaveWords" style="width:500px;height:400px;">
          <div id="wordsTitle" class="wordsTitle" style="width:100%;height:25px;">
             <div style="width:20%;height:100%;background:white;"><label>交流区</label></div>
          </div>  
          <div id="div_discussArea" class="div_discussArea" style="width:100%;height:250px">
              <textarea class="showArea" id="showArea" style="width:99%;height:98.5%;
              font-size:13px;font-family:Arial;" readonly="readonly" ></textarea>
          </div>
          <div id="div_editor" class="div_editor">
             <textarea class="writeArea" id="writeArea" 
                  style="width:99%;height:90px;font-size:16px;font-family:Microsoft YaHei;"></textarea>
             <div style="width:100%;height:30px;background:#eaeaea;">
              <font size="2px" color="#909090" style="font-family:Times;margin-left:20px;">
                                                  最多输入140个字</font>
              <font size="2px" color="#909090" style="font-family:Times;margin-left:140px;">
                                                                 按ctrl+回车键快速发送消息</font>
              <button class="transDiscuss" id="transDiscuss" style="margin-top:4px;" onclick="transDiscuss()">
                                                    发送留言</button>
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