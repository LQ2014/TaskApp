<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String userCode = (String)request.getAttribute("userCode");
	String userName = (String)request.getAttribute("userName");
	String unitName = (String)request.getAttribute("unitName");
	String roleName = (String)request.getAttribute("roleName");
	String phone = (String)request.getAttribute("phone");
	String email = (String)request.getAttribute("email");
%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
    	<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen"
			href="${rootUrl}css/bootstrap.min.css">
		

		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
		
		<link rel="stylesheet" type="text/css" media="screen"
			href="${rootUrl}css/smartadmin-skins.min.css">
		<!-- SmartAdmin RTL Support is under construction
			 This RTL CSS will be released in version 1.5
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-rtl.min.css"> -->
		<style type="text/css">
		<!--
			#left {
 				float: left;
 				height: 400px;
 				width: 100px;
 				//border: 1px solid #00FF00;
			}
			#right {
 				float: right;
 				height: 400px;
 				width:  300px;
 				//border: 1px solid #0000FF;
			}
			.left_div {
 				border: 1px solid #999999;
			}
		-->
		</style>

	</head>
	<body>
 			<div id="left">
     			<img src="${rootUrl}img/user.png" style="height: 152px; width: 152px; ">
    		</div>
    		<div id="right">
    			<fieldset>
					<div class="form-group">
						<label>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</label><%=userCode%>
					</div>
					<div class="form-group">
						<label>中&nbsp;&nbsp;文&nbsp;&nbsp;名：</label><%=userName%>
					</div>
					<div class="form-group">
						<label>部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门：</label><%=unitName%>
					</div>
					<div class="form-group">
						<label>角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label><%=roleName%>
					</div>
					<div class="form-group">
						<label>联系电话：</label><%=phone%>
					</div>
					<div class="form-group">
						<label>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</label><%=email%>
					</div>
				</fieldset>
    		</div>
			
	</body>
</html>
