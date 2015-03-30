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
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/demo.min.css">

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
		
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/iphone.png" media="screen and (max-device-width: 320px)">
<style>
		
		
		</style>
	</head>
	
	<body style="background:url(${rootUrl}img/adconnecthelp/Q0.jpg);background-repeat: repeat-x;background-size:100% 100%;">
		<header>
			<div>
				<span id="logo"> <img src="img/logo.png"> </span>
			</div>
		</header>
		<div id="main" role="main" style="margin-left:0px; margin-top:100px;">

			<!-- MAIN CONTENT -->
			<div id="content" class="container" >
					<div class="pull-left" style="margin-top:5%;margin-left:5%; width:40%;"><img style="width:100%;"src="${rootUrl}img/adconnecthelp/pic_logo.png;"></div>
					<div  class="pull-right" style="width:35%;margin-right:6%;">
						<div  style="border:none;">
							<form action="${rootUrl}login.do" id="login-form" method="post" class="smart-form client-form">
								<!-- <header >
									
								</header> -->

								<fieldset  style="height:250px;background:url(${rootUrl}img/adconnecthelp/login.jpg);background-repeat: repeat-x;background-size:100% 100%;">
									<section class="form-group">
										<h1 style="color:white" ><spring:message code="login.title"/><% if(message!=null && message.length()>0){%><fmt:message key="${message }"></fmt:message><%} %></h1>
									</section>
									<section class="form-group">
										<label class="label" style="color:white"><spring:message code="login.username"/></label>
										<label class="input"> <i class="icon-append fa fa-user"></i>
											<input type="ucode" name="ucode" value="">
											<b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i><spring:message code="login.username.tips"/> </b></label>
									</section>

									<section class="form-group">
										<label class="label" style="color:white"><spring:message code="login.password"/></label>
										<label class="input"> <i class="icon-append fa fa-lock"></i>
											<input type="password" name="password" value="">
											<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> <spring:message code="login.password.tips"/></b> </label>
										
									</section>
									<section class="form-group">
										<button style="color:white;margin-left:35%;width:30%;border:none;height: 45px;background-color:rgb(108,172,174);"type="submit"
			                                    data-loading-text="登录中..." >
			                                    <spring:message code="login.sign"/>
			                            </button>
									</section>
								</fieldset>
								<%-- <footer>
									<button class="btn btn-success btn-lg btn-block" style="height: 45px;"type="submit"
		                                    data-loading-text="登录中..." >
		                                    <spring:message code="login.sign"/>
		                            </button>
								</footer> --%>
							</form>

						</div>
						
					</div>
				</div>
			</div>


		<!--================================================== -->	

	    <!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
	    <script src="${rootUrl}js/libs/jquery-2.1.1.min.js"></script>

	    <script src="${rootUrl}js/libs/jquery-ui-1.10.3.min.js"></script>

		<!-- JS TOUCH : include this plugin for mobile drag / drop touch events 		
		<script src="${rootUrl}js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script> -->

		<!-- BOOTSTRAP JS -->		
		<script src="${rootUrl}js/bootstrap/bootstrap.min.js"></script>

		<!-- JQUERY VALIDATE -->
		<script src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>
		
		<!-- JQUERY MASKED INPUT -->
		<script src="${rootUrl}js/plugin/masked-input/jquery.maskedinput.min.js"></script>
		
		<!--[if IE 8]>
			
			<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
			
		<![endif]-->

		<!-- MAIN APP JS FILE -->
		<script src="${rootUrl}js/app.min.js"></script>

		<script type="text/javascript">
			runAllForms();

			$(function() {
				// Validation
				$("#login-form").validate({
					// Rules for form validation
					rules : {
						email : {
							required : true,
							email : true
						},
						password : {
							required : true,
							minlength : 3,
							maxlength : 20
						}
					},

					// Messages for form validation
					messages : {
						email : {
							required : 'Please enter your email address',
							email : 'Please enter a VALID email address'
						},
						password : {
							required : 'Please enter your password'
						}
					},

					// Do not change code below
					errorPlacement : function(error, element) {
						error.insertAfter(element.parent());
					}
				});
			});
		</script>

	</body>
</html>