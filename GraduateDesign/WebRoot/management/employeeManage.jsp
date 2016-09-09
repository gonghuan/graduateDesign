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
    var sexData=[{"value":"男","text":"男"},{"value":"女","text":"女"}];
      $(function(){
       $('#modify').window('close');
       $('#modifyStaffImg').window('close');
       $('#staffInfo').datagrid({
        url:'<%=basePath %>loadStaff.manageAction',
        title:'员工信息管理',
        iconCls:'icon-edit',
         width:'100%',
         fitColumns:true,
         loadMsg:"数据加载中",
         pageSize:15,
         pageList:[15,30,45,60],
         checkbox:true,
         pagination:true,
         scrollbarSize:0,
         rownumbers:true,
         columns:[[
          {field:'ck',checkbox:true},
          {field:'id',width:120,align:'center',title:'员工编号',sortable:true},
          {field:'name',width:100,align:'center',title:'姓名',editor:{
               type:'validatebox',
			   options:{required:true}
		  }},
          {field:'sex',width:50,align:'center',title:'性别',editor:{
               type:'combobox',
               options:{data:sexData,required:true}
          }},
          {field:'telephone',width:120,align:'center',title:'电话',editor:{
               type:'validatebox',
			   options:{required:true}
          }},
          {field:'email',width:140,align:'center',title:'电子邮件',editor:{
               type:'validatebox',
			   options:{required:true}
          }},
          {field:'entry',title:'入职时间',width:120,align:'center',sortable:true,editor:{
               type:'datebox',
			   options:{required:true}
          }},
          {field:'department',title:'部门',width:100,align:'center',editor:{
               type:'validatebox',
			   options:{required:true}
          }},
          {field:'position',title:'职位',width:100,align:'center',editor:{
               type:'validatebox',
			   options:{required:true}
          }},
         ]],
         toolbar:[{
           text:'删除',
           iconCls:'icon-remove',
           handler:function(){
            var rows=$('staffInfo').datagrid('getSelections');
             if(rows.length>0){
	       $.messager.confirm("请确认",'确定删除？',function(b){
							 if(b){
								var ids=[];
								for(var i=0;i<rows.length;i++){
									ids.push(rows[i].id);
								}
								$.ajax({
								  url:'<%=basePath %>delStaff.manageAction',
								  data:{ids:ids.join(',')},
								  dataType:'json',
								  success:function(data){
								    if(data&&data.success){
								     $('#dg').datagrid('load');
								     $('#dg').datagrid('unselectAll');
								     $.messager.alert('提示','删除成功');
								    }
								    else{
								     $('#dg').datagrid('rejectChanges');
								     $.messager.alert('提示','删除失败');
								    }
								  },
								  error:function(data,status,e){alert('提示',"删除失败:"+e);},
								});
							 }
					});
	     }
	     else{$.messager.alert("提示",'请选择要删除的数据！','error');}
           }
         },{
          text:'修改信息',
          iconCls:'icon-edit',
          handler:function(){
            var mod=$('#staffInfo').datagrid('getSelections');
            if(mod.length>0){
              var modify=mod[0];
              $('#modify').window({
               width:800,
               height:400,
               top:100,
               left:200,
               title:"修改员工信息",
               minimizable:false,
	           maximizable:false,
               modal:true,
               onBeforeOpen:function(){
                $.ajax({
                  url:'<%=basePath %>loadStaffByEmail.manageAction',
                  data:{"email":modify.email},
                  dataType:"json",
                  success:function(data){
                    var str=data["origin"].split(" ");
                    document.getElementById("id").value=data["id"];
                    document.getElementById("name").value=data["name"];
                    if(data['sex']=="男")
                    $("input[name='sex'][value=男]").attr("checked",true); 
                    else $("input[name='sex'][value=女]").attr("checked",true); 
                    //document.getElementById("sex").value=data["sex"];
                    document.getElementById("nation").value=data["nation"];
                    document.getElementById("province").value=str[0].toString();
                    var province=document.getElementById("province");    //获取省份下拉框对象
                    var sltCity=document.getElementById("city");            //获取城市下拉框对象
                    var provinceCity=city[province.selectedIndex - 1];    //得到对应省份的城市数组 
                    sltCity.length=1;                               //清空城市选项框，仅保留提示项
                    for(var i=0;i<provinceCity.length;i++){        //将城市数组中的值填充到城市下拉框中
             
                    sltCity[i+1]=new Option(provinceCity[i],provinceCity[i]);    //new Option函数第一个参数表示value，第二个参数表示文本属性
                    }
                    document.getElementById("city").value=str[1].toString();
                    $('#birthday').datebox('setValue',data["birthday"]);
                    document.getElementById("isMarried").value=data["isMarried"];
                    document.getElementById("identification").value=data["identification"];
                    document.getElementById("telephone").value=data["telephone"];
                    $('#entry').datebox('setValue',data["entry"]);
                    //document.getElementById("entry").value=data["entry"];
                    document.getElementById("department").value=data["department"];
                    document.getElementById("position").value=data["position"];
                    document.getElementById("priority").value=data["priority"];
                    document.getElementById("email").value=data["email"];
                    document.getElementById("address").value=data["address"];
                    $("#btUpload").click(function(){
                     $.ajax({
                      url:'<%=basePath %>modifyStaff.manageAction',
                      data:{"id":$('input[name="id"]').val(),
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
                        "password":data["password"],
                        "imagePath":data["imagePath"],
                        "address":$('#address').val()},
                      dataType:"json",
                      success:function(data){
                        if(data["success"]==true){
                         $.messager.alert("提示","修改成功");
                         $("#modify").window('close');
                         $('#staffInfo').datagrid('load');
                          $('#tb').datagrid('unselectAll');
                        }
                      },
                      error:function(){$.messager.alert("提示","修改失败",'error');}
                     });
                    });
                  },
                });
               },
              });
            }
            else{$.messager.alert("提示","请先选择要编辑的数据");}
          }
         }]
       });
      });
      
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
</head>
<body>
   <table id="staffInfo" class="staffInfo">
   </table>
   <div id="modify" class="easyui-window">
      <form id="modifyEmployee" >
     <div class="modifyEmploayee" >
     <div style="margin-top:20px;">
      <label for="id" style="margin-left:3%">id：</label>
      <input id="id" type="text" name="id" readonly="readonly" class="easyui-validatebox"/>
     </div>
     <div style="margin-top:10px;">
      <label for="name" style="margin-left:2%">姓名：</label>
      <input id="name" type="text" name="name" class="easyui-validatebox"   />
     </div>
     <div style="margin-top:10px;">
      <label for="sex" style="margin-left:2%">性别：</label>
      <input type="radio" id="sex" name="sex" value="男" /><font>男</font>
      <input type="radio" id="sex" name="sex" value="女"/><font>女</font>
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
      <input id="birthday" type="text" name="birthday" class="easyui-datebox" />
     </div>
     <div style="margin-top:10px;">
      <label for="isMarried" style="margin-left:2%">婚否：</label>
      <select id="isMarried" name="isMarried" class="easyui-combobox" panelHeight="auto">
       <option value="是" >是</option>
       <option value="否">否</option>
      </select>
     </div>
     <div style="margin-top:10px;">
       <label for="identification" style="margin-left:1%">身份证：</label>
       <input id="identification" type="text" class="easyui-validatebox" name="identification" />
     </div>
     <div style="margin-top:10px;">
       <label for="telephone" >手机号码：</label>
       <input id="telephone" type="text" class="easyui-validatebox" name="telephone" />
     </div>
     <div style="margin-left:400px;margin-top:-285px">
     <div style="margin-top:10px;">
       <label for="entry">入职时间：</label>
       <input id="entry" type="text" class="easyui-datebox" name="entry" />
     </div>
     <div style="margin-top:10px;">
       <label for="department" style="margin-left:2%">部门：</label>
       <input id="department" type="text" class="easyui-validatebox" name="department" />
     </div>
     <div style="margin-top:10px;">
       <label for="position" style="margin-left:2%">职位：</label>
       <input id="position" type="text" class="easyui-validatebox" name="position" />
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
       <input type="text" id="email" class="easyui-validatebox" name="email" data-options="validType:'email'"/>
     </div>
     <div style="margin-top:10px;margin-bottom:10px;">
       <label for="address" style="margin-top:-10px">家庭住址：</label>
       <textarea name="address" id="address" class="easyui-validatebox"></textarea>
     </div>
     <input id="btUpload" class="btUpload" type="button" value="上传" />
     </div>
     </div>
   </form>
   </div>
   
   <div id="modifyStaffImg" class="easyui-window">
     <form>
      <input type="file" id="flImg" name="flImg" style="margin-left:250px"/>
      <div id="divImg" class=divImg style="width:400px;height:300px">
      <img id="staffImg" class="staffImg" alt="" src="" >
      </div>
      <input type="button" id="btUploadStaffImg" value="上传图片" style="width:80px;height:30px;margin-left:250px"/>
     </form>
   </div>
</body>
</html>