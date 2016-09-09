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
    <script type="text/javascript" src="../js/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">
     $(function(){
      var editRow=undefined;        //获取正在编辑的行号
        $('#notice').datagrid({
         url:'<%=basePath %>loadNotice.manageAction',
         title:"公告管理",
         iconCls:'icon-edit',
         width:'100%',
         fit:true,
         fitColumns:true,
         loadMsg:"数据加载中",
         pageSize:15,
         pageList:[15,30,45,60],
         checkbox:true,
         pagination:true,
         scrollbarSize:0,
         rownumbers:true,
         sortName:'time',
         sortOrder:'desc',
         remoteSort:false,
         columns:[[
            {field:'ck',checkbox:true},
            {field:'id',title:'公告编号',width:120,sortable:true,align:'center'},
            {field:'context',title:'公告内容',width:320, align:'center',editor:{
               type:'validatebox',
			   options:{required:true}
            }},
            {field:'time',title:'发布时间',width:150,sortable:true,align:'center',editor:{
               type:'datebox',
               options:{required:true}
            }},
            {field:'href',title:'链接地址',width:300,align:'center',editor:{
               type:'validatebox',
               options:{required:true}
            }}
          ]],
          toolbar:[{
           text:'添加',
           iconCls:'icon-add',
           handler:function(){
           if(editRow!=undefined){
						$('#notice').datagrid('endEdit',editRow);
					}else{
             $('#notice').datagrid('insertRow',{
               index:0,
               row:{
               }
             });
              editRow=0;      
              $('#notice').datagrid('beginEdit',0);
             }
           }
          },{
           text:'删除',
           iconCls:'icon-remove',
           handler:function(){
            var rows=$('#notice').datagrid('getSelections');
	     if(rows.length>0){
	       $.messager.confirm("请确认",'确定删除？',function(b){
							 if(b){
								var ids=[];
								for(var i=0;i<rows.length;i++){
									ids.push(rows[i].id);
								}
								$.ajax({
								  url:'<%=basePath %>delNotice.manageAction',
								  data:{ids:ids.join(',')},
								  dataType:'json',
								  success:function(data){
								    if(data&&data.success){
								     $('#notice').datagrid('load');
								     $('#notice').datagrid('unselectAll');
								     $.messager.alert('提示','删除成功');
								    }
								    else{
								     $('#notice').datagrid('rejectChanges');
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
			text:'保存',
			iconCls:'icon-save',
			handler:function(){
			$('#notice').datagrid('endEdit',editRow);
					}
			},{
           text:'编辑',
           iconCls:'icon-edit',
           handler:function(){
            var rows=$('#notice').datagrid('getSelections');
				 if(rows.length>=1){
				   if(rows.length==1){
					 var index=$('#notice').datagrid('getRowIndex', rows[0]);
					 if(editRow!=undefined){
							$('#notice').datagrid('endEdit',editRow);
					}else{
							$('#notice').datagrid('beginEdit',index);
							editRow=index;
							$('#notice').datagrid('highlightRow',index);
							$('#notice').datagrid('unselectAll');
		
					}
					}
					else{$.messager.alert("提示","一次只能修改一行数据");}
				 }
				 else{$.messager.alert("提示","请先选择要编辑的行",'error');}
           }
          },{
           text:'撤销编辑',
           iconCls:'icon-redo',
           handler:function(){
            $('#notice').datagrid('cancelEdit',editRow);
            $('#notice').datagrid('rejectChanges');
            $('#notice').datagrid('unselectAll');
             editRow=undefined;
           }
          }],
          onAfterEdit :function(rowIndex,rowData,changes){
                 var inserted=$('#notice').datagrid('getChanges','inserted');
				 var updateed=$('#notice').datagrid('getChanges','updated');
					
				var url='';
				
				if(inserted.length>0){
					url='<%=basePath  %>addNotice.manageAction';
				}
				if(updateed.length>0){
					url='<%=basePath  %>modifyNotice.manageAction';
				}
				$.ajax({
					url:url,
					data:{'id':rowData.id,'time':rowData.time,'context':rowData.context,'href':rowData.href},
					dataType:'json',
					success:function(r){
						if(r&&r.success){
							$('#notice').datagrid('load');
							$.messager.alert("提示","成功保存数据库");
							
						}else{
							$('#notice').datagrid('rejectChanges');
							$.messager.alert('错误',"保存数据库不成功",'error');
						}
						editRow=undefined;
						$('#notice').datagrid('unselectAll');
					},
					error:function(r,status,e){$.messager.alert("提示","发生未知错误");}
					});
          }
        });
      });
    </script>
</head>
<body>
 <table id="notice"></table>
</body>
</html>