<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<html>
	<head>
		<title><fmt:message key="webapp.name" /></title>
		<link href="${rootUrl}css/common.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="${rootUrl}js/checkSelected.js"></script>
		<script language="javascript" src="${rootUrl}js/common.js"></script>
		<script language="javascript" src="${rootUrl}js/bottom.js"></script>
	</head>

	<body>
	<%@ include file="/WEB-INF/jsp/message.jsp" %>

	<div class="DataOut">
		<form action="${rootUrl }acl/listAuth.do" method="post" name="listForm" >
			<div class="DataInner">
					<table class="dataTable">
					<tr>
							<td class="tdcenter" width="20%">
								<fmt:message key="acl.rolename" />
							</td>
							<td class="tdleft">
								<select class="select" name="rolecode" id="rolecode">
									<option value="" selected="selected">
										<fmt:message key="all" />
									</option>
									<c:forEach items="${roles}" var="role">
										
										<option value="${role.rolecode}"
										<c:if test="${role.rolecode == auth.rolecode}">
												selected="selected"
										</c:if>
										>
										${role.roleName}
										</option>
										
										
									</c:forEach>

								</select>
							</td>
						
							<td class="tdcenter" width="20%">
								<fmt:message key="account.uname" />
							</td>
							<td class="tdleft">
								<input name="uname" id="uname" type="text" size="15"
									class="InputText" value="${auth.uname }"/>
							</td>
							</tr>
						<tr>
							
							<td colspan="4" class="tdcenter">
								<input type="submit" class="InputButton"
									value="<fmt:message key="search" />"/>
									
									<input type="button" value="<fmt:message key="reset" />"  class="InputButton" onclick="myReset();" />
							</td>
						</tr>
					</table>
				</div>
<table width="100%" cellpadding="0" cellspacing="0">
					<tr>
					<td height="5">
					</td>
					</tr></table>	
		
		
			
			
				<div class="TableOut">
					<table cellpadding="0" class="dataTable">
						<tr class="tdTitle">
							<td width="20">
								<input type="checkbox" name="id" onclick="changeAll(this.checked,'ids');"/>
							</td>
							 
							<td width="25%">
								<fmt:message key="account.loginname" />
							</td>
							<!--
						 	<td width="25%">
								<fmt:message key="acl.loginname" />
							</td>
						 	-->
							<td width="25%">
								<fmt:message key="acl.uname" />
							</td>
							
							<td width="25%">
								<fmt:message key="account.dept" />
							</td>
							
							<td>
								<fmt:message key="acl.rolename" />
							</td>
						</tr>
						<c:forEach items="${pagn.result}" var="vo">

							<tr onmouseover="this.bgColor='#f5f5f5'"
								onmouseout="this.bgColor=''">
								<td>
									<input type="checkbox" name="ids" value="${vo.id }"/>
								</td>
								
								<td>
									<c:out value="${vo.loginname}"></c:out>
								</td>
								
								<td>
									<c:out value="${vo.uname}"></c:out>
								</td>
								<td>
									<c:out value="${vo.dname}"></c:out>
								</td>
								<td>
									<c:out value="${vo.roleName}"></c:out>
								</td>
							</tr>
						</c:forEach>
					</table>

				</div>
				<!-- 
				<div id="delete">
					<taiji:permission url="acl/delAuth.do">
						<input name="Submit2" class="InputButton" type="button"
							value="<fmt:message key="delete"/>" 
							onclick="checkSelectedOne('ids','${rootUrl }acl/delAuth.do')"
							/>
					</taiji:permission>
					<taiji:permission url="acl/addAuth.do">
						<input name="Submit2" class="InputButton" type="button"
							value="<fmt:message key="add"/>"
							onclick="window.location='${rootUrl }acl/addAuth.do'" />
					</taiji:permission>
					
				</div>
				 -->
				<div id="delete">
				
				 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
			  <tr><td  width="5px"></td><td align=left>
					
					<taiji:permission url="acl/delAuth.do">
						<input name="Submit2" class="InputButton" type="button"
							value="<fmt:message key="delete"/>" 
							onclick="checkSelectedOne('ids','${rootUrl }acl/delAuth.do')"
							/>
					</taiji:permission>
					<taiji:permission url="acl/addAuth.do">
						<input name="Submit2" class="InputButton" type="button"
							value="<fmt:message key="add"/>"
							onclick="window.location='${rootUrl }acl/addAuth.do'" />
					</taiji:permission>
						</td>
						<td align=right><%@ include file="/WEB-INF/jsp/page.jsp"%></td>
				<td width="20px"></td>
				</tr>
				
				</table>
					
				</div>
			
		</form>
		</div>
	</body>
</html>

