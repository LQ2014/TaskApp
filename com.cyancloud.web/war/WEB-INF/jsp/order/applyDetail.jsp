<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.service.model.DesktopApplyBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String message = (String)request.getAttribute("message");
	DesktopApplyBean bean = (DesktopApplyBean)request.getAttribute("detail");
	String life = bean.getLife();
	if(life != null) {
		if(life.equals("3")) {
			life = "三个月";
		} else if(life.equals("6")) {
			life = "半年";
		} else if(life.equals("12")) {
			life = "一年";
		} else if(life.equals("24")) {
			life = "两年";
		}
	} else {
		life = "";
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
    			<form id="myForm"  name="myForm" class="form-horizontal">
    			<fieldset>
					<div>
						<label>申请人：&nbsp;&nbsp;&nbsp;</label><%=bean.getUcode()%>
					</div>
					<div>
						<label>申请部门：</label><%=bean.getUnitName()%>
					</div>
					<div>
						<label>桌面池：&nbsp;&nbsp;&nbsp;</label><%=bean.getPoolName()%>
					</div>
					<div>
						<label>CPU：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><%=bean.getCpu()%>
					</div>
					<div>
						<label>内存(GB)：</label><%=bean.getMemory()%>
					</div>
					<div>
						<label>硬盘(GB)：</label><%=bean.getCapacity()%>
					</div>
					<div>
						<label>使用期限：</label><%=life%>
					</div>
					<div>
						<label>预装软件：</label><%=bean.getDesc()%>
					</div>
					<div>
						<label>申请用途：</label><%=bean.getReason()%>
					</div>
					<%if(bean.getRejectReason() != null && !bean.getRejectReason().equals("")) {%>
						<div>
							<label>退回时间：</label><%=bean.getRejectDate()%>
						</div>
						<div>
							<label>退回意见：</label><%=bean.getRejectReason()%>
						</div>
					<%}%>
				</fieldset>
    		</form>
			
	</body>
</html>
