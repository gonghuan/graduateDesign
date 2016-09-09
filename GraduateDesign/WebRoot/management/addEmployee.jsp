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
    <script type="text/javascript" src="<%=basePath %>js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jquery.imgareaselect.pack.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>   
   
</head>
<body>
<script type="text/javascript" >
     $(function(){
      $('#uploadImg').window('close');
      $('#img').click(function(){
        $('#uploadImg').window({
           width:600,
	       height:400,
	       top:100,
	       left:300,
	       title:"上传照片",
	       minimizable:false,
	       maximizable:false,
	       modal:true,
	       closable:false
        });
      });
     });
     
     function uploadImg(){
       var f=document.getElementById("file1").value;
       if(!/.(gif|jpg|jpeg|png|bmp|JPG|PNG|BMP)$/.test(f))
          {
              alert("图片类型必须是.jpeg,jpg,png,bmp中的一种");
              return false;
          }
        $.ajaxFileUpload({
         url:'<%=basePath %>uploadStaffImg.manageAction',
         fileElementId:'file1',
         dataType:'json',
         data:{"operation":1},
         success:function(data){
           if(data['result']==1){
             var imgPath=data.path;
             imgPath=imgPath.toString();
			 $(".uploadImgs").attr("src",imgPath);
			 $(".uploadImgs").imgAreaSelect({ selectionColor: 'blue',minWidth: 59, minHeight:82.6,handles: true,
                selectionOpacity: 0.2, aspectRatio: '295:413', fadeSpeed: 200,
                onInit:function(){$('input[name="width"]').val($("#uploadImgs").width());
                                  $('input[name="height"]').val($("#uploadImgs").height());},
                onSelectChange: preview,x1:0,y1:0,x2:59,y2:82.6,
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
         error:function(data,status,e){$.messager.alert("提示",e)}
        });  
       
     };
     
     function preview(img, selection) {
             if (!selection.width || !selection.height)
              return;

            var scaleX = 118 / selection.width;
            var scaleY = 165.2 / selection.height;
            
            $(".frames .preview img").css({
            width: Math.round(scaleX*($("#img").width()))+"px",
            height: Math.round(scaleY*($("#img").height()))+"px",
            marginLeft: -Math.round(scaleX * selection.x1)+"px",
            marginTop: -Math.round(scaleY * selection.y1)+"px",
            });
            }    
            
      function cutImage(path) { 
          $.ajax( { 
            type : "POST", 
            url:'<%=basePath %>uploadStaffImg.manageAction', 
            dateType:"json", 
            data:{"operation":2,"x1":$('input[name="x1"]').val(), 
            "x2":$('input[name="x2"]').val(), 
            "y1":$('input[name="y1"]').val(), 
            "y2":$('input[name="y2"]').val(),
            "width":$('input[name="width"]').val(), 
            "height":$('input[name="height"]').val(), 
            "path":path}, 
          success : function(data) { 
              alert("头像上传成功");
              $('#uploadImgs').imgAreaSelect({hide:true});
              $('#uploadImg').window('close');
              var path=data.path;
              path=path.toString();
               $(".previewImg").attr("src",path);
               
               $('#btUpload').click(function(){
                $.ajax({
               url:'<%=basePath %>uploadStaff.manageAction',
               dateType:"json", 
               data:{
               "imagePath":path,
               "name":$('input[name="name"]').val(),
               "sex":$('input[name="sex"]').val(),
               "nation":$('#nation').val(),
               "province":$('#province').val(),
               "city":$('#city').val(),
               "birthday":$('input[name="birthday"]').val(),
               "isMarried":$('#isMarried').val(),
               "identification":$('input[name="identification"]').val(),
               "telephone":$('input[name="telephone"]').val(),
               "entry":$('input[name="entry"]').val(),
               "department":$('input[name="department"]').val(),
               "position":$('input[name="position"]').val(),
               "priority":$('#priority').val(),
               "email":$('input[name="email"]').val(),
               "password":$('input[name="password"]').val(),
               "address":$('#address').val()
               },
               success:function(data){
                 $.messager.alert("情况","上传信息成功");
               }
              });
               });
              
          }, 
         error:function(data,e) { 
               alert(e);
         } 
    }); 
    };
     
     var city=[
      ["东城","西城","宣武","朝阳","崇文"],
      ["黄埔","卢湾","徐汇","长宁","静安"],
      ["南京","苏州","无锡","常州","镇江","扬州","泰州","南通","徐州","盐城","宿迁","淮安","连云港"],
      ["石家庄","承德","张家口","秦皇岛","廊坊","唐山","保定","沧州","衡水","邢台","邯郸"]
     ];
     
     function getCity(){
      var province=document.getElementById("province");    //获取省份下拉框对象
      var sltCity=document.getElementById("city");            //获取城市下拉框对象
      var provinceCity=city[province.selectedIndex - 1];    //得到对应省份的城市数组 
      sltCity.length=1;                               //清空城市选项框，仅保留提示项
      for(var i=0;i<provinceCity.length;i++){        //将城市数组中的值填充到城市下拉框中
             
             sltCity[i+1]=new Option(provinceCity[i],provinceCity[i]);    //new Option函数第一个参数表示value，第二个参数表示文本属性
         }
     }
     
    </script>
 
  
  <div>
   <form id="addEmployee" >
     <div id="img" class="img" style="width:118px;height:165.2px;">
      <img class="previewImg" alt="单击上传图片" src="" style="width:118px;height:165.2px">
     </div>
     <div class="information" >
     <div>
      <label for="name" style="margin-left:2%">姓名：</label>
      <input type="text" name="name" class="easyui-validatebox"   />
     </div>
     <div style="margin-top:10px;">
      <label for="sex" style="margin-left:2%">性别：</label>
      <input type="radio" name="sex" value="男" /><font>男</font>
      <input type="radio" name="sex" value="女"/><font>女</font>
     </div>
     <div style="margin-top:10px;">
      <label for="nation" style="margin-left:2%">民族：</label>
      <select id="nation" name="nation" class="easyui-combobox" panelHeight="auto">
       <option value="汉" selected="selected">汉</option>
       <option value="蒙古">蒙古</option>
       <option value="回">回</option>
       <option value="藏">藏</option>
       <option value="壮">壮</option>
       <option value="满">满</option>
       <option value="维吾尔">维吾尔</option>
       <option value="朝鲜">朝鲜</option>
      </select>
     </div>
     <div style="margin-top:10px;">
     <label style="margin-left:2%">籍贯：</label>
     <select id="province" name="province"  onchange="getCity()">
       <option>----请选择省份----</option>
        <option value="北京">北京</option>
        <option value="上海">上海</option>
        <option value="江苏">江苏</option>
        <option value="河北">河北</option>
     </select>
     <label>——</label>
     <select id="city" name="city" >
       <option>----请选择城市----</option>
     </select>
     </div>
     <div style="margin-top:10px;">
      <label for="birthday">出生日期：</label>
      <input type="text" name="birthday" class="easyui-datebox" />
     </div>
     <div style="margin-top:10px;">
      <label for="isMarried" style="margin-left:2%">婚否：</label>
      <select id="isMarried" name="isMarried" class="easyui-combobox" panelHeight="auto">
       <option value="是" selected="selected">是</option>
       <option value="否">否</option>
      </select>
     </div>
     <div style="margin-top:10px;">
       <label for="identification" style="margin-left:1%">身份证：</label>
       <input type="text" class="easyui-validatebox" name="identification" />
     </div>
     <div style="margin-top:10px;">
       <label for="telephone" style="margin-left:2%">手机：</label>
       <input type="text" class="easyui-validatebox" name="telephone" />
     </div>
     <div style="margin-top:10px;">
       <label for="entry">入职时间：</label>
       <input type="text" class="easyui-datebox" name="entry" />
     </div>
     <div style="margin-top:10px;">
       <label for="department" style="margin-left:2%">部门：</label>
       <input type="text" class="easyui-validatebox" name="department" />
     </div>
     <div style="margin-top:10px;">
       <label for="position" style="margin-left:2%">职位：</label>
       <input type="text" class="easyui-validatebox" name="position" />
     </div>
     <div style="margin-top:10px;">
       <label for="priority" style="margin-left:2%">权限：</label>
       <select name="priority" id="priority" class="easyui-combobox" panelHeight="auto">
         <option value="1">1</option>
         <option value="2">2</option>
         <option value="3">3</option>
       </select>
     </div>
     <div style="margin-top:10px;">
       <label for="email" style="margin-left:2%">email：</label>
       <input type="text" class="easyui-validatebox" name="email" data-options="validType:'email'"/>
     </div>
     <div style="margin-top:10px;">
       <label for="password" style="margin-left:2%">密码：</label>
       <input id="password" type="password" name="password" class="easyui-validatebox" 
        data-options="validType:'length[4,50]'"/>
     </div>
      <div style="margin-top:10px;">
       <label for="password">确认密码：</label>
       <input type="password" name="password" class="easyui-validatebox" 
        validType="equalTo['#password']" invalidMessage="两次输入密码不匹配"/>
     </div>
     <div style="margin-top:10px;margin-bottom:10px;">
       <label for="address" style="margin-top:-10px">家庭住址：</label>
       <textarea name="address" id="address" class="easyui-validatebox"></textarea>
     </div>
     <input id="btUpload" class="btUpload" type="button" value="上传" />
     </div>
   </form>
  </div>
  
 <div id="uploadImg" class="easyui-window" >
   <form>
    <input id="file1" class="file1" type="file" name="file1" style="margin-top:5px;margin-left:40%" onchange="uploadImg()">
    <div class="imgs" style="width:400px;height:300px;margin-left:12%">
    <img id="uploadImgs" class="uploadImgs" alt="" src="" style="max-width:400px;max-height:300px;" />
    </div>
    <input type="button" class="button" style="margin-left:42%" value="上传">
    <input type="hidden" id="x1" class="x1" name="x1" value="0" />  
    <input type="hidden" id="y1" class="y1" name="y1" value="0" />  
    <input type="hidden" id="x2" class="x2" name="x2" value="120" />  
    <input type="hidden" id="y2" class="y2" name="y2" value="120" />
    <input type="hidden" id="width" class="width" name="width" value="" />
    <input type="hidden" id="height" class="height" name="height" value="" />
   </form>
  </div>
  
</body>
</html>