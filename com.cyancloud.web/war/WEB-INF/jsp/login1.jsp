<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String message=(String)request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<title>首页</title>
<head>
		<meta charset="utf-8">
		<title><spring:message code="webapp.name"/> </title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		
		<!-- #CSS Links -->
		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
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
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/add-app-class.css">

		<!-- #FAVICONS -->
		<link rel="shortcut icon" href="${rootUrl}img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="${rootUrl}img/favicon/favicon.ico" type="image/x-icon">
		
		<!-- #APP SCREEN / ICONS -->
		<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="${rootUrl}img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="${rootUrl}img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="${rootUrl}img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="${rootUrl}img/splash/touch-icon-ipad-retina.png">
		
		<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
        <script type="text/javascript">
document.createElement("section");
document.createElement("article");
document.createElement("footer");
document.createElement("header");
document.createElement("hgroup");
document.createElement("nav");
document.createElement("menu");
</script>
        
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/iphone.png" media="screen and (max-device-width: 320px)">
<style>
	body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, dl, dt, dd, ul, ol, li, pre, form, legend, button, input, textarea, th,td { margin:0; padding:0; }
	h1, h2, h3, h4, h5, h6{ font-size:100%; }
	address, cite, dfn, em, var { font-style:normal; }
	code, kbd, pre, samp { font-family:couriernew, courier, monospace; }
	ul,ol { list-style:none; }
	a { text-decoration:none;color:blue; }
	a:hover { text-decoration:underline; }
	legend { color:#000; }
	img { border:0; }
	button, input, select, textarea { font-size:100%; }
	table { border-collapse:collapse; border-spacing:0; } 
	html,body{height:100%;}
	
	#content{margin:0 auto;width:900px;height:100%;}
	section{background:url(${rootUrl}img/adconnecthelp/bg.jpg);height:320px;background-color:lavender;border-radius:10px;-moz-border-radius:10px;padding:30px 30px 0px 30px;}
	header{background-color:parent;height:200px;}
	footer{background-color:parent;height:auto;}
	#login{background-color:rgba(240,240,240,0.9);background-color:#f0f0f0\0;width:350px;height:255px;border-radius:10px;-moz-border-radius:10px;float:right;
	box-shadow:0px 0px 8px #aaa;}
	form{margin:50px 40px;}
	input#btn{color:#fff;width:100px;height:25px;margin:5px 0 5px 65px;-moz-border-radius:3px;border-radius:3px;background-color:#3355dd;border:0px;
	box-shadow:inset 0px 10px 8px rgba(255,255,255,0.5),inset 0px 5px 4px rgba(255,255,255,0.7),0px 0px 5px #33f;}
	input#btn:hover{color:#fff;width:100px;height:25px;margin:5px 0 5px 65px;-moz-border-radius:3px;border-radius:3px;background-color:#3355dd;border:0px;
	box-shadow:inset 0px 10px 8px rgba(255,255,255,0.5);}
	
	#reflection{background:url(${rootUrl}img/adconnecthelp/bg2.jpg);height:36px;
	opacity:0.7; 
	filter:alpha(opacity='70'); 
	-moz-border-radius:5px;border-radius:5px;}
	
	#lay{height:36px;position:relative;bottom:36px;
	background-image: -moz-linear-gradient(center bottom, rgb(255,255,255) 20%, rgba(255,255,255,0) 90%); 
	background-image: -o-linear-gradient(rgba(255,255,255,0) 10%, rgb(255,255,255) 30%); 
	background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0.20, rgb(255,255,255)), color-stop(0.90, rgba(255,255,255,0))); 
	filter: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColor=0, EndColorStr=#000000); 
	-moz-border-radius:5px;border-radius:5px;
	}
