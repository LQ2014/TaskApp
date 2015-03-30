<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.service.model.DesktopBackoutBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String message = (String)request.getAttribute("message");
	DesktopBackoutBean bean = (DesktopBackoutBean)request.getAttribute("detail");
	String expireTime = "";
	if(bean.getExpireTime() != null && !bean.getExpireTime().equals("")) {
		expireTime = bean.getExpireTime().toString();
		expireTime = expireTime.substring(0,10);
	}
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
		<script type="text/javascript" language="javascript">
			function onload() {
				var msg = '<%=message%>';
				if(msg != '') {
					alert(msg);
				}
			}
		</script>
	</head>
	<body onload="onload();">
    		<div>
    			<fieldset>
					<div>
						<label>申请人：&nbsp;&nbsp;&nbsp;</label><%=bean.getUcode()%>
					</div>
					<div>
						<label>申请部门：</label><%=bean.getUnitName()%>
					</div>
					<div>
						<label>桌面：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><%=bean.getDesktopName()%>
					</div>
					<div>
						<label>CPU：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><%=bean.getCpu()%>
					</div>
					<div>
						<label>内存(GB)：</label><%=bean.getMemory()%>
					</div>
					<div>
						<label>到期时间：</label><%=expireTime%>
					</div>
					<div>
						<label>撤销原因：</label><%=bean.getReason()%>
					</div>
				</fieldset>
    		</div>
			
	</body>
</html>
