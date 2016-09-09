<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/management.css"/>
    <link rel="stylesheet" type="text/css" href="../js/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css" />
    <script type="text/javascript" src="<%=basePath %>js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>  
    <script type="text/javascript">
      $(function(){
        var obj;
        $.ajax({
          url:'loadOnBid.manageAction',
          dataType:"json",
          success:function(data){
            obj=data;
            var length=obj.length;
            var str="";
            if(obj[0]!=false){
              for(var i=0;i<length;i++){
                var now=new Date();
                var isOnBid="拍卖进行中";
                var a=Date.parse(obj[i].beginTime);
                var beginTime=new Date(a);
                if(beginTime.getTime()-now.getTime()<0){isOnBid="拍卖进行中";}else{isOnbid="即将拍卖";}
                str+="<div style='width:182px;height:90px;background:#e0e0e0;margin-bottom:5px;"+
                "padding:5px 5px;display:block;' onclick=''>"+
                "<div style='display:block;border:1px solid #8DB2E3;width:80px;height:80px;'>"+
                     "<img src='"+"../"+obj[i].ImagePath+"'style='width:80px;height:80px;'></div>"+
                     "<div style='margin-top:-60px;margin-left:100px;'><label>"+obj[i].goodsId+"</label></div>"+
                     "<div style='margin-top:10px;margin-left:100px;'><label>"+isOnBid+"</label></div>"+"</div>";
              }
              $('#west').html(str);
            }else{
             $('#west').html("<font style='font-size:15px;font-family:Times;'>当前没有拍卖品</font>");
            }
          },
          error:function(data,e,status){
            alert(e);
          }
        });
      });
    </script>
</head>
<body class="easyui-layout" style="width:100%;height:100%">
  <div id="west" region="west" split="true" title="拍品列表" style="width:200px;">
   
  </div>
  
  <div id="center" region="center" title="拍卖监控" scrollbarSize=0 style="padding:5px">
     <div id="detailRecord" class="detailRecord" style="width:500px;height:300px;border:1px solid #8DB2E3">
         <div id="detailTitle" class="detailTitle" style="width:100%;height:25px;">
          <div style="width:16%;height:100%;background:white;"><label>出价记录</label></div>
          </div>
         <div id="detailBidRecord" class="detailBidRecord" style="width:100%">
            <table class="tbBidRecord" id="tbBidRecord" style="width:100%;">
              <tr>
               <th align="center">出价人</th>
               <th align="center">出价(元)</th> 
               <th align="center">出价时间</th>
              </tr>
            </table>
          </div>
     </div>
     <div id="operationInfo" class="operationInfo" style="width:500px;height:200px;border:1px solid #8DB2E3">
        <div style="margin:20px 10px">
        <label>拍卖品名称</label>
        <input type="text" readonly="readonly" class="easyui-validatebox">
        <label style="margin-left:22px;">起拍价</label>
        <input type="text" readonly="readonly" class="easyui-validatebox">
       </div>
       <div style="margin:20px 10px">
        <label style="margin-left:12px;">开始时间</label>
        <input type="text" readonly="readonly" class="easyui-validatebox">
        <label style="margin-left:10px;">结束时间</label>
        <input type="text" readonly="readonly" class="easyui-validatebox"> 
       </div>
       <button style="margin:20px 200px">结束拍卖</button>
       </div>
     <div id="leaveWords" class="leaveWords" style="width:450px;height:502px;border:1px solid #8DB2E3;margin:-504px 502px">
        <div id="wordsTitle" class="wordsTitle" style="width:100%;height:25px;">
             <div style="width:20%;height:100%;background:white;"><label>交流区</label></div>
          </div>  
          <div id="div_discussArea" class="div_discussArea" style="width:100%;height:320px">
              <textarea class="showArea" id="showArea" style="width:99%;height:98.5%;
              font-size:13px;font-family:Arial;" readonly="readonly" ></textarea>
          </div>
          <div id="div_editor" class="div_editor">
             <textarea class="writeArea" id="writeArea" 
                  style="width:99%;height:120px;font-size:16px;font-family:Microsoft YaHei;"></textarea>
             <div style="width:100%;height:32px;background:#eaeaea;">
              <font size="2px" color="#909090" style="font-family:Times;margin-left:20px;">
                                                  最多输入140个字</font>
              <font size="2px" color="#909090" style="font-family:Times;margin-left:100px;">
                                                                 按ctrl+回车键快速发送消息</font>
              <button class="transDiscuss" id="transDiscuss" style="margin-top:4px;" onclick="transDiscuss()">
                                                    发送留言</button>
             </div>
          </div>
     </div>
  </div>
</body>
</html>