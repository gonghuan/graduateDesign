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
    <link rel="stylesheet" type="text/css" href="../js/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="../css/management.css"/>
    <script type="text/javascript" src="<%=basePath %>js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">
    $(function(){
    var editRow=undefined;        //获取正在编辑的行号
    $.extend($.fn.datagrid.defaults.editors, {
    datetimebox: {// datetimebox就是你要自定义editor的名称
        init: function (container, options) {
            var input = $('<input class="easyuidatetimebox">').appendTo(container);
            return input.datetimebox({
                formatter: function (date) {
                    return new Date(date).format("yyyy-MM-dd hh:mm:ss");
                }
            });
        },
        getValue: function (target) {
            return $(target).parent().find('input.combo-value').val();
        },
        setValue: function (target, value) {
            $(target).datetimebox("setValue", value);
        },
        resize: function (target, width) {
            var input = $(target);
            if ($.boxModel == true) {
                input.width(width - (input.outerWidth() - input.width()));
            } else {
                input.width(width);
            }
        }
    }
});
// 时间格式化
Date.prototype.format = function (format) {
    /*
    * eg:format="yyyy-MM-dd hh:mm:ss";
    */
    if (!format) {
        format = "yyyy-MM-dd hh:mm:ss";
    }

    var o = {
        "M+": this.getMonth() + 1, // month
        "d+": this.getDate(), // day
        "h+": this.getHours(), // hour
        "m+": this.getMinutes(), // minute
        "s+": this.getSeconds(), // second
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
        "S": this.getMilliseconds()
        // millisecond
    };

    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }

    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
};
     $('#tbOfflineInfo').datagrid({
         url:'<%=basePath %>loadOfflineInfo.manageAction',
         title:"线下公告管理",
         iconCls:'icon-edit',
         width:'100%',
         fitColumns:true,
         loadMsg:"数据加载中",
         pageSize:15,
         pageList:[15,30,45,60],
         checkbox:true,
         pagination:true,
         scrollbarSize:0,
         sortName:'previewBegin',
         sortOrder:'desc',
         remoteSort:false,
         columns:[[
            {field:'ck',checkbox:true},
            {field:'id',title:'线下公告编号',width:100,sortable:true,align:'center'},
            {field:'previewName',title:'预展标题',width:150,align:'center',editor:{
               type:'validatebox',
               options:{required:true}
            }},
            {field:'previewBegin',title:'预展开始时间',width:100, sortable:true,align:'center',editor:{
               type:'datebox',
			   options:{required:true}
            }},
            {field:'previewEnd',title:'预展结束时间',width:100,sortable:true,align:'center',editor:{
               type:'datebox',
               options:{required:true}
            }},
            {field:'previewProvince',title:'预展省市',width:60,align:'center',editor:{
               type:'validatebox',
			   options:{required:true}
            }},
            {field:'previewLocate',title:'预展地址',width:180,align:'center',editor:{
               type:'validatebox',
               options:{required:true}
            }},
            {field:'name',title:'拍卖名称',width:150,align:'center',editor:{
              type:'validatebox',
              options:{required:true}
            }},
            {field:'time',title:'拍卖时间',width:160,align:'center',editor:{
              type:'datetimebox',
              options:{required:true}
            }},
            {field:'locate',title:'拍卖地址',width:180,align:'center',editor:{
               type:'validatebox',
               options:{required:true}
            }}
         ]],
          toolbar:[{
           text:'添加',
           iconCls:'icon-add',
           handler:function(){
           if(editRow!=undefined){
						$('#tbOfflineInfo').datagrid('endEdit',editRow);
					}else{
             $('#tbOfflineInfo').datagrid('insertRow',{
               index:0,
               row:{
               }
             });
              editRow=0;      
              $('#tbOfflineInfo').datagrid('beginEdit',0);
             }
           }
          },{
           text:'删除',
           iconCls:'icon-remove',
           handler:function(){
            var rows=$('#tbOfflineInfo').datagrid('getSelections');
	     if(rows.length>0){
	       $.messager.confirm("请确认",'确定删除？',function(b){
							 if(b){
								var ids=[];
								for(var i=0;i<rows.length;i++){
									ids.push(rows[i].id);
								}
								$.ajax({
								  url:'<%=basePath %>delOfflineInfo.manageAction',
								  data:{ids:ids.join(',')},
								  dataType:'json',
								  success:function(data){
								    if(data&&data.success){
								     $('#tbOfflineInfo').datagrid('load');
								     $('#tbOfflineInfo').datagrid('unselectAll');
								     $.messager.alert('提示','删除成功');
								    }
								    else{
								     $('#tbOfflineInfo').datagrid('rejectChanges');
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
			$('#tbOfflineInfo').datagrid('endEdit',editRow);
					}
			},{
           text:'编辑',
           iconCls:'icon-edit',
           handler:function(){
            var rows=$('#tbOfflineInfo').datagrid('getSelections');
				 if(rows.length>=1){
				   if(rows.length==1){
					 var index=$('#tbOfflineInfo').datagrid('getRowIndex', rows[0]);
					 if(editRow!=undefined){
							$('#tbOfflineInfo').datagrid('endEdit',editRow);
					}else{
							$('#tbOfflineInfo').datagrid('beginEdit',index);
							editRow=index;
							$('#tbOfflineInfo').datagrid('highlightRow',index);
							$('#tbOfflineInfo').datagrid('unselectAll');
		
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
            $('#tbOfflineInfo').datagrid('cancelEdit',editRow);
            $('#tbOfflineInfo').datagrid('rejectChanges');
            $('#tbOfflineInfo').datagrid('unselectAll');
             editRow=undefined;
           }
          }],
          onAfterEdit :function(rowIndex,rowData,changes){
                 var inserted=$('#tbOfflineInfo').datagrid('getChanges','inserted');
				 var updateed=$('#tbOfflineInfo').datagrid('getChanges','updated');
					
				var url='';
				
				if(inserted.length>0){
					url='<%=basePath  %>addOfflineInfo.manageAction';
				}
				if(updateed.length>0){
					url='<%=basePath  %>modifyOfflineInfo.manageAction';
				}
				$.ajax({
					url:url,
					data:{'id':rowData.id,'previewName':rowData.previewName,'previewBegin':rowData.previewBegin,
					      'previewEnd':rowData.previewEnd,'previewProvince':rowData.previewProvince,
					      'previewLocate':rowData.previewLocate,'name':rowData.name,'locate':rowData.locate,
					      'time':rowData.time},
					dataType:'json',
					success:function(r){
						if(r&&r.success){
							$('#tbOfflineInfo').datagrid('load');
							$.messager.alert("提示","成功保存数据库",'info');
							
						}else{
							$('#tbOfflineInfo').datagrid('rejectChanges');
							$.messager.alert('错误',"保存数据库不成功",'error');
						}
						editRow=undefined;
						$('#tbOfflineInfo').datagrid('unselectAll');
					},
					error:function(r,status,e){$.messager.alert("提示","发生未知错误");}
					});
          }
      });
    });
      
    </script>
</head>
<body>
   <table id="tbOfflineInfo">
   
   </table>
</body>
</html>