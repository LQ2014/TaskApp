<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*,com.cyancloud.model.system.*" pageEncoding="utf-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="rootUrl" scope="application"></c:url>
<c:if test="${fn:contains(rootUrl,';jsession')}">
	<c:set value="${fn:split(rootUrl,';')[0] }" var="rootUrl"
		scope="application" />
</c:if>
<%
String roleType=(String)session.getAttribute("roleType");
String uname=(String)session.getAttribute("ucode");

List<Right> fmenu = (List<Right>)session.getAttribute("fmenu");
List<Right> menus = (List<Right>)session.getAttribute("menus");


String myPage = request.getParameter("page");
if (myPage == null) {
	myPage = "";
}
%>
<!DOCTYPE html>
<script type="text/javascript">
	// AJAX方法, 被自定义封装在该函数中
   			function ajaxFunction(url){
    			var xmlHttp;
    			try {
  					// Firefox, Opera 8.0+, Safari
  					xmlHttp = new XMLHttpRequest();    // 实例化对象
    			} catch(e){
     				// Internet Explorer
					try {
      					xmlHttp = new ActiveXObject( "Msxml2.XMLHTTP" );
     				} catch (e) {
      					try {
       						xmlHttp = new ActiveXObject( "Microsoft.XMLHTTP" );
      					} catch(e) {
       						alert("您的浏览器不支持AJAX！");
							return false;
      					}
     				}
    			}
    			xmlHttp.onreadystatechange = function() {
    				setTimeout(reload,2000);
     				
    			}
    			xmlHttp.open( "GET", url, true );
    			xmlHttp.send( null );
   			}
   			
   			function reload() {
   				location.reload();
   			}
   			
   			function myProfile() {
     			var html ='<div id="dialog-window" title="个人资料"><iframe id="myFrame"src="${rootUrl}myProfile.do" frameBorder="0" style="border: 0; " scrolling="no" class="col-lg-12"  height="100%"></iframe></div>';
			    return $(html).dialog($.extend({
			      modal: true,
			      width:550,
			      height:350,
			      closeOnEscape: false,
			      draggable: true,
			      resizable: true,
			      close: function(event, ui) {
			        $(this).dialog("destroy"); // 关闭时销毁
			      },
			      buttons : [{
					html : "关闭",
					"class" : "btn btn-default",
					click : function() {
						//关闭当前Dialog 
						$(this).dialog("close");
					}
				}]
			      
								      
			    }));
    		}
    		function setCookie(name, value) {  
				var Days = 60; //cookie 将被保存两个月   
				var exp = new Date(); //获得当前时间   
				exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000); //换成毫秒  
				document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
				 
			}  

			function getCookie(name) {  
				//取出cookie   
				var strCookie = document.cookie;  
				//cookie的保存格式是 分号加空格 "; "  
				var arrCookie = strCookie.split("; ");  
				for ( var i = 0; i < arrCookie.length; i++) {  
					var arr = arrCookie[i].split("=");  
					if(name == 'webStyle') {
						if (arr[0] == "webStyle") {  
	    					return arr[1];  
	    				}
					} else if(name == "top") {
						if (arr[0] == "top") {  
	    					return arr[1];  
	    				}
					}
	    			
	     		}  
				return "";  
			}  
			function delCookie(name) {  
				var exp = new Date(); //当前时间   
				exp.setTime(exp.getTime() - 1); //删除cookie 只需将cookie设置为过去的时间    
				var cval = getCookie(name);  
				if (cval != null)  
					document.cookie = name + "=" + cval + ";expires="+ exp.toGMTString();  
			}  
			
    		function onload() {
    			var webStyle = getCookie("webStyle");
    			if(webStyle == '') {
    				//设置cookie  
					setCookie("webStyle", "smart-style-1");  
					webStyle = getCookie("webStyle");
					
    			}
    			var top = getCookie("top");
    			if(top == '') {
    				//设置cookie  
					setCookie("top", "menu-on-top");  
					top = getCookie("top");
    			}
    			if(navigator.appName == 'Microsoft Internet Explorer') {
    				//控制Menu on top是否选中(默认进入系统时)
    				if(top == 'menu-on-top') {
    					"top" == localStorage.getItem("sm-setmenu") ? $("#smart-topmenu").prop("checked", !1) : $("#smart-topmenu").prop("checked", !0);
    				}
    			} else {
    				//控制Menu on top是否选中(默认进入系统时)
    				if(top == 'menu-on-top') {
    					"top" == localStorage.getItem("sm-setmenu") ? $("#smart-topmenu").prop("checked", !1) : $("#smart-topmenu").prop("checked", !0);
    				} else {
    					"top" == localStorage.getItem("sm-setmenu") ? $("#smart-topmenu").prop("checked", !0) : $("#smart-topmenu").prop("checked", !1);
    				}
    			}
    			
    			if(top == 'menu-on-top1') {
    				top = 'menu-on-top';
    			}
    			
    			if(top == 'menu-on-left1') {
    				top = 'menu-on-left1';
    			}
    			document.getElementById('myBody').className = webStyle+' '+top;
    			var tableStyle = 'jarviswidget jarviswidget-color-blueDark';
    			var obj = document.getElementById(webStyle);
    			if(webStyle == 'smart-style-0') {
    				tableStyle = 'jarviswidget jarviswidget-color-darken';
    				if(obj != null) {
    					$("#smart-styles > a #skin-checked").remove(),
						obj.innerHTML="<i class='fa fa-check fa-fw' id='skin-checked'></i>Black";
    				}
    			} else if(webStyle == 'smart-style-1') {
    				tableStyle = 'jarviswidget jarviswidget-color-blueDark';
    				if(obj != null) {
    					$("#smart-styles > a #skin-checked").remove(),
						obj.innerHTML="<i class='fa fa-check fa-fw' id='skin-checked'></i>Blue";
    				}
    			} else if(webStyle == 'smart-style-2') {
    				tableStyle = 'jarviswidget jarviswidget-color-white';
    				if(obj != null) {
    					$("#smart-styles > a #skin-checked").remove(),
						obj.innerHTML="<i class='fa fa-check fa-fw' id='skin-checked'></i>White";
    				}
    			} else if(webStyle == 'smart-style-3') {
    				tableStyle = 'jarviswidget jarviswidget-color-orange';
    				if(obj != null) {
    					$("#smart-styles > a #skin-checked").remove(),
						obj.innerHTML="<i class='fa fa-check fa-fw' id='skin-checked'></i>Orange";
    				}
    				
    			} else if(webStyle == 'smart-style-4') {
    				tableStyle = 'jarviswidget jarviswidget-color-green';
    				if(obj != null) {
    					$("#smart-styles > a #skin-checked").remove(),
						obj.innerHTML="<i class='fa fa-check fa-fw' id='skin-checked'></i>Green";
    				}
    			} else if(webStyle == 'smart-style-5') {
    				tableStyle = 'jarviswidget jarviswidget-color-blue';
    				if(obj != null) {
    					$("#smart-styles > a #skin-checked").remove(),
					obj.innerHTML="<i class='fa fa-check fa-fw' id='skin-checked'></i>Glass";
    				}
    			}
    			if(document.getElementById('myTable') != null) {
    				document.getElementById('myTable').className = tableStyle;
    			}
    			if(document.getElementById('myTable1') != null) {
    				document.getElementById('myTable1').className = tableStyle;
    			}
    			if(document.getElementById('myTable2') != null) {
    				document.getElementById('myTable2').className = tableStyle;
    			}
    			if(document.getElementById('myTable3') != null) {
    				document.getElementById('myTable3').className = tableStyle;
    			}
    			if(document.getElementById('myTable4') != null) {
    				document.getElementById('myTable4').className = tableStyle;
    			}
    			
    		}
