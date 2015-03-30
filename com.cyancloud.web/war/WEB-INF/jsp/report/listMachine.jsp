<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.vm.VMachine,com.cyancloud.web.util.CommonUtils"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="report/listMachine";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<%
	List<VMachine> vmMachineList = (List<VMachine>)request.getAttribute("vmMachineList");
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
						报表管理
					</li>
					<li>
						虚拟机
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
					<div hidden=true><reportName>虚拟机</reportName></div>
					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						
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
									虚拟机
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
												<th>
													序号
												</th>
												<th class="col-xs-6 col-sm-4 col-md-2 col-lg-2">
													机器名称
												</th>
												<th>
													开机状态
												</th>
												<th>
													操作系统
												</th>
												<th>
													CPU核数(个)
												</th>
												<th>
													置备内存(MB)
												</th>
												<th>
													置备存储空间(GB)
												</th>
												<th>
													已用存储空间(GB)
												</th>
											</tr>
										</thead>
										<tbody>
										<%for(int i =0;vmMachineList!=null && i<vmMachineList.size();i++){
											VMachine vMachine = vmMachineList.get(i);
											
											String totalCap = "";
											if(vMachine.totalCapacity != null) {
												Double cap = Double.valueOf(vMachine.totalCapacity)/1024;
												totalCap = CommonUtils.getFormatValue(cap);
											}
											String usedCap = "";
											if(vMachine.capacity != null) {
												Double cap = Double.valueOf(vMachine.capacity)/1024;
												usedCap = CommonUtils.getFormatValue(cap);
											}
										%>
											<tr>
												<td>
													<%=i+1 %>
												</td>
												<td>
													<%=vMachine.name %>
												</td>
												<td>
													<div><%if(vMachine.powerStatus.equals("poweredOn")) {%>已开启<%}else{%>已关闭<%}%></div>
												</td>
												<td>
													<%=vMachine.osType %>
												</td>
												<td>
													<%=vMachine.cpuNum %>
												</td>
												<td>
													<%=vMachine.memory %>
												</td>
												<td>
													<%=totalCap%>
												</td>
												<td>
													<%=usedCap%>
												</td>
												
												
											</tr>
											<%	
										}
										%>
										</tbody>
									</table>
	
								</div>
								<!-- end widget content -->
	
							</div>
							<!-- end widget div -->
	
						</div>
						
					</article>
					<!-- WIDGET END -->

				</div>

				<!-- end row --> <!-- end row --> </section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN PANEL -->

		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
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

	$(document)
			.ready(
					function() {

						pageSetUp();

						/* // DOM Position key index //
						
						l - Length changing (dropdown)
						f - Filtering input (search)
						t - The Table! (datatable)
						i - Information (records)
						p - Pagination (paging)
						r - pRocessing 
						< and > - div elements
						<"#id" and > - div with an id
						<"class" and > - div with a class
						<"#id.class" and > - div with an id and class
						
						Also see: http://legacy.datatables.net/usage/features
						 */

						/* BASIC ;*/
						var responsiveHelper_datatable_tabletools_info = undefined;
						var responsiveHelper_datatable_tabletools = undefined;

						var breakpointDefinition = {
							tablet : 1024,
							phone : 480
						};
						
						/* TABLETOOLS */
						 $('#datatable_tabletools').dataTable({
							"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"+
									"t"+
									"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
		        			"oTableTools": {
		        	 			"aButtons": [
		             				{
	                					"sExtends": "xls",
	                					"sButtonText":"导出数据"
	                				}
		             			],
		            			"sSwfPath": "${rootUrl}js/plugin/datatables/swf/copy_csv_xls_pdf.swf"
		        			},
							"autoWidth" : true,
							"preDrawCallback" : function() {
								// Initialize the responsive datatables helper once.
								if (!responsiveHelper_datatable_tabletools) {
									responsiveHelper_datatable_tabletools = new ResponsiveDatatablesHelper($('#datatable_tabletools'), breakpointDefinition);
								}
							},
							"rowCallback" : function(nRow) {
								responsiveHelper_datatable_tabletools.createExpandIcon(nRow);
							},
							"drawCallback" : function(oSettings) {
								responsiveHelper_datatable_tabletools.respond();
							}
						}); 
						
					});
</script>
	</body>

</html>
