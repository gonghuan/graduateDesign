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
    <script type="text/javascript" src="../js/easyui/datagrid-detailview.js"></script>
    <style>
     #tdLabel{
      font-weight:bold;
		color:#15428B;
		width:100px;
     }
    </style>
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

      $('#tbTempGoods').datagrid({
            toolbar:[
             {text:'删除',
              iconCls:'icon-remove',
              handler:function(){
               var rows=$('#tbTempGoods').datagrid('getSelections');
               if(rows.length>0){
                $.messager.confirm("请确认",'确定删除？',function(b){
							 if(b){
								var ids=[];
								for(var i=0;i<rows.length;i++){
									ids.push(rows[i].id);
								}
								$.ajax({
								  url:'<%=basePath %>delTempGoods.manageAction',
								  data:{ids:ids.join(',')},
								  dataType:'json',
								  success:function(data){
								    if(data&&data.success){
								     $('#tbTempGoods').datagrid('load');
								     $('#tbTempGoods').datagrid('unselectAll');
								     $.messager.alert('提示','删除成功');
								    }
								    else{
								     $('#tbTempGoods').datagrid('rejectChanges');
								     $.messager.alert('提示','删除失败');
								    }
								  },
								  error:function(data,status,e){alert('提示',"删除失败:"+e);},
								});
							 }
					});
               }else{
                $.messager.alert("提示","请先选择要删除的信息","info");
               }
              }
              },{
               text:'编辑',
               iconCls:'icon-edit',
               handler:function(){
                var rows=$('#tbTempGoods').datagrid('getSelections');
				 if(rows.length>=1){
				   if(rows.length==1){
					 var index=$('#tbTempGoods').datagrid('getRowIndex', rows[0]);
					 if(editRow!=undefined){
							$('#tbTempGoods').datagrid('endEdit',editRow);
					}else{
							$('#tbTempGoods').datagrid('beginEdit',index);
							editRow=index;
							$('#tbTempGoods').datagrid('highlightRow',index);
							$('#tbTempGoods').datagrid('unselectAll');
                   }
                  }
					else{$.messager.alert("提示","一次只能修改一行数据");}
				 }
				 else{$.messager.alert("提示","请先选择要编辑的行",'error');}
           }
              },{
			      text:'保存',
			      iconCls:'icon-save',
			      handler:function(){
			      $('#tbTempGoods').datagrid('endEdit',editRow);
				  }
				 
			  },{
			     text:'同意',
			     iconCls:'icon-ok',
			     handler:function(){
			       var rows=$('#tbTempGoods').datagrid('getSelections');
			       if(rows.length>0){
			       $.messager.confirm("请确认",'确定通过审核？',function(b){
					if(b){
			         var ids=[];
			         for(var i=0;i<rows.length;i++){
						ids.push(rows[i].GoodsId);
					   }
					 }
					$.ajax({
				     url:'<%=basePath %>AcceptTempGoods.manageAction',
				     data:{ids:ids.join(',')},
				     dataType:"json",
				     success:function(data){
				       if(data&&data.success){
						 $('#tbTempGoods').datagrid('load');
					     $('#tbTempGoods').datagrid('unselectAll');
					     $.messager.alert('提示','提交成功');
						  }
					 else{
						 $('#tbTempGoods').datagrid('rejectChanges');
						 $.messager.alert('提示','提交失败');
						 }
				     }
				    });
			       });
			       }else{
			        $.messager.alert("提示","请选择同意项","info");
			       }
			     }
			 },{
			  text:'撤销编辑',
			  iconCls:'icon-redo',
			  handler:function(){
			   $('#tbTempGoods').datagrid('cancelEdit',editRow);
               $('#tbTempGoods').datagrid('rejectChanges');
               $('#tbTempGoods').datagrid('unselectAll');
               editRow=undefined;
			  }
			 }
             ],
            onAfterEdit :function(rowIndex,rowData,changes){
             $.ajax({
               url:'<%=basePath  %>modifyTempGoods.manageAction',
               data:{'id':rowData.GoodsId,'GoodsName':rowData.GoodsName,'BeginPrice':rowData.BeginPrice,
               'Amount':rowData.Amount,'BeginTime':rowData.BeginTime,'EndTime':rowData.EndTime,
               'UserId':rowData.UserId,'ImagePath':rowData.ImagePath,'GoodsDescription':rowData.GoodsDescription},
               dataType:"json",
               success:function(r){
                 if(r&&r.success){
							$('#tbTempGoods').datagrid('load');
							$.messager.alert("提示","成功保存数据库");
							
						}else{
							$('#tbTempGoods').datagrid('rejectChanges');
							$.messager.alert('错误',"保存数据库不成功",'error');
						}
						editRow=undefined;
						$('#tbTempGoods').datagrid('unselectAll');
               },
               error:function(r,status,e){$.messager.alert("提示","发生未知错误");}
             });
            },
       	    view: detailview,
			detailFormatter:function(index,row){
					return '<table>'+
					        '<tr><td style="border:0" rowspan=4><img src='+row.ImagePath+' style="width:80px"></td></tr>'+
					        '<tr><td id="tdLabel" align="center" style="border:0;width:120px;">商品Id:</td>'+
					            '<td style="border:0">'+row.GoodsId+'</td>'+
					            '<td id="tdLabel" align="center" style="border:0;width:120px">商品名称:</td>'+
					            '<td style="border:0">'+row.GoodsName+'</td>'+
					            '<td id="tdLabel" align="center" style="border:0;width:120px;">起始价格:</td>'+
					            '<td style="border:0">'+row.BeginPrice+'</td></tr>'+
					        '<tr><td id="tdLabel" align="center" style="border:0;width:120px;">数量:</td>'+
					            '<td style="border:0">'+row.Amount+'</td>'+
					            '<td id="tdLabel" align="center" style="border:0;width:120px">开始时间:</td>'+
					            '<td style="border:0">'+row.BeginTime+'</td>'+
					            '<td id="tdLabel" align="center" style="border:0;width:120px;">结束时间:</td>'+
					            '<td style="border:0">'+row.EndTime+'</td></tr>'+
					        '<tr><td id="tdLabel" align="center" style="border:0;width:120px;">申请用户编号:</td>'+
					            '<td style="border:0">'+row.UserId+'</td>'+
					            '<td id="tdLabel" align="center" style="border:0;width:120px;">商品描述:</td>'+
					            '<td style="border:0">'+row.GoodsDescription+'</td></tr>'+
					        '</table>';
				},
			/*onExpandRow: function(index,row){
					$('#ddv-'+index).panel({
						border:false,
						cache:false,
						href:'datagrid_getdetail.jsp?GoodsId='+row.GoodsId,
						onLoad:function(){
							$('#tbTempGoods').datagrid('fixDetailRowHeight',index);
						}
					});
					$('#tbTempGoods').datagrid('fixDetailRowHeight',index);
				}*/
      });
     });
    </script>
