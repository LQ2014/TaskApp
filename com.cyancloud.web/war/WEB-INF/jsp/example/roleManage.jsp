<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<html>
	<head>
		<meta http-equiv="imagetoolbar" content="no" />
		<title><fmt:message key="webapp.name" />
		</title>
		<link href="${rootUrl}css/common.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="${rootUrl}js/bottom.js"></script>
		<script language="javascript" src="${rootUrl}js/checkSelected.js"></script>
	</head>

	<body>
		<%@ include file="/WEB-INF/jsp/message.jsp"%>

		<form action="${rootUrl}acl/listRole.do" name="listForm">
			<div class="DataOut">
				<div class="TableOut">
					<table cellpadding="0" class="dataTable">
						<tr class="tdTitle">
							<td width="20">
								<input type="checkbox" name="id"
									onclick="changeAll(this.checked,'codes');" />
							</td>
							<td width="30%">
								<fmt:message key="acl.rolename" />
							</td>
							<td>
								<fmt:message key="acl.discription" />
							</td>

							<td width="30">
								<fmt:message key="operation" />
							</td>
						</tr>
						<c:forEach items="${pagn.result}" var="vo">
							<tr onmouseover="this.bgColor='#f5f5f5'"
								onmouseout="this.bgColor=''">
								<td>
									<c:if test="${vo.deletePermit}">
									<input type="checkbox" name="codes" value="${vo.rolecode}" />
									</c:if>
								</td>
								<td>
									<a href="${rootUrl }acl/showRole.do?rolecode=${vo.rolecode}"><c:out
											value="${vo.roleName}"></c:out> </a>
								</td>
								<td>
									<c:out value="${vo.roleDesc}"></c:out>
								</td>
								<!-- 
								<td>
									<c:out value="${vo.list}"></c:out>
								</td>
								
								<td>
									<c:out value="${vo.ucode}"></c:out>
								</td>
								<td>
									<fmt:formatDate value="${vo.ctime.time}" type="Date"
										pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								 -->
								<td>
									<a href="${rootUrl }acl/modRole.do?rolecode=${vo.rolecode}"><fmt:message
											key="modify" /> </a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div id="delete">

					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="5px"></td>
							<td align=left>
								<taiji:permission url="acl/delRole.do">
									<input class="InputButton" name="delete" type="button"
										value="<fmt:message key='delete'/>"
										onclick="checkSelectedOne('codes','${rootUrl}acl/delRole.do')" />
								</taiji:permission>

								<taiji:permission url="acl/addRole.do">
									<input name="add" type="button" class="InputButton"
										value="<fmt:message key="add"/>"
										onclick="window.location='${rootUrl }acl/addRole.do'" />
								</taiji:permission>
							</td>
							<td align=right><%@ include file="/WEB-INF/jsp/page.jsp"%></td>
							<td width="20px"></td>
						</tr>

					</table>

				</div>
				<div id="delete">


				</div>
			</div>
		</form>
	</body>
</html>

