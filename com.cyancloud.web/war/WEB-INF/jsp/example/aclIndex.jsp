<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<html>
	<head>
		<meta http-equiv="imagetoolbar" content="no" />
		<title><fmt:message key="webapp.name" /></title>
		<link href="${rootUrl}css/common.css" type="text/css" rel="stylesheet" />
		<script src="${rootUrl}js/common.js" language="javascript"></script>

	</head>
	<body>

		<div id="PageTop">
			<div id="PageTopMsg">
				<taiji:location url="acl/aclIndex.do"></taiji:location>
			</div>
		</div>
		<div class="Padding12">
			<div id="Tabs">
				<ul class="left" id="tab">
					<taiji:permission url="acl/listRole.do">
						<li onclick="secBoard(0);" class="Hover" id="card0">
							<a href="${rootUrl}acl/listRole.do" target="workarea"><fmt:message
									key="title.acl.role" /> </a>
						</li>
					</taiji:permission>
					<!-- 	<taiji:permission url="acl/listRight.do">
					<li onclick="secBoard(1);" id="card1">
						<a href="${rootUrl}acl/listRight.do" target="workarea"><fmt:message
								key="title.acl.right" /> </a>
					</li>
					</taiji:permission>
					<taiji:permission url="acl/listRightOp.do">
					<li onclick="secBoard(2);" id="card2">
						<a href="${rootUrl}acl/listRightOp.do" target="workarea"><fmt:message
								key="title.acl.rightop" /> </a>
					</li>
					</taiji:permission>
			 -->
					<taiji:permission url="acl/listAuth.do">
						<li onclick="secBoard(1);" id="card1">
							<a href="${rootUrl}acl/listAuth.do" target="workarea"><fmt:message
									key="title.acl.auth" /> </a>
						</li>
					</taiji:permission>
				</ul>
			</div>
			<taiji:permission url="acl/listRole.do">
			<div>
				<iframe name="workarea" marginwidth=0 marginheight=0 frameborder=0
					src="${rootUrl }acl/listRole.do" width=100% scrolling=auto
					onLoad="this.height=workarea.document.body.scrollHeight">
				</iframe>
			</div>
			</taiji:permission>
		</div>
	</body>
</html>