</head>
<body>
  <table id="tbTempGoods" class="tbTempGoods" style="width:100%" title="申请拍卖管理" fitColumns="true" 
  remoteSort="false" url="<%=basePath %>loadTempGoods.manageAction" pagination="true" fit="true" loadMsg="数据加载中"  
  pageSize="10" pageList="[10,20,30,40]" scrollbarSize="0" iconCls="icon-edit" >
   <thead>
     <tr>
      <th field='ck' checkbox="true" ></th>
      <th field="GoodsId" width="100" align="center" sortable="true" >商品Id</th>
      <th field="GoodsName" align="center" width="150" editor="{type:'validatebox'}">商品名称</th>
      <th field="BeginPrice" align="center" width="50" sortable="true" editor="{type:'validatebox'}">起始价格</th>
      <th field="Amount" align="center" width="50" editor="{type:'validatebox'}">数量</th>
      <th field="BeginTime" align="center" width="150" sortable="true" editor="{type:'datetimebox'}">开始时间</th>
      <th field="EndTime" align="center" width="150" sortable="true" editor="{type:'datetimebox'}">结束时间</th>
      <th field="UserId" align="center" width="100" sortable="true">申请用户编号</th>
      <th field="ImagePath" align="center" width="150" editor="{type:'validatebox'}">图片路径</th>
      <th field="GoodsDescription" align="center" width="150" editor="{type:'validatebox'}">商品描述</th>
     </tr>
   </thead>
  </table>
</body>
</html>