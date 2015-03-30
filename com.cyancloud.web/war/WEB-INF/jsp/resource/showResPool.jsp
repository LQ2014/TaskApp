<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="resource/listResPool";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
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
						资源监控
					</li>
					<li>
						资源池
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
								资源池详情
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

								<table id="datatable_col_reorder"
									class="table table-striped table-bordered table-hover">

									<thead>
										<tr>
											<th data-hide="phone">
												序号
											</th>
											<th data-class="expand">
												申请人
											</th>
											<th>
												申请时间
											</th>
											<th data-hide="phone">
												订单类型
											</th>
											<th data-hide="phone,tablet">
												原因
											</th>
											<th data-hide="phone,tablet">
												状态
											</th>
											<th data-hide="phone,tablet">
												操作
											</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												1
											</td>
											<td>
												zhangsan
											</td>
											<td>
												2014-09-01
											</td>
											<td>
												桌面申请
											</td>
											<td>
												项目需要
											</td>
											<td>
												待受理
											</td>
											<td>
												<input type="button" value="详情" />&nbsp;<input type="button" value="撤销" />
											</td>
										</tr>
										<tr>
											<td>
												2
											</td>
											<td>
												zhangsan
											</td>
											<td>
												2014-09-01
											</td>
											<td>
												桌面延期
											</td>
											<td>
												项目需要
											</td>
											<td>
												已受理
											</td>
											<td>
												<input type="button" value="详情" />
											</td>
										</tr>
										<tr>
											<td>
												3
											</td>
											<td>
												zhangsan
											</td>
											<td>
												2014-08-30
											</td>
											<td>
												文件下载
											</td>
											<td>
												项目需要
											</td>
											<td>
												审批通过
											</td>
											<td>
												<input type="button" value="详情" />
											</td>
										</tr>
										<tr>
											<td>
												4
											</td>
											<td>
												zhangsan
											</td>
											<td>
												2014-08-30
											</td>
											<td>
												文件下载
											</td>
											<td>
												项目需要
											</td>
											<td>
												审批退回
											</td>
											<td>
												<input type="button" value="详情" />&nbsp;<input type="button" value="重新申请" />
											</td>
										</tr>
										<tr>
											<td>
												5
											</td>
											<td>
												zhangsan
											</td>
											<td>
												2014-08-25
											</td>
											<td>
												桌面组扩容
											</td>
											<td>
												桌面组资源利用率太高
											</td>
											<td>
												待受理
											</td>
											<td>
												<input type="button" value="详情" />
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
						var responsiveHelper_dt_basic = undefined;
						var responsiveHelper_datatable_fixed_column = undefined;
						var responsiveHelper_datatable_col_reorder = undefined;
						var responsiveHelper_datatable_tabletools = undefined;

						var breakpointDefinition = {
							tablet : 1024,
							phone : 480
						};

						$('#dt_basic')
								.dataTable(
										{
											"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>"
													+ "t"
													+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
											"autoWidth" : true,
											"preDrawCallback" : function() {
												// Initialize the responsive datatables helper once.
												if (!responsiveHelper_dt_basic) {
													responsiveHelper_dt_basic = new ResponsiveDatatablesHelper(
															$('#dt_basic'),
															breakpointDefinition);
												}
											},
											"rowCallback" : function(nRow) {
												responsiveHelper_dt_basic
														.createExpandIcon(nRow);
											},
											"drawCallback" : function(oSettings) {
												responsiveHelper_dt_basic
														.respond();
											}
										});

						/* END BASIC */

						/* COLUMN FILTER  */
						var otable = $('#datatable_fixed_column')
								.DataTable(
										{
											//"bFilter": false,
											//"bInfo": false,
											//"bLengthChange": false
											//"bAutoWidth": false,
											//"bPaginate": false,
											//"bStateSave": true // saves sort state using localStorage
											"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'f><'col-sm-6 col-xs-12 hidden-xs'<'toolbar'>>r>"
													+ "t"
													+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
											"autoWidth" : true,
											"preDrawCallback" : function() {
												// Initialize the responsive datatables helper once.
												if (!responsiveHelper_datatable_fixed_column) {
													responsiveHelper_datatable_fixed_column = new ResponsiveDatatablesHelper(
															$('#datatable_fixed_column'),
															breakpointDefinition);
												}
											},
											"rowCallback" : function(nRow) {
												responsiveHelper_datatable_fixed_column
														.createExpandIcon(nRow);
											},
											"drawCallback" : function(oSettings) {
												responsiveHelper_datatable_fixed_column
														.respond();
											}

										});

						// custom toolbar
						$("div.toolbar")
								.html(
										'<div class="text-right"><img src="${rootUrl}img/logo.png" alt="SmartAdmin" style="width: 111px; margin-top: 3px; margin-right: 10px;"></div>');

						// Apply the filter
						$("#datatable_fixed_column thead th input[type=text]")
								.on(
										'keyup change',
										function() {

											otable.column(
													$(this).parent().index()
															+ ':visible')
													.search(this.value).draw();

										});
						/* END COLUMN FILTER */

						/* COLUMN SHOW - HIDE */
						$('#datatable_col_reorder')
								.dataTable(
										{
											"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'C>r>"
													+ "t"
													+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
											"autoWidth" : true,
											"preDrawCallback" : function() {
												// Initialize the responsive datatables helper once.
												if (!responsiveHelper_datatable_col_reorder) {
													responsiveHelper_datatable_col_reorder = new ResponsiveDatatablesHelper(
															$('#datatable_col_reorder'),
															breakpointDefinition);
												}
											},
											"rowCallback" : function(nRow) {
												responsiveHelper_datatable_col_reorder
														.createExpandIcon(nRow);
											},
											"drawCallback" : function(oSettings) {
												responsiveHelper_datatable_col_reorder
														.respond();
											}
										});

						/* END COLUMN SHOW - HIDE */

						/* TABLETOOLS */
						$('#datatable_tabletools')
								.dataTable(
										{

											// Tabletools options: 
											//   https://datatables.net/extensions/tabletools/button_options
											"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"
													+ "t"
													+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
											"oTableTools" : {
												"aButtons" : [
														"copy",
														"csv",
														"xls",
														{
															"sExtends" : "pdf",
															"sTitle" : "SmartAdmin_PDF",
															"sPdfMessage" : "SmartAdmin PDF Export",
															"sPdfSize" : "letter"
														},
														{
															"sExtends" : "print",
															"sMessage" : "Generated by SmartAdmin <i>(press Esc to close)</i>"
														} ],
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
												responsiveHelper_datatable_tabletools
														.createExpandIcon(nRow);
											},
											"drawCallback" : function(oSettings) {
												responsiveHelper_datatable_tabletools
														.respond();
											}
										});

						/* END TABLETOOLS */

					});
</script>
	</body>

</html>
