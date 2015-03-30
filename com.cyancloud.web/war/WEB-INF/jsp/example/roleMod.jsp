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
		<script type="text/javascript" src="${rootUrl}js/Validator.js"></script>
		<script type="text/javascript" src="${rootUrl}js/dtree.js"></script>
		<script type="text/javascript">
function checkAll() {
	noNullText('roleName','roleNameNote','${rootUrl}','<fmt:message key="noNull"/>');
	noteNullInteger('list','listNote','${rootUrl}','<fmt:message key="notInteger"/>');
	var array = new Array('roleNameNote','listNote');
	if(forArrayNote(array)) {
		myForm.submit();
	}else {
		return false;
	}
}

function selectCasCade(nid,value) {
	//var value = document.getElementById(nid).checked=true;
	if(value){
		selectParent(nid);
	}
	for (var n=0; n<d.aNodes.length; n++){
		if(d.aNodes[n].pid==nid){
			if(value){
				document.getElementById(d.aNodes[n].id).checked=true;
				
				selectCasCade(d.aNodes[n].id,value);
			}else{
				document.getElementById(d.aNodes[n].id).checked=false;
				selectCasCade(d.aNodes[n].id,value);
			}
		
		}
	}
}
function selectParent(nid) {
	
	for (var n=0; n<d.aNodes.length; n++){
		if(d.aNodes[n].id==nid && d.aNodes[n].pid!= "0"){
			document.getElementById(d.aNodes[n].pid).checked=true;
			selectParent(d.aNodes[n].pid);
		}
	}
}
</script>
	</head>
	<body>
		<div class="DataOut">

			<form name="myForm" action="${rootUrl }acl/doModRole.do"
				method="post">
			<input type="hidden" name="deletePermit" value="${role.deletePermit}"/>
				<div class="TableOut">
					<input type="hidden" name="rolecode" value="${role.rolecode }" />
					<input type="hidden" name="type" value="${role.type }" />
					<table class="dataTable">
						<tr>
							<td class="tdcenter" width="30%">
									<fmt:message key="acl.rolename" />
							</td>
							<td colspan="2" class="tdleft">
								<input size="20" maxlength="20" type="text" class="InputText" name="roleName"
									id="roleName" value="${role.roleName }" />
								<label id="roleNameNote">
									<fmt:message key="required" />
								</label>
							</td>
						</tr>

						<tr>
							<td class="tdcenter" width="30%">
									<fmt:message key="acl.list" />
							</td>
							<td colspan="2">
								<input size="20" maxlength="5" type="text" class="InputText" name="list"
									value="${role.list }" onblur="noteNullInteger('list','listNote','${rootUrl}','<fmt:message key="notInteger"/>')"/><label id="listNote"></label>
							</td>
						</tr>
						<tr>
							<td class="tdcenter" width="30%">
									<fmt:message key="acl.discription" />
							</td>
							<td colspan="2">
								<input size="40" maxlength="100" type="text" class="InputText" name="roleDesc"
									value="${role.roleDesc }" />
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
			  			d.add('${vo.rightVO.rightcode}','${vo.rightVO.parent}','<input id="${vo.rightVO.rightcode}" name="rights" type="checkbox" checked="checked"  value="${vo.rightVO.rightcode}" onclick="selectCasCade(\'${vo.rightVO.rightcode}\',this.checked)">${vo.rightVO.showname}');
  				</c:if>
  			</c:forEach> 
  			<c:if test="${i==0}">
			  			d.add('${vo.rightVO.rightcode}','${vo.rightVO.parent}','<input id="${vo.rightVO.rightcode}" name="rights" type="checkbox" value="${vo.rightVO.rightcode}"  onclick="selectCasCade(\'${vo.rightVO.rightcode}\',this.checked)">${vo.rightVO.showname}');
  			</c:if>
	  			
		  	<c:forEach var="op" items="${vo.ops}">
		  		<c:set var="j" value="0"></c:set>
				<c:forEach items="${ops }" var="o"> 
	  				<c:if test="${op.rpcode==o.rpcode }">
	  					<c:set var="j" value="1"></c:set>
				  			d.add('${op.rpcode}','${vo.rightVO.rightcode}','<input id="${op.rpcode}" name="ops" type="checkbox" checked="checked" value="${op.rpcode}" onclick="selectCasCade(\'${op.rpcode}\',this.checked)">${op.opName}','','','','${rootUrl}images/dtree/page.gif');
	  				</c:if>
	  			</c:forEach> 
	  			<c:if test="${j==0}">
				  			d.add('${op.rpcode}','${vo.rightVO.rightcode}','<input id="${op.rpcode}" name="ops" type="checkbox" value="${op.rpcode}" onclick="selectCasCade(\'${op.rpcode}\',this.checked)">${op.opName}','','','','${rootUrl}images/dtree/page.gif');
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
					<input name="add" type="button" class="InputButton"
						onclick="checkAll()" value="<fmt:message key='save'/>"/>
					&nbsp;
					<input type="button" class="InputButton"
						value="<fmt:message key='return'/>"
						onclick="javascript:window.location.href='listRole.do';" />
				</div>
			</form>

		</div>
	</body>
</html>

