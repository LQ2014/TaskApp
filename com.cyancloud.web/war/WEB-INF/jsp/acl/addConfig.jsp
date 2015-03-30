<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.cyancloud.model.system.*"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" /><link href="${rootUrl}css/jqmini/demo.css" rel="stylesheet" type="text/css" />
    	<script src="${rootUrl}js/scripts/boot.js" type="text/javascript"></script>
    	<script src="${rootUrl}js/commonlibs/TreeSelectWindow.js" type="text/javascript"></script>  
    	
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
		
		</script>
	</head>
	<body>
		<form id="addConfigForm"  name="addConfigForm" class="form-horizontal" action="${rootUrl }acl/doAddConfig.do"  method="post" >
			<fieldset>
				<input name="authenticity_token" type="hidden">				
				<div class="row">
					<label class="col-md-2 control-label">参数名</label>
					<div class="col-md-10">
						<input class="form-control required" type="text" name="key" id="key" >
					</div>
				</div>				
				<div class="row">
					<label class="col-md-2 control-label">参数值</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="value" id="value" >
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">描述</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="desc" id="desc" >
					</div>
				</div>				
				<div class="row">
					<label class="col-md-2 control-label">备注</label>
					<div class="col-md-10">
						<textarea rows="4" name="note" id="note" class="form-control"></textarea>
					</div>
				</div>	
			</fieldset>
		</form>
	</body>
</html>
