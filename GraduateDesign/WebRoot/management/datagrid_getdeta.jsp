<%@ page language="java" import="util.DBUtil" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String goodsId=request.getQueryString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/management.css"/>
    <link rel="stylesheet" type="text/css" href="../js/easyui/themes/default/easyui.css" />
    <script type="text/javascript" src="../js/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/datagrid-detailview.js"></script>
    <style type="text/css">
	.dv-table td{
		border:0;
	}
	.dv-label{
		font-weight:bold;
		color:#15428B;
		width:100px;
	}
    </style>
</head>
<body>
   <table class="dv-table" border="0" style="width:100%;">
     <tr>
       <td rowspan="3" style="width:60px">
       </td>
       <td class="dv-label">申请商品编号: </td>
       <td></td>
       <td class="dv-label">商品名称:</td>
       <td></td>
     </tr>
   </table>
</body>
</html>