</script>
<head>
		<meta charset="utf-8">
		<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

		<title> <spring:message code="webapp.name"></spring:message></title>
		<meta name="description" content="">
		<meta name="author" content="">
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/font-awesome.min.css">
		
		<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-skins.min.css">
		
		<!-- SmartAdmin RTL Support is under construction
			 This RTL CSS will be released in version 1.5
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-rtl.min.css"> -->

		<!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update.
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/your_style.css"> -->

		<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/demo.min.css">

		<!-- FAVICONS -->
		<link rel="shortcut icon" href="${rootUrl}img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="${rootUrl}img/favicon/favicon.ico" type="image/x-icon">

		<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="${rootUrl}img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="${rootUrl}img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="${rootUrl}img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="${rootUrl}img/splash/touch-icon-ipad-retina.png">
		
		<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/iphone.png" media="screen and (max-device-width: 320px)">
		
	</head>
	
	<!--

	TABLE OF CONTENTS.
	
	Use search to find needed section.
	
	===================================================================
	
	|  01. #CSS Links                |  all CSS links and file paths  |
	|  02. #FAVICONS                 |  Favicon links and file paths  |
	|  03. #GOOGLE FONT              |  Google font link              |
	|  04. #APP SCREEN / ICONS       |  app icons, screen backdrops   |
	|  05. #BODY                     |  body tag                      |
	|  06. #HEADER                   |  header tag                    |
	|  07. #PROJECTS                 |  project lists                 |
	|  08. #TOGGLE LAYOUT BUTTONS    |  layout buttons and actions    |
	|  09. #MOBILE                   |  mobile view dropdown          |
	|  10. #SEARCH                   |  search field                  |
	|  11. #NAVIGATION               |  left panel & navigation       |
	|  12. #RIGHT PANEL              |  right panel userlist          |
	|  13. #MAIN PANEL               |  main panel                    |
	|  14. #MAIN CONTENT             |  content holder                |
	|  15. #PAGE FOOTER              |  page footer                   |
	|  16. #SHORTCUT AREA            |  dropdown shortcuts area       |
	|  17. #PLUGINS                  |  all scripts and plugins       |
	
	===================================================================
	
	-->
	
	<!-- #BODY -->
	<!-- Possible Classes

		* 'smart-style-{SKIN#}'
		* 'smart-rtl'         - Switch theme mode to RTL
		* 'menu-on-top'       - Switch to top navigation (no DOM change required)
		* 'no-menu'			  - Hides the menu completely
		* 'hidden-menu'       - Hides the main menu but still accessable by hovering over left edge
		* 'fixed-header'      - Fixes the header
		* 'fixed-navigation'  - Fixes the main menu
		* 'fixed-ribbon'      - Fixes breadcrumb
		* 'fixed-page-footer' - Fixes footer
		* 'container'         - boxed layout mode (non-responsive: will not work with fixed-navigation & fixed-ribbon)
	-->
<!-- HEADER -->
<header id="header">
<div id="logo-group">
	<!-- PLACE YOUR LOGO HERE -->
	<span id="logo"> <img src="${rootUrl }img/logo.png"
			alt="SmartAdmin">
	</span>
	<span id="logo_title"> <img src="${rootUrl }img/logo_title.png"
			alt="SmartAdmin">
	</span>
	<!-- END LOGO PLACEHOLDER -->
	<!-- Note: The activity badge color changes when clicked and resets the number to 0
				Suggestion: You may want to set a flag when this happens to tick off all checked messages / notifications -->
				<!-- 
				<span id="activity" class="activity-dropdown"> <i class="fa fa-user"></i> <b class="badge"> 21 </b> </span>
				<div class="ajax-dropdown">

					<div class="btn-group btn-group-justified" data-toggle="buttons">
						<label class="btn btn-default">
							<input type="radio" name="activity" id="ajax/notify/mail.html">
							Msgs (14) </label>
						<label class="btn btn-default">
							<input type="radio" name="activity" id="ajax/notify/notifications.html">
							notify (3) </label>
						<label class="btn btn-default">
							<input type="radio" name="activity" id="ajax/notify/tasks.html">
							Tasks (4) </label>
					</div>
					 -->
					<!-- notification content 
					<div class="ajax-notifications custom-scroll">

						<div class="alert alert-transparent">
							<h4>Click a button to show messages here</h4>
							This blank page message helps protect your privacy, or you can show the first message here automatically.
						</div>

						<i class="fa fa-lock fa-4x fa-border"></i>

					</div>
					 end notification content -->

					<!-- footer: refresh area 
					<span> Last updated on: 12/12/2013 9:43AM
						<button type="button" data-loading-text="<i class='fa fa-refresh fa-spin'></i> Loading..." class="btn btn-xs btn-default pull-right">
							<i class="fa fa-refresh"></i>
						</button> </span>
					 end footer -->
				<!--	
				</div>
				-->
