<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.service.model.DataControlBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String message = (String)request.getAttribute("message");
	DataControlBean bean = (DataControlBean)request.getAttribute("detail");
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
						<label>文件名：</label><%=bean.getFileName()%>
					</div>
					<div>
						<label>原因及备注：</label><%=bean.getReason()%>
					</div>
				</fieldset>
    		</div>
			
	</body>
</html>