</style>
<!--<script type="text/javascript">
function AddFavorite(sURL, sTitle) {   
	console.log(window.external.addFavorite);console.log(sTitle);
	
    try {   
        window.external.addFavorite("baidu.com", "百度");   
    } catch (e) {   
        try {   
            window.sidebar.addPanel("百度", "baidu.com", "");   
        } catch (e) {   
        	console.log(e);
            alert("加入收藏失败，请使用Ctrl+D进行添加");   
        }   
    }  
    return false; 
}
</script>-->
</head>
<body>
<div id="content">
	<header><img src="${rootUrl}img/logo.png" width="200" style="margin-top:30px;" />
	<!-- <a href="javascript:AddFavorite(window.location,document.title);" style="float:right;">【添加到收藏夹】</a> -->
	<div style=" position:absolute; top:165px; right:14px; font-size:24px;">云管理系统</div>
	</header>
	<section><!--<img src="bg2.jpg" />-->
		<div id="login">
			<!--<form action="${rootUrl}login.do">
				<spring:message code="login.username"/>：<input style="margin-left: 12px;width:180px;height:25px;" type="text" name="ucode"/><br />
				<br /><spring:message code="login.password"/>：<input style="margin-left: 25px;width:180px;height:25px;"type="password" name="password" />
				<br />
				<table border="0">
                  <tr>
                    <td><input type="checkbox" style="margin:5px 0 5px 65px"/></td>
                    <td><span style="font-size:0.8em;">记住用户名</span></td>
                  </tr>
                </table>
				<button id="btn" style="color:#fff;width:100px;height:25px;margin:5px 0 5px 65px;-moz-border-radius:3px;border-radius:3px;background-color:#3355dd;border:0px;
box-shadow:inset 0px 10px 8px rgba(255,255,255,0.5),inset 0px 5px 4px rgba(255,255,255,0.7),0px 0px 5px #33f;" type="submit"
			         data-loading-text="登录中..." >
			     <spring:message code="login.sign"/>
			     </button>
				<br />&nbsp;
				<hr style="width:;"/>
				<p style="font-size:0.8em;*margin-top:-18px;"><span style="color:red;">提示:</span>为了达到最佳浏览效果，请使用Chrome、Firefox、IE9.0及以上版本浏览器。</p>
			</form>-->
						
            <form action="${rootUrl}login.do" id="login-form" method="post" class="smart-form client-form">
				<fieldset>
					<label class="label"><spring:message code="login.username"/></label>
					<label class="input mar-b-10"> <i class="icon-append fa fa-user"></i>
					<input type="text" name="ucode"/>
					<b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> 请输入您的用户名</b></label>
					<label class="label"><spring:message code="login.password"/></label>
					<label class="input mar-b-10"> <i class="icon-append fa fa-lock"></i>
					<input type="password" name="password" />
					<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> 
请输入您的密码</b> </label>
					<div class="row" style="margin:0;">
					<div class="col-xs-8" style="padding-top:3px;">
					<label class="checkbox">
					<input type="checkbox" name="remember" checked="checked">
					<i></i>记住用户名</label>
                    </div>
                    <div class="col-xs-4">
                	<button id="btn" type="submit" onclick="javascript:login()" class="btn btn-primary pull-right" style="padding:4px 20px" data-loading-text="登录中..."><spring:message code="login.sign"/></button>
                    </div>
                    </div>
				</fieldset>
				<footer><span class="color-red">提示:</span>为了达到最佳浏览效果，请使用Chrome、Firefox、IE9.0及以上版本浏览器。</footer>
			</form>
		</div>
	</section>
	<div id="reflection" style="display:none">&nbsp;</div>
	<div id="lay" style="display:none"></div>
	<footer></footer>
</div>
<script type="text/javascript">
	window.onload = function(){
		var form = document.getElementById('login-form');
		form.ucode.value =  getCookieValue("ucode");		
		form.password.value = getCookieValue("password");
	}
	
	function login(){			
		var form = document.getElementById('login-form');		
		if(form.remember.checked){
			var day = 7*24;
			var ucode = form.ucode.value;
			var password = form.password.value;
			setCookie("ucode",ucode,day,"/");
       		setCookie("password",password,day,"/");
		}else{
			deleteCookie("ucode","/");
			deleteCookie("password","/");
		}					
		return true;
	}
	
	function setCookie(key,value,hours,path){
		var key = escape(key);
		var value = escape(value);
		var expires = new Date();
		expires.setTime(expires.getTime() + hours*3600000);
		_expires = (typeof hours) == "string" ? "" : ";expires=" + expires.toUTCString();		
		document.cookie = key + "=" + value + _expires + path;
	}
	
	function getCookieValue(key){
		var key = escape(key);
		var allcookies = document.cookie; 		   
		key += "=";
		var pos = allcookies.indexOf(key);    
		if (pos != -1){                                             
	        var start = pos + key.length;                  
	        var end = allcookies.indexOf(";",start);        
	        if (end == -1) end = allcookies.length;       
	        var value = allcookies.substring(start,end); 
	        return unescape(value);                          
         }else 
         	return "";           
	}
	
	function deleteCookie(key,path){	
		setCookie(key,null,0,"/");       		
	}
</script>
</html>