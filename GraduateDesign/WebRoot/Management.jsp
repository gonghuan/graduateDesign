<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>管理界面</title>
    <link rel="Shortcut Icon" type="image/x-icon" href="img/icon.PNG">
    <link rel="stylesheet" type="text/css" href="css/default.css"/>
    <link rel="stylesheet" type="text/css" href="css/management.css"/>
    <link rel="stylesheet" type="text/css" href="js/jquery easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="js/jquery easyui/themes/icon.css" />
    <script type="text/javascript" src="js/jquery easyui/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/jquery easyui/jQuery.easyui.js"></script>
	<script type="text/javascript" src="js/jquery easyui/outlook2.js"> </script>
    <script type="text/javascript">
    var _menus = {"menus":[
						{"menuid":"1","icon":"icon-sys","menuname":"系统管理",
							"menus":[{"menuname":"广告管理","icon":"icon-nav","url":"#"},
									{"menuname":"用户信息管理","icon":"icon-users","url":"management/userInfoMag.jsp"},
									{"menuname":"公告管理","icon":"icon-role","url":"management/noticeMag.jsp"},
									{"menuname":"新闻管理","icon":"icon-set","url":"management/newsMag.jsp"},
								]
						},{"menuid":"8","icon":"icon-sys","menuname":"员工管理",
							"menus":[{"menuname":"添加员工","icon":"icon-add","url":"management/addEmployee.jsp"},
									{"menuname":"员工信息管理","icon":"icon-nav","url":"management/employeeManage.jsp"}
								]
						},{"menuid":"56","icon":"icon-sys","menuname":"拍卖会管理",
							"menus":[{"menuname":"线下公告","icon":"icon-nav","url":"management/offlineInfo.jsp"},
									{"menuname":"处理申请","icon":"icon-nav","url":"management/applicationMag.jsp"}
								]
						},{"menuid":"28","icon":"icon-sys","menuname":"拍卖会控制",
							"menus":[{"menuname":"后台拍卖会管理监控","icon":"icon-nav","url":"management/auctionMag.jsp"},
								]
						},{"menuid":"39","icon":"icon-sys","menuname":"其他",
							"menus":[{"menuname":"站内信息","icon":"icon-nav","url":"#"},
								]
						}
				]};
				
    </script>
</head>

<body  class="easyui-layout" style="overflow-y: hidden;"  scroll="no" >
<noscript>
<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
    <img src="js/jquery%20easyui/images/noscript.gif" alt='抱歉，请开启脚本支持！' />
</div></noscript>
    <div region="north" split="true" border="false" style="overflow: hidden; height: 30px;
        background: url(js/jquery%20easyui/images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%;
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
        <span style="float:right; padding-right:20px;" class="head">欢迎  <a href="#" id="editpass">修改密码</a> <a href="#" id="loginOut">安全退出</a></span>
        <span style="padding-left:10px; font-size: 16px; "><img src="js/jquery%20easyui/images/blocks.gif" width="20" height="20" align="absmiddle" />在线拍卖网后台管理</span>
    </div>
    <div region="south" split="true" style="height: 30px; background: #D2E0F2; ">
        <div class="footer">By 4110309-贡欢 Email:1131474643@qq.com</div>
    </div>
    <div region="west" split="true" title="导航菜单" style="width:180px;" id="west">
    <div class="easyui-accordion" fit="true" border="false">
		<!--  导航内容 -->
				
			</div>

    </div>
    <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
			<div title="首页" style="padding:20px;overflow:hidden;" id="home">
				
			<h1>Welcome to jQuery UI!</h1>

			</div>
		</div>
    </div>

    
    
    <div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>
    
</body>
</html>