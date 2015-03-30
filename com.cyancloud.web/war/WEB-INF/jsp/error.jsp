<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="imagetoolbar" content="no" />
		<link href="${rootUrl}css/common.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="${rootUrl}js/common.js"></script>
	</head>
	<body>
		<div class="TextAlignCenter">
			<div id="alertBox">
				<div id="BoxTitle">
					<div id="BoxTitleLeft">
						<span><fmt:message key="title.error" /> </span>
					</div>
					<div id="BoxTitleRight"></div>
				</div>
				<div id="BoxContent">
					<c:if test="${empty error}">
						<fmt:message key="error" />
					</c:if>
					
					<c:if test="${not empty error}">
						${error}
						<c:remove var="error" />
					</c:if>
					
					
				</div>
			</div>
		</div>
	</body>
</html>
