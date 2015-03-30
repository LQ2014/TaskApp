<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.web.util.CommonUtils"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	List<VSnapshot> snapshot= (List<VSnapshot>)request.getAttribute("snapshot");
	String vmInst= (String)request.getAttribute("vmInst");
%>
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
				<style>
		.centre{
		position:absolute;
		margin-left:25%;
		}
		</style>
	</head>
	<body>
<div id="vmInstV"  Style="display:none"><%=vmInst %></div>
				<div>选择快照：</div>
						<table id="restoretable"  class="table table-striped table-bordered table-hover" >
										<thead>
											<tr>
												<th >													
												</th>
												<th >
													快照名称
												</th>
												<th >
													创造时间
												</th>												
												<th >
													描述
												</th>
											</tr>
										</thead>
										<tbody>
										<% for(VSnapshot v:snapshot){	
										 %>
											<tr>
												<td>
													<input type="radio" name="vs" value="<%=v.getInstId()%>">
												</td>
												<td>
													<%=v.getName() %>
												</td>
												<td>
													<%=v.getSnapCreateTime() %>
												</td>												
												<td>
													<%=v.getDescription() %>
												</td>							
											</tr>
											<%} %>
										</tbody>
									</table>
		<script>
		
	if (!window.jQuery) {
		document
				.write('<script src="${rootUrl}js/libs/jquery-2.1.1.min.js"><\/script>');
	}
</script>
		<script>
	if (!window.jQuery.ui) {
		document
				.write('<script src="${rootUrl}js/libs/jquery-ui-1.10.3.min.js"><\/script>');
	}
</script>

		<!-- IMPORTANT: APP CONFIG -->
		<script src="${rootUrl}js/app.config.js"></script>

		<!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
		<script
			src="${rootUrl}js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script>

		<!-- BOOTSTRAP JS -->
		<script src="${rootUrl}js/bootstrap/bootstrap.min.js"></script>

		<!-- CUSTOM NOTIFICATION -->
		<script src="${rootUrl}js/notification/SmartNotification.min.js"></script>

		<!-- JARVIS WIDGETS -->
		<script src="${rootUrl}js/smartwidgets/jarvis.widget.min.js"></script>
		

		<!-- EASY PIE CHARTS -->
		<script
			src="${rootUrl}js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>
		<!-- morris.min -->
		<script
			src="${rootUrl}js/plugin/morris/morris.min.js"></script>
		<!-- SPARKLINES -->
		<script src="${rootUrl}js/plugin/sparkline/jquery.sparkline.min.js"></script>

					<!-- JQUERY VALIDATE -->
		<script src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>
		<script src="${rootUrl}js/plugin/jquery-validate/messages_zh.js"></script>

		<!-- JQUERY MASKED INPUT -->
		<script
			src="${rootUrl}js/plugin/masked-input/jquery.maskedinput.min.js"></script>

		<!-- JQUERY SELECT2 INPUT -->
		<script src="${rootUrl}js/plugin/select2/select2.min.js"></script>

		<!-- JQUERY UI + Bootstrap Slider -->
		<script
			src="${rootUrl}js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

		<!-- browser msie issue fix -->
		<script src="${rootUrl}js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

		<!-- FastClick: For mobile devices -->
		<script src="${rootUrl}js/plugin/fastclick/fastclick.min.js"></script>

		<!--[if IE 8]>

		<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>

		<![endif]-->
		
		<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
		<!-- Voice command : plugin -->
		<script src="${rootUrl}js/speech/voicecommand.min.js"></script>

		<!-- PAGE RELATED PLUGIN(S) -->
		<script src="${rootUrl}js/plugin/datatables/jquery.dataTables.min.js"></script>
		<script src="${rootUrl}js/plugin/datatables/dataTables.colVis.min.js"></script>
		<script
			src="${rootUrl}js/plugin/datatables/dataTables.tableTools.min.js"></script>
		<script
			src="${rootUrl}js/plugin/datatables/dataTables.bootstrap.min.js"></script>
		<script
			src="${rootUrl}js/plugin/datatable-responsive/datatables.responsive.min.js"></script>
		<script type="text/javascript">
				$(document).ready(function(){
				 	$('#restoretable').dataTable({
									"bPaginate": true, // page turning 
									"bLengthChange": false, //Change the number each page display data
									"bFilter": false, //filter
									"bSort": true, //sort
									"bInfo": false,//page footer
									"bAutoWidth": true,//auto wide
									"sDom": "t<'centre'p>",
									"iDisplayLength": 4,
									"sPaginationType": "full_numbers",
									"aaSorting": [
										[ 2, "desc" ]
										],
									"oLanguage": {
										"oPaginate": {
										"sFirst": "首页",
										"sPrevious": "前一页",
										"sNext": "后一页",
										"sLast": "尾页"
										}
									},
									"rowCallback" : function(nRow) {
										var cells = nRow.getElementsByTagName("td"); 
						 				cells[1].children[0].innerHTML=name;
									}
				 	});			
				})
				</script>
				
	</body>
</html>
