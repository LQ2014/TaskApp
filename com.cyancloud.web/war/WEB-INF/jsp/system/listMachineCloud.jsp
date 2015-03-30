<%@page import="net.sf.json.JSONArray"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="system/listMachineCloud";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<%
	/* List<SystemParam> paramList = (List<SystemParam>)request.getAttribute("paramList"); */
%>
<!DOCTYPE html>
<html lang="en-us">
	<body id="myBody" onload="onload();">
		<!-- MAIN PANEL -->
		<div id="main" role="main">

			<!-- RIBBON -->
			<div id="ribbon">

				<span class="ribbon-button-alignment"> <span id="refresh"
					class="btn btn-ribbon" data-action="resetWidgets"
					data-title="refresh" rel="tooltip" data-placement="bottom"
					data-original-title="<i class='text-warning fa fa-warning'></i> 您的布局将重置到初始状态."
					data-html="true"> <i class="fa fa-refresh"></i> </span> </span>

				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>
						系统管理
					</li>
					<li>
						物理机云化
					</li>
				</ol>
				<!-- end breadcrumb -->

				<!-- You can also add more buttons to the
				ribbon for further usability

				Example below:

				<span class="ribbon-button-alignment pull-right">
				<span id="search" class="btn btn-ribbon hidden-xs" data-title="search"><i class="fa-grid"></i> Change Grid</span>
				<span id="add" class="btn btn-ribbon hidden-xs" data-title="add"><i class="fa-plus"></i> Add</span>
				<span id="search" class="btn btn-ribbon" data-title="search"><i class="fa-search"></i> <span class="hidden-mobile">Search</span></span>
				</span> -->

			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">

				<!-- widget grid -->
				<section id="widget-grid" class=""> <!-- row -->
				<div class="row">

					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<!-- Widget ID (each widget will need unique ID)-->
					<div id="myTable" class="jarviswidget jarviswidget-color-blueDark" data-widget-editbutton="false" data-widget-deletebutton="false">
						<!-- widget options:
								usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">
				
								data-widget-colorbutton="false"
								data-widget-editbutton="false"
								data-widget-togglebutton="false"
								data-widget-deletebutton="false"
								data-widget-fullscreenbutton="false"
								data-widget-custombutton="false"
								data-widget-collapsed="true"
								data-widget-sortable="false"
				
								-->
						<header> <span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;
							<h2>
								物理机云化
							</h2>
						</span> </header>

						<!-- widget div-->
						<div>

							<!-- widget edit box -->
							<div class="jarviswidget-editbox">
								<!-- This area used as dropdown edit box -->

							</div>
							<!-- end widget edit box -->

							<!-- widget content -->
							<div class="widget-body no-padding">

								<table id="datatable_tabletools"
									class="table table-striped table-bordered table-hover">

									<thead>
										<tr>
											<th data-hide="phone">
												序号
											</th>
											<th data-hide="phone">
												MAC地址
											</th>
											<th data-class="expand">
												预装系统
											</th>
											<th>
												状态
											</th>
											<th >
												任务创建时间
											</th>
											<th >
												任务完成
											</th>
											<th data-hide="phone,tablet" class="col-xs-6 col-sm-4 col-md-2 col-lg-2">
												操作
											</th>
										</tr>
									</thead>
									<tbody>
								<%-- 	<%for(int i =0;paramList!=null && i<paramList.size();i++){
										SystemParam order = paramList.get(i);
										//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
										//String life = sdf.format(order.getCtime().getTime());
									%> --%>
										<tr>
											<td>
												1
											</td>
											<td>
												E0 3C 48 BU
											</td>
											<td>
												exsi
											</td>
											<td>
												未安装
											</td>
											<td>
												2014/10/17 9:58
											</td>
											<td>
											
											</td>
											<td>
												<button class='btn bg-color-blue txt-color-white' onclick="openEditWindow()">修改</button> 
												<button class='btn bg-color-blue txt-color-white' onclick="deleteSystemParam()">删除</button>
												<button class='btn bg-color-blue txt-color-white' >完成</button>
											</td>
										</tr>
										<tr>
											<td>
												2
											</td>
											<td>
												B3 2C 4E BC
											</td>
											<td>
												exsi
											</td>
											<td>
												安装完成
											</td>
											<td>
												2014/10/17 9:58
											</td>
											<td>
											
											</td>
											<td>
												<button class='btn bg-color-blue txt-color-white' onclick="openCloudWindow()">云化</button>
											</td>
										</tr>
										<tr>
											<td>
												3
											</td>
											<td>
												E3 2B FE E8
											</td>
											<td>
												exsi
											</td>
											<td>
												云化完成
											</td>
											<td>
												2014/10/18 9:58
											</td>
											<td>
												2014/10/19 9:58
											</td>
											<td>
												
											</td>
										</tr>
									</tbody>
								</table>

							</div>
							<!-- end widget content -->

						</div>
						<!-- end widget div -->

					</div>
					<!-- end widget --> </article>
					<!-- WIDGET END -->

				</div>

				<!-- end row --> <!-- end row --> </section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN PANEL -->
<!-- 新增窗口 -->
<div id="addtab" style="display:none;margin:0;" title="<div class='widget-header'><h4><i class='fa fa-plus'></i> Add another tab</h4></div>">

				<form class="form-horizontal" action="addSystemParam.do" id="systemParamForm" method="post">

					<fieldset>
						<input name="authenticity_token" type="hidden">
						<input name="id" type="hidden" id="id">
						<div class="form-group">
							<!-- <label class="col-md-3 control-label">Mac地址</label> -->
							<label class="col-md-3 control-label"> Mac地址</label>
							<div class="col-md-9">
								<input class="form-control" type="text" name="phone" placeholder="Phone" data-mask="**-**-**-**">
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-3 control-label">操作系统</label>
							<div class="col-md-9">
										<select class="form-control" name="" id="">
											<option value="1">windows</option>
											<option value="2">linux</option>
											<option value="3">EXSI5.5</option>
											<option value="4">EXSI5.1</option>
										</select>
							</div>
						</div>
					</fieldset>

				</form>

			</div>
<!-- 新增窗口 -->
<div id="cloud" style="display:none;margin:0;" title="<div class='widget-header'><h4><i class='fa fa-plus'></i> Add another tab</h4></div>">

				<form class="form-horizontal" action="addSystemParam.do" id="systemParamForm" method="post">

					<fieldset>
						<input name="authenticity_token" type="hidden">
						<input name="id" type="hidden" id="id">
						<div class="form-group">
							<label class="col-md-6 control-label">选择云化的vCenter</label>
							<div class="col-md-6">
									<select class="form-control" name="" id="">
											<option value="1">vCenter1</option>
											<option value="2">vCenter2</option>
										</select>
							</div>
						</div>
					</fieldset>

				</form>

			</div>
			<!-- 新增窗口 -->
			<!-- 删除确认窗口 -->
			<div id="isDelete" style="display:none;margin:0;">
				<div id="isDelete-message">
					
				</div>
			</div>
			<!-- 删除确认窗口 -->
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

		<!-- SPARKLINES -->
		<script src="${rootUrl}js/plugin/sparkline/jquery.sparkline.min.js"></script>

		<!-- JQUERY VALIDATE -->
		<script
			src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>

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

		
		

		<!-- MAIN APP JS FILE -->
		<script src="${rootUrl}js/app.min.js"></script>

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
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	
	function listVerify(me){
		if(/^\d+$/.test($("#list").val())){
			$("#list_verify").hide();
		}else{
			$("#list_verify").show();	
		}
	}
	
 	function deleteSystemParam(id){
 		$("#isDelete-message").html("<h3>确认删除？<h3>")  ;
		$("#isDelete").dialog("open");
		$("#isDelete").dialog({param_id:"${rootUrl}system/deleteSystemParam.do?paramId="+id});
 	}
   	function openEditWindow(){
		var dialog = $("#addtab").dialog("open");
		$("#addtab").dialog({"title": "修改云化任务"});
		document.getElementById("mac").value = "E0 3C 48 BU";
	}
	
	function openCloudWindow(){
		var dialog = $("#cloud").dialog("open");
	}
	$(document).ready(function() {
		pageSetUp();
		var responsiveHelper_datatable_tabletools = undefined;

		var breakpointDefinition = {
			tablet : 1024,
			phone : 480
		};
						
		/* TABLETOOLS */
		$('#datatable_tabletools').dataTable({

			// Tabletools options: 
			//   https://datatables.net/extensions/tabletools/button_options
			"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"
				+ "t"
				+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
			"oTableTools" : {
				"aButtons" : [{
					"sExtends" : "text",
					"sButtonText": "新增",
					"fnClick":function(nButton, oConfig, oFlash){
						$("#addtab").dialog("open");
						$("#addtab").dialog({"title": "新增云化任务"});
						document.getElementById("mac").value = null;
					}
				}],
				"sSwfPath" : "${rootUrl}js/plugin/datatables/swf/copy_csv_xls_pdf.swf"
			},
			"autoWidth" : true,
			"preDrawCallback" : function() {
				// Initialize the responsive datatables helper once.
				if (!responsiveHelper_datatable_tabletools) {
					responsiveHelper_datatable_tabletools = new ResponsiveDatatablesHelper(
					$('#datatable_tabletools'),
					breakpointDefinition);
				}
			},
			"rowCallback" : function(nRow) {
				responsiveHelper_datatable_tabletools.createExpandIcon(nRow);
			},
			"drawCallback" : function(oSettings) {
				responsiveHelper_datatable_tabletools.respond();
			}
		});
			
		$("#addtab").dialog({
			autoOpen : false,
			modal : true,
			height:235, 
			width:400, 
			title : "新增云化任务",
			buttons : [{
				html : "取消",
				"class" : "btn btn-default",
				click : function() {
					$(this).dialog("close");
				}
			}, {
				html : "<i class='fa fa-check'></i>&nbsp; 保存",
				"class" : "btn btn-primary",
				click : function() {
					$(this).dialog("close");
				}
			}]
		});
		
		$("#cloud").dialog({
			autoOpen : false,
			modal : true,
			height:200, 
			width:400, 
			title : "云化",
			buttons : [{
				html : "取消",
				"class" : "btn btn-default",
				click : function() {
					$(this).dialog("close");
				}
			}, {
				html : "<i class='fa fa-check'></i>&nbsp; 保存",
				"class" : "btn btn-primary",
				click : function() {
						$(this).dialog("close");
				}
			}]
		});
					
		$("#isDelete").dialog({
			autoOpen : false,
			modal : true,
			draggable:false,
			position:"center",
			resizable :false,
			title:"操作提示",	
			height:210, 
			width:300, 
			buttons : [{
				html : "取消",
				"class" : "btn btn-default",
				click : function() {
					$(this).dialog("close");
				}
			}, {
				html : "确定",
				"class" : "btn btn-primary",
				click : function(btn) {
					ajaxFunction($("#isDelete").dialog("option","param_id"));
					$(this).dialog("close");
				}
			}]
		});
	});
</script>
	</body>

</html>
