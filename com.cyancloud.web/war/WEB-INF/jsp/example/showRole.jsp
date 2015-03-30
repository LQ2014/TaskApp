<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<html>
	<head>
		<meta http-equiv="imagetoolbar" content="no" />
		<title><fmt:message key="webapp.name" /></title>
		<link href="${rootUrl}css/common.css" type="text/css" rel="stylesheet" />
		<link href="${rootUrl}css/dtree.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="${rootUrl}js/bottom.js"></script>
		<script language="javascript" src="${rootUrl}js/dtree.js"></script>
		<script type="text/javascript" src="${rootUrl}js/Validator.js"></script>
	</head>
	<body>
		<div class="DataOut">

			<div class="TableOut">
				<table class="dataTable">
					<tr>
						<td class="tdcenter" width="30%">
							<fmt:message key="acl.rolename" />
						</td>
						<td colspan="2" class="tdleft">
							${role.roleName }

						</td>
					</tr>

					<tr>
						<td class="tdcenter" width="30%">
							<fmt:message key="acl.list" />
						</td>
						<td colspan="2">
							${role.list }
						</td>
					</tr>
					<tr>
						<td class="tdcenter" width="30%">
							<fmt:message key="acl.discription" />
						</td>
						<td colspan="2">
							${role.roleDesc }
						</td>
					</tr>
					<tr>
						<td class="tdcenter" width="30%">
							<fmt:message key="acl.owen" />
						</td>
						<td colspan="2">
<script type="text/javascript">
		
		d = new dTree('d');
		d.add(0,-1,'权限列表 ( <a href="javascript: d.openAll();">全部展开</a> | <a href="javascript: d.closeAll();">全部关闭</a> )');
	  
	  <c:forEach var='vo' items='${model}'>
	  	
	  		<c:set var="i" value="0"></c:set>
  			<c:forEach items="${rights }" var="r"> 
  				<c:if test="${vo.rightVO.rightcode==r.rightcode }">
  					<c:set var="i" value="1"></c:set>
  						//alert('${vo.rightVO.parent}');
			  			d.add('${vo.rightVO.rightcode}','${vo.rightVO.parent}','<input id="rights" name="rights" type="checkbox" disabled="true" checked="checked"  value="${vo.rightVO.rightcode}">${vo.rightVO.showname}');
  				</c:if>
  			</c:forEach> 
  			<c:if test="${i==0}">
			  			d.add('${vo.rightVO.rightcode}','${vo.rightVO.parent}','<input id="rights" name="rights" type="checkbox" disabled="true" value="${vo.rightVO.rightcode}">${vo.rightVO.showname}');
  			</c:if>
	  			
		  	<c:forEach var="op" items="${vo.ops}">
		  		<c:set var="j" value="0"></c:set>
				<c:forEach items="${ops }" var="o"> 
	  				<c:if test="${op.rpcode==o.rpcode }">
	  					<c:set var="j" value="1"></c:set>
				  			d.add('${op.rpcode}','${vo.rightVO.rightcode}','<input id="ops" name="ops" type="checkbox" disabled="true" checked="checked" value="${op.rpcode}">${op.opName}','','','','${rootUrl}images/dtree/page.gif');
	  				</c:if>
	  			</c:forEach> 
	  			<c:if test="${j==0}">
				  			d.add('${op.rpcode}','${vo.rightVO.rightcode}','<input id="ops" name="ops" type="checkbox" disabled="true" value="${op.rpcode}">${op.opName}','','','','${rootUrl}images/dtree/page.gif');
	  			</c:if>		  		
		  	</c:forEach>

	  </c:forEach>
	document.write(d);
</script>

						</td>
					</tr>
				</table>
			</div>
			<div id="bottom">
				<input type="button" class="InputButton"
					value="<fmt:message key='return'/>"
					onclick="javascript:window.location.href='${rootUrl }acl/listRole.do';" />
			</div>

		</div>
	</body>
</html>

