<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.web.util.CommonUtils"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.cyancloud.model.notice.Notice"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="notice/listNotice";
%>
<% 
	List<Notice> list = (List<Notice>)request.getAttribute("notices");
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<!DOCTYPE html>
<html lang="en-us">		
		<style>
		.centre{
		position:absolute;
		margin-left:25%;
		}
		.btn-link-underline{
		width:100%;
		text-align:left;
		color:black;
		}
		.btn-link-underline:hover{
		text-decoration:none;
		background:#104E8B;
		color:white;
		}
		</style>
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
						信息管理
					</li>
					<li>
						通知公告
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

			<div id="content">

				<!-- widget grid -->
				<section id="widget-grid" class=""> <!-- row -->
				<div class="row">

					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						
						<!-- 虚拟机 -->
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
									通知公告
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
										class="table table-striped table-bordered table-hover"
										width="100%"  >
										<thead>
											<tr>
												<th>
													序号
												</th>
												<th>
													标题
												</th>
												<th>
													发布人
												</th>
												<th>
													内容
												</th>
												<th>
													发布时间
												</th>	
												<th>
													是否已发布
												</th>													
												<th class="col-lg-2">
													操作
												</th>
											</tr>
										</thead>
										<tbody>	
											<%for(int i =0;list!=null && i<list.size();i++){
												Notice notice = list.get(i);
												String publisher = "superadmin";
												if(notice.getPublisher()!=null){
													publisher = notice.getPublisher().getUname();
												}
												
												
											%>								
											<tr>
												<td><%=i%></td>	
												<td><%=notice.getTitle() %></td>
												<td><%=publisher %></td>
												<td><%=notice.getContent() %></td>
												<td>
												<%=notice.getInputDate() %>
												</td>
												<td><%=notice.getEnumConstByflagIsPublished().getName() %></td>
												<td>
													<%
														if(notice.getEnumConstByflagIsPublished().getCode().equals("0")){
													%>
													<button class='btn bg-color-blue txt-color-white' onclick="publishNotice('<%=notice.getId()%>','1');">发布</button>&nbsp;&nbsp;
													<%}else{ %>
													<button class='btn bg-color-red txt-color-white' onclick="publishNotice('<%=notice.getId()%>','0');">取消</button>&nbsp;&nbsp;
													<%} %>
													<button class='btn bg-color-red txt-color-white' onclick="deleteNotice('<%=notice.getId()%>');">删除</button>&nbsp;&nbsp;
												</td>
											</tr>	
											<%} %>
										</tbody>
									</table>
	
								</div>
								<!-- end widget content -->
	
							</div>
							<!-- end widget div -->
	
						</div>
						<!-- 虚拟机 -->
						
					</article>
					<!-- WIDGET END -->

				</div>

				<!-- end row --> <!-- end row --> </section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN PANEL -->		
		<!-- 删除确认窗口 -->
		<div id="isDelete" style="display:none;margin:0;">
			<div id="isDelete-message">
				
			</div>
		</div>
		<!-- 删除确认窗口 -->
		<!-- 发布确认窗口 -->
		<div id="isPublish" style="display:none;margin:0;">
			<div id="isPublish-message">
				
			</div>
		</div>
		<!-- 发布确认窗口 -->
<script>
	if (!window.jQuery) {
		document.write('<script src="${rootUrl}js/libs/jquery-2.1.1.min.js"><\/script>');
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
		$(document).ready(function() {
			pageSetUp();
				$("#addsnapshot").validate();
			/* BASIC ;*/
			var responsiveHelper_datatable_tabletools = undefined;
	
			var breakpointDefinition = {
				tablet : 1024,
				phone : 480
			};
				
			
			$('#datatable_tabletools').dataTable({
				// Tabletools options: 
				//   https://datatables.net/extensions/tabletools/button_options
				"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"
					+ "t"
					+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
				"oTableTools" : {
				"aButtons" : [{
					"sExtends" : "text",
					"sButtonText": "发布通知",
					"fnClick":function(nButton, oConfig, oFlash){
						createNotice();						
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
			
			function createNotice(){
				window.location = "${rootUrl}notice/addNotice.do";			
			}
			
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
			
			$("#isPublish").dialog({
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
						ajaxFunction($("#isPublish").dialog("option","param_id"));
						$(this).dialog("close");
					}
				}]
			});
			
	
	});
		function publishNotice(id,code){	
			if(code=="0"){
				$("#isDelete-message").html("<h3>确认取消发布吗？<h3>");
			}else{
				$("#isDelete-message").html("<h3>确认发布通知公告吗？<h3>");
			}
			$("#isDelete").dialog("open");
			$("#isDelete").dialog({param_id:"${rootUrl}notice/isPublishNotice.do?id="+id+"&code="+code});			
		}
		function deleteNotice(id){
			$("#isDelete-message").html("<h3>确认删除？<h3>");
			$("#isDelete").dialog("open");
			$("#isDelete").dialog({param_id:"${rootUrl}notice/deleteNotice.do?id="+id});
		}
	</script>
	</body>

</html>
