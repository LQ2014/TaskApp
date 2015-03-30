<%@page import="net.sf.json.JSONArray"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<script src="${rootUrl }/js/scripts/jquery-2.1.1.min.js"></script>
		<script src="${rootUrl}js/libs/jquery-ui-1.10.3.min.js"></script>
		<script src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>
		<script src="${rootUrl}js/plugin/jquery-validate/messages_zh.js"></script>

		<title><spring:message code="webapp.name"></spring:message></title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-skins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/demo.min.css">

        	
		</script>
		<style>
         html { overflow-x:hidden; }
        </style>
	</head>
	<body>

			<form id ="testmail" class="smart-form" method="post" action="${rootUrl}system/doTestConfigEmail.do">
				<fieldset>
					<div class="row">
						<section class="col col-2">
							<label class="label">收件人</label>
						</section>
						<section class="col col-10">
							<label class="input">
								<input type="text" name="userM" id="userM" class="required email">
							</label>
						</section>
					</div >
					<div class="row">
						<section class="col col-2">
							<label class="label">邮件主题</label>
						</section>
						<section class="col col-10">
							<label class="input">
								<input type="text" name="titleM" id="titleM" class="required">
							</label>
						</section>
					</div >
					<div class="row" style="margin-bottom:100px">
								<section class="col col-2">
									<label class="label">邮件内容</label>
								</section>
								<section class="col col-10">
									<label class="input">
										<textarea class="form-control required" name="contentM" id="contentM" rows="5" ></textarea>
									</label>
								</section>
					</div>


				</fieldset>
		</form>
		<script>


		$(function() {
	         
			$("#testmail").validate({});
		});
		</script>	

	</body>
</html>