</div>

	<!-- pulled right: nav area -->
			<div class="pull-right">
				
				<!-- collapse menu button -->
				<div id="hide-menu" class="btn-header pull-right">
					<span> <a href="javascript:void(0);" data-action="toggleMenu" title="隐藏菜单"><i class="fa fa-reorder"></i></a> </span>
				</div>
				<!-- end collapse menu -->
				
				<!-- #MOBILE -->
				<!-- Top menu profile link : this shows only when top menu is active -->
				<ul id="mobile-profile-img" class="header-dropdown-list hidden-xs padding-5">
					<li class="">
						<a href="#" class="dropdown-toggle no-margin userdropdown" data-toggle="dropdown"> 
							<img src="${rootUrl }img/user.png" alt="John Doe" class="online" />
						</a>
						<ul class="dropdown-menu pull-right">
							<!--<li>
								<a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0"><i class="fa fa-cog"></i>	设置</a>
							</li>
							<li class="divider"></li>-->
							<li>
								<a href="#" onclick="myProfile();" class="padding-10 padding-top-0 padding-bottom-0"> <i class="fa fa-user"></i>	个人资料</a>
							</li>
							<!--<li class="divider"></li>
							<li>
								<a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" data-action="toggleShortcut"><i class="fa fa-arrow-down"></i>	我的快捷</a>
							</li>-->
							<li class="divider"></li>
							<li>
								<a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" data-action="launchFullscreen"><i class="fa fa-arrows-alt"></i>	全屏</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="${rootUrl}logout.do" class="padding-10 padding-top-5 padding-bottom-5" data-action="userLogout"><i class="fa fa-sign-out fa-lg"></i>	<strong>注销</strong></a>
							</li>
						</ul>
					</li>
				</ul>

				<!-- logout button -->
				<div id="logout" class="btn-header transparent pull-right">
					<span> <a href="${rootUrl}logout.do" title="退出" data-action="userLogout" data-logout-msg=""><i class="fa fa-sign-out"></i></a> </span>
				</div>
				<!-- end logout button -->

				<!-- search mobile button (this is hidden till mobile view port) -->
				<div id="search-mobile" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0)" title="Search"><i class="fa fa-search"></i></a> </span>
				</div>
				<!-- end search mobile button -->

				<!-- fullscreen button -->
				<!--<div id="fullscreen" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0);"  data-action="toggleShortcut" title="我的快捷"><i class="fa fa-arrow-down"></i></a> </span>
				</div>-->
				<!-- end fullscreen button -->

			</div>
			<!-- end pulled right: nav area -->

</header>
<!-- END HEADER -->

<!-- Left panel : Navigation area -->
<!-- Note: This width of the aside area can be adjusted through LESS variables -->
<aside id="left-panel">

			<!-- User info -->
			<div class="login-info">
				<span> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
					<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
						<img src="${rootUrl }img/user.png" alt="me" class="online" /> 
						<span>
							<%=uname%>
						</span>
						<i class="fa fa-angle-down"></i>
					</a> 
					
				</span>
			</div>
			<!-- end user info -->

<!-- NAVIGATION : This navigation is also responsive

			To make this navigation dynamic please make sure to link the node
			(the reference to the nav > ul) after page load. Or the navigation
			will not initialize.
			-->
			<nav>
				<!-- NOTE: Notice the gaps after each icon usage <i></i>..
				Please note that these links work a bit different than
				traditional href="" links. See documentation for details.
				-->


