<%@ page language="java" import="java.util.* ,entity.User" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="../js/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css" />
    <script type="text/javascript" src="../js/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    
</head>
<body>
   <script type="text/javascript" >
   $(function(){
   $('#modify').window('close');
    $('#tb').datagrid({
     toolbar:[{
       text:'删除',
	   iconCls:'icon-remove',
	   handler:function(){
	     var rows=$('#tb').datagrid('getSelections');
	     if(rows.length>0){
	       $.messager.confirm("请确认",'确定删除？',function(b){
							 if(b){
								var ids=[];
								for(var i=0;i<rows.length;i++){
									ids.push(rows[i].id);
								}
								$.ajax({
								  url:'<%=basePath %>del.manageAction',
								  data:{ids:ids.join(',')},
								  dataType:'json',
								  success:function(data){
								    if(data&&data.success){
								     $('#tb').datagrid('load');
								     $('#tb').datagrid('unselectAll');
								     $.messager.alert('删除成功');
								    }
								    else{
								     $('#tb').datagrid('rejectChanges');
								     $.messager.alert('删除失败');
								    }
								  },
								  error:function(data,status,e){alert("删除失败:"+e);},
								});
							 }
					});
	     }
	     else{$.messager.alert("提示",'请选择要删除的数据！','error');}
	   }
     },{
       text:'修改',
	   iconCls:'icon-edit',
	   handler:function(){
	     var mod=$('#tb').datagrid('getSelections');
	     if(mod.length>0){
	      var modify=mod[0];
	      $('#modify').window({
	       width:600,
	       height:400,
	       top:100,
	       left:300,
	       title:"添加用户",
	       minimizable:false,
	       maximizable:false,
	       modal:true,
	      });
	      document.getElementById("id").value=modify.id;
	      document.getElementById("name").value=modify.name;
	      document.getElementById("nickname").value=modify.nickName;
	      document.getElementById("email").value=modify.Email;
	      document.getElementById("telephone").value=modify.telephone;
	      document.getElementById("postBoy").value=modify.postBoy;
	      document.getElementById("address").value=modify.address;
	      
	     }else{$.messager.alert("提示",'请选择要编辑的数据！','error')}
	   }
     }]
    });
   });
    function upload(){
      $.ajax({
       url:'<%=basePath %>modify.manageAction',
       data:{'id':$('input[name="id"]').val(),'name':$('input[name="name"]').val(),
            'nickName':$('input[name="nickname"]').val(), 'email':$('input[name="email"]').val(),
            'telephone':$('input[name="telephone"]').val(),'postBoy':$('input[name="postBoy"]').val(),
            'address':$('input[name="address"]').val()},
       dataType:'json',
       success:function(data){
         if(data&&data.success){
           $('#modify').window('close');
           $('#tb').datagrid('load');
		   $('#tb').datagrid('unselectAll');
	       $.messager.alert("提示",'修改成功');
         }
         else{
           $('#modify').window('close');
            $('#tb').datagrid('unselectAll');
            $.messager.alert("提示","修改失败");
         }
       },
       error:function(data,status,e){
        $('#modify').window('close');
        $.messager.alert("提示",'修改失败：'+e);
       }
      });
    }
    </script>
    <div>
    <table id="tb" class="easyui-datagrid" title="用户信息" iconCls='icon-edit' width=100% height=500px fitColumns="true" loadMsg="数据加载中" 
    url='<%=basePath %>load.manageAction' pageSize=10 checkbox="true"  pagination="true"  scrollbarSize="0" rownumbers="true" >
     <thead>
      <tr>
      <th field="ck" checkbox="true"></th>
      <th field="id" width=120  align="center">用户编号</th>
      <th field="nickName" width=150  align="center">用户名</th>
      <th field="name" width=100  align="center">用户真名</th>
      <th field="Email" width=150 align="center">邮箱</th>
      <th field="telephone" width=120  align="center">手机号码</th>
      <th field="address" align="center" width=300 >收件地址</th>
      <th field="postBoy" align="center" width=100>邮编</th>
      </tr>
     </thead>
    </table>
    
    </div>
    <div id="modify"  class="easyui-window" style="padding: 5px;width:600;height:400;" >
       <form id="addUser" action="" method="post">
         <table align="center" style="margin-top:30px;"cellpadding="3">
           <tr style="height:50px;">
             <td>用户编号：</td>
             <td><input type="text" style="width:200px;height:25px" id="id" name="id" readonly="readonly"></td>         
           </tr>
           <tr style="height:50px;">
             <td>姓名：</td>
             <td><input type="text" style="width:200px;height:25px" id="name" name="name"></input></td>
             <td align="right">昵称：</td>
             <td><input type="text" style="width:200px;height:25px" id="nickname" name="nickname"></input></td>
           </tr>
           <tr style="height:50px;">
             <td>邮箱：</td>
             <td><input type="text" style="width:200px;height:25px" id="email" name="email"></input></td>
             <td>手机号码：</td>
             <td><input type="text" style="width:200px;height:25px" id="telephone" name="telephone"></input></td>
           </tr>
           <tr style="height:50px;">
             <td>邮编：</td>
             <td><input type="text" style="width:200px;height:25px" id="postBoy" name="postBoy"></input></td>
             <td>收件地址：</td>
             <td><input type="text" style="width:200px;height:25px"id="address" name="address"></input></td>
           </tr>
         </table>
         <center><input type="button" value="提交" style="width:60px;height:40px;margin-top:20px;" Onclick="upload()"></input></center>
       </form>
    </div>
</body>
</html>