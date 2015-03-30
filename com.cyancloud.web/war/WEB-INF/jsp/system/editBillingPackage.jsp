<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*,java.lang.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.vm.VMachine,com.cyancloud.service.model.BillingPackageBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	BillingPackageBean bp = (BillingPackageBean)request.getAttribute("bpb");
	Integer memory = bp.getMemory()/1024;
	Integer capacity = bp.getCapacity()/1024;
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
		<script src="${rootUrl }/js/scripts/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" language="javascript">
        	function changePackage() {
        		var os = ''; 
    			var cpu = '';
    			var memory = '';  
    			var capacity = ''; 
    			var templateId = document.getElementById("templateId").value;
				$.ajax({
	        		url:"${rootUrl }system/getTemplate.do?id="+templateId,
	        		dataType:"json",
	        		success:function(data){
		        		$.each(data,function(i,p){
		        	    	os = p['os'];
		        	    	cpu = p['cpu'];
		        	    	memory = p['memory'];
		        	    	capacity = p['capacity'];
		        		});
		        		document.getElementById("os").value = os;
		        		getChecked(document.getElementById("cpu"),cpu);
		        		getChecked(document.getElementById("memory"),memory);
        				document.getElementById("capacity").value = capacity; 
	        		}
        		}); 
        		  
			}
			
			function getChecked(obj,value) {
          		for(i=0;i<obj.length;i++){
              		if(value == obj.options[i].value){ 
                  		obj.options[i].selected = true  
              		}  
          		}  
			}
			
			function onload() {
          		var selTemplateValue = document.getElementById("selTemplateId").value;
          		var templateId = document.getElementById("templateId");   
          		for(i=0;i<templateId.length;i++){
              		if(selTemplateValue == templateId.options[i].value){  
                  		templateId.options[i].selected = true  
              		}  
          		}  
          		
          		var selCpuValue = document.getElementById("selCpu").value;
          		var cpu = document.getElementById("cpu");   
          		for(i=0;i<cpu.length;i++){
              		if(selCpuValue == cpu.options[i].value){  
                  		cpu.options[i].selected = true  
              		}  
          		}  
          		
          		var selMemoryValue = document.getElementById("selMemory").value;
          		var memory = document.getElementById("memory");   
          		for(i=0;i<memory.length;i++){
              		if(selMemoryValue == memory.options[i].value){  
                  		memory.options[i].selected = true  
              		}  
          		}  
			}
			
			function checkNumbers(e) {  
				var keynum ;
				var keychar ; 
				var numcheck ; 
				if(window.event) { // IE  
					keynum = e.keyCode  
				} else if(e.which) { // Netscape/Firefox/Opera    
					keynum = e.which  
				}  
				keychar = String.fromCharCode(keynum)  
				numcheck = /\d/ ;
				return numcheck.test(keychar)  
			} 
		</script>
	</head>
	<body onload="onload();">
			<form id="myForm"  name="myForm" class="form-horizontal" action="${rootUrl }system/doEditBillingPackage.do"  method="post" >
				<fieldset>
					<input type="hidden" id="id" name="id" value="${bpb.id }">
					<input type="hidden" id="selTemplateId" name="selTemplateId" value="${bpb.templateId }">
					<input type="hidden" id="selCpu" name="selCpu" value="${bpb.cpu }">
					<input type="hidden" id="selMemory" name="selMemory" value="<%=memory%>">
					<div class="form-group">
						<label class="col-md-2 control-label">名称</label>
						<div class="col-md-10">
							<input class="form-control" type="text" name="name" id="name" value="${bpb.name }">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">模板</label>
						<div class="col-md-10">
							<select class="form-control" name="templateId" id="templateId" onchange="changePackage()">
								<c:forEach items="${templateList }" var="t" varStatus="list">
									<option value="${t.elementId }">${t.name }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">操作系统</label>
						<div class="col-md-10">
							<input class="form-control" type="text" name="os" id="os"  value="${bpb.os }" readonly>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">CPU核数</label>
						<div class="col-md-10">
							<select class="form-control" name="cpu" id="cpu">
								<option value="0">请选择</option>
								<option value="1">1核</option>
								<option value="2">2核</option>
								<option value="4">4核</option>
								<option value="8">8核</option>
								<option value="16">16核</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">内存(GB)</label>
						<div class="col-md-10">
							<select class="form-control" name="memory" id="memory">
								<option value="0">请选择</option>
								<option value="1">1G</option>
								<option value="2">2G</option>
								<option value="4">4G</option>
								<option value="8">8G</option>
								<option value="16">16G</option>
								<option value="32">32G</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">存储空间(GB)</label>
						<div class="col-md-10">
							<input class="form-control" type="text" name="capacity" id="capacity" value="<%=capacity%>" onkeypress="return checkNumbers(event)">
						</div>
					</div>
				</fieldset>
			</form>
	</body>
</html>