<ul>
	<%
		if (myPage.equals("index")) {
	%>
	<li class="active">
		<%
			} else {
		%>
		<li>
			<%
				}
			%>
			<a href="${rootUrl }index.do" title="首页"><i
				class="fa fa-lg fa-fw fa-home"></i> <span class="menu-item-parent">首页</span>
			</a>
		</li>
		<%
			for(int i=0;i<fmenu.size();i++){
			Right menu = fmenu.get(i);
		%>	
		<li>
			<%
			if(menu.getCode()!=null && menu.getCode().length()>1){
				if(menu.getCode().toLowerCase().indexOf("http")>=0){
				%>
					<a href="<%=menu.getCode() %>" target="_blank">
				<%}else{
				 %><a href="${rootUrl }<%=menu.getCode() %>.do">
				<%
				}
			}else{
			 %>
			 <a href="#">
			 <%
			}
			 %>
			<i class="<%=menu.getCss() %>"></i> <span
				class="menu-item-parent"><%=menu.getName() %></span> </a>
			<ul>
				<%
					for(int j=0;j<menus.size();j++){
						Right r = menus.get(j);
						if(r.getParentId()!=null && r.getParentId().intValue()==menu.getId().intValue()){
					if (myPage.equals(r.getCode())) {
				%>
				<li class="active">
					<%
						} else {
					%>
					<li>
						<%
							}
						%>
						<%
							
							if(r.getCode().toLowerCase().indexOf("http")>-1){
						%>
						<a href="<%=r.getCode() %>" target="_blank"><%=r.getName() %></a>
						<%
							}else{
						%>
						<a href="${rootUrl }<%=r.getCode() %>.do"><%=r.getName() %></a>
						<%
							}
						%>
					</li>
				<%	}
				}
		 %>
			</ul>
		</li>
		
		<%	}
		 %>
		
</ul>
</nav> <span class="minifyme" data-action="minifyMenu"> <i
	class="fa fa-arrow-circle-left hit"></i> </span> 
	</aside>
<!-- END NAVIGATION -->
<!-- PAGE FOOTER -->
<div class="page-footer">
	<div class="row">
		<div class="col-xs-12 col-sm-6">
			<span class="txt-color-white"><spring:message code="copyright"></spring:message></span>
		</div>

	</div>
</div>
<!-- END PAGE FOOTER -->
<!-- SHORTCUT AREA : With large tiles (activated via clicking user name tag)
		Note: These tiles are completely responsive,
		you can add as many as you like
		-->
<div id="shortcut">
	<ul>
		<li>
			<a href="${rootUrl }self/desktop.do"
				class="jarvismetro-tile big-cubes bg-color-orangeDark"> <span
				class="iconbox"> <i class="fa fa-calendar fa-4x"></i> <span>我的桌面<span
						class="label pull-right bg-color-darken"></span> </span> </span> </a>
		</li>
		<li>
			<a href="${rootUrl }self/todo.do"
				class="jarvismetro-tile big-cubes bg-color-purple"> <span
				class="iconbox"> <i class="fa fa-book fa-4x"></i> <span>我的待办<span
						class="label pull-right bg-color-darken"></span> </span> </span> </a>
		</li>
		<li>
			<a href="${rootUrl }order/apply.do"
				class="jarvismetro-tile big-cubes bg-color-blue"> <span
				class="iconbox"> <i class="fa fa-envelope fa-4x"></i><span>桌面申请</span>
			</span> </a>
		</li>
		<li>
			<a href="${rootUrl }order/delayApply.do"
				class="jarvismetro-tile big-cubes bg-color-blue"> <span
				class="iconbox"> <i class="fa fa-envelope fa-4x"></i><span>桌面延期</span>
			</span> </a>
		</li>

	</ul>
</div>
<!-- END SHORTCUT AREA -->

<!-- Your GOOGLE ANALYTICS CODE Below -->
<!--<script type="text/javascript">
			var _gaq = _gaq || [];
				_gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);
				_gaq.push(['_trackPageview']);
			
			(function() {
				var ga = document.createElement('script');
				ga.type = 'text/javascript';
				ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0];
				s.parentNode.insertBefore(ga, s);
			})();

		</script>-->
