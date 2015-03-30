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
	String instId = request.getParameter("instId");
%>

<!DOCTYPE html>
<html lang="en-us">
	<head>
<script type="text/javascript">
	
	function hide(){
		document.getElementById('none-close').style.display = "none"
	}
</script>
	
	</head>
	<body style="padding:0; margin:0;">
    	<iframe width="100%" height="100%" scrolling="no" frameborder="no" border="0" allowtransparency="true" src="${rootUrl}/vm/connectVM.do?instId=<%=instId %>"></iframe>
		<div id="none-close" style="position:absolute; top:0; left:0; bottom:0; right:0; background:rgba(0,0,0,0.5); z-index:99999999; text-align:center; color:#F00; font-size:24px;"><a href="javascript:hide()" style="text-decoration:none;width: 100%; height: 100%; line-height:500px; display:block;">按“Ctrl”+“Alt”+"Enter"可以全屏和退出全屏，按“Ctrl”+“Alt”可以释放鼠标</a></div>

	</body>

</html>
