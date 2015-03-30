<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<html>
	<head>
		<meta http-equiv="imagetoolbar" content="no" />
		<title><fmt:message key="webapp.name" /></title>
		<link href="${rootUrl}css/common.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="${rootUrl}js/bottom.js"></script>
		<script language="javascript" src="${rootUrl}js/common.js"></script>
		<script type="text/javascript" src="${rootUrl}js/Validator.js"></script>
		<script language="javascript" src="${rootUrl}js/checkSelected.js"></script>
		<script type="text/javascript">
			function checkFormSelect(){
			 var check = checkSelect('ucodes');
			 // alert(check);
			  if(check){
			  	checkSelectedOne('rolecodes','${rootUrl }acl/doAddAuth.do');
			  //	alert('test');
			  	}
			}
		</script>
	</head>
	<body>
		<div class="DataOut">
			<form:form modelAttribute="accountModel" name="listForm"
				action="${rootUrl }acl/addAuth.do" method="post">
				<div class="DataInner">
					<table>

						<tr>
							<td class="tdcenter">
								<fmt:message key="account.dept" />
							</td>
							<td class="tdleft">
								<form:select cssClass="select" path="dcode" id="dcode">
									<form:option value="">
										<fmt:message key="all" />
									</form:option>
									<c:forEach items="${depts}" var="dept">
										<form:option value="${dept.dcode}">
											${dept.deptName}
										</form:option>
									</c:forEach>

								</form:select>
							</td>
							<td class="tdcenter">
								<fmt:message key="account.uname" />
							</td>
							<td class="tdleft">
								<form:input path="uname" id="uname" size="15" maxlength="15"
									cssClass="InputText" />
							</td>
							<td>
								<fmt:message key="account.state" />
							</td>
							<td>
								<form:select id="ustate" path="ustate">
									<form:option value="">
										<fmt:message key="all"></fmt:message>
									</form:option>
									<form:option value="1">
										<fmt:message key="normal" />
									</form:option>
									<form:option value="0">
										<fmt:message key="freezed" />
									</form:option>
									<form:option value="2">
										<fmt:message key="stop" />
									</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<td colspan="6" align="center">
								<input type="button" class="InputButton"
									value="<fmt:message key="search" />"
									onclick="listForm.action='${rootUrl }acl/addAuth.do';listForm.submit();" />
									
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

					<table class="dataTable">
						<tr align="center" valign="top" class="tdTitle">
							<td width="20">
								<input type="checkbox" name="id" onclick="changeAll(this.checked,'ucodes');"/>
							</td>
							<td width="15%">
								<fmt:message key="account.loginname" />
							</td>
							<td width="15%">
								<fmt:message key="account.username" />
							</td>

							<td>
								<fmt:message key="personal.email" />
							</td>
							<td width="15%">
								<fmt:message key="personal.tel" />
							</td>
							<td width="10%">
								<fmt:message key="account.state" />
							</td>
							<td width="15%">
								<fmt:message key="account.ctime" />
							</td>
						</tr>
						<c:set var="i" value="0"></c:set>
						<c:forEach items="${pagn.result}" var="vo" varStatus="status">
							<tr onmouseover="this.bgColor='#f5f5f5'"
								onmouseout="this.bgColor=''">
								<c:set var="i" value="${i+1}"></c:set>
								<td>
									<input type="checkbox" name="ucodes" id="ucodes"
										value="${vo.ucode}" />
								</td>
								<td>
									${vo.loginname}
								</td>
								<td>
									${vo.uname}
								</td>
								<td>
									${vo.email}
								</td>
								<td>
									${vo.tel}
								</td><td>
								
								<c:if test="${vo.ustate==0}">
									

										<fmt:message key="freezed" />
									
								</c:if>
								<c:if test="${vo.ustate==1}">

										<fmt:message key="normal" />
								</c:if>
								<c:if test="${vo.ustate==2}">

										<fmt:message key="stop" />
								</c:if>
								</td>
								

								<td>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.ctime.time}" />
								</td>
							</tr>
						</c:forEach>
						<c:if test="${i>0}">
						<tr>
							<td colspan="2" class="tdcenter">
								选择角色
							</td>
							<td colspan="5">
								<table width="100%" cellpadding="0" cellspacing="0">
								<c:set var="i" value="0"></c:set>								
								<c:forEach items="${roles}" var="role">
									<c:if test="${i==0}">
										<tr>
									</c:if>
									<td><input type="checkbox" name="rolecodes" value="${role.rolecode }"/><c:out value="${role.roleName }"/></td>
									<c:set var="i" value="${i+1}"></c:set>
									<c:if test="${i%4 ==0}">
										</tr>
									</c:if>
								</c:forEach>
								</table>
								
							</td>
						</tr>
						</c:if>
					</table>
					
				</div>

				<div id="delete">
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="5px"></td>
							<td align=left>
								<!-- 
								<select name="rolecode">
									<c:forEach items="${roles}" var="role">
										<option value="${role.rolecode }">
											<c:out value="${role.roleName }"></c:out>
										</option>
									</c:forEach>
								</select>
								 -->
								<input name="add" type="button" class="InputButton"
									onclick="checkFormSelect();"
									value="<fmt:message key='save'/>" />
								&nbsp;
								<input type="button" class="InputButton"
									value="<fmt:message key='return'/>"
									onclick="window.location='${rootUrl }acl/listAuth.do'" />
							</td>
							<td align="right"><%@ include file="/WEB-INF/jsp/page.jsp"%></td>
							<td width="20px"></td>
						</tr>

					</table>

				</div>

			</form:form>
		</div>
	</body>
</html>

