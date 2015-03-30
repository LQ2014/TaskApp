<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="resource/listHost";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<%
	List<VHost> vHostList = (List<VHost>)request.getAttribute("vHostList");
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
						资源监控
					</li>
					<li>
						物理机
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
						
						<!-- 实体机 -->
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
									物理机
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
												<th data-hide="phone">
													机器名称
												</th>
												<th data-class="expand">
													厂商
												</th>
												<th data-class="expand">
													型号
												</th> 
												<th data-class="expand">
													CPU核数(个)
												</th>
												<th data-class="expand">
													CPU数量(个)
												</th>
												<th data-class="expand">
													置备CPU(MHZ)
												</th>
												<th>
													CPU使用(MHZ)
												</th>
												<th >
													内存(MB)
												</th>
												<th >
													内存使用(MB)
												</th>
												<th data-hide="phone">
													状态
												</th>
											</tr>
										</thead>
										<tbody>
										<%for(int i =0;vHostList!=null && i<vHostList.size();i++){
											VHost vHost = vHostList.get(i);
											//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
											//String life = sdf.format(order.getCtime().getTime());
										%>
											<tr>
												<td>
													<%=i+1 %>
												</td>
												<td>
													<%=vHost.name %>
												</td>
												<td>
													<%=vHost.vendor %>
												</td>
												<td>
													<%=vHost.model %>
												</td>
												<td>
													<%=vHost.cpuCoreNum %>
												</td>
												<td>
													<%=vHost.cpuNum %>
												</td>
												<td>
													<%=vHost.cpuCoreSpeed %>
												</td>
												<td>
													<span id="sparkline_cpu_<%=vHost.elementId %>"></span>
													<%-- <span class="sparkline txt-color-green" data-sparkline-type="line" data-sparkline-width="80px" data-fill-color="transparent" data-sparkline-spotradius="3" data-sparkline-height="15px"><%=vHost.recentTopTenCpuUsed %></span> --%>
												</td>
												<td>
													<%=vHost.memory %>
												</td>
												<td>
													<span id="sparkline_mem_<%=vHost.elementId %>"></span>
													<%-- <span class="sparkline txt-color-green" data-sparkline-type="line" data-sparkline-width="80px" data-fill-color="transparent" data-sparkline-spotradius="3" data-sparkline-height="15px"><%=vHost.recnetTopTenMemUsed %></span> --%>
												</td>
												<td>
													<img src="${rootUrl}/img/event-<%=vHost.status.toLowerCase()%>.png" alt="活动（图标）" style="height: 12px; width: 12px; "/>
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
						<!-- 物理机 -->
						
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

	$(document).ready(function() {
		pageSetUp();
		
		<%for(int i=0;i<vHostList.size();i++){ %>
			$("#sparkline_mem_<%=vHostList.get(i).elementId %>").sparkline([<%=vHostList.get(i).recentTopTenMemUsed %>],{
			    type: "line",
			    width:"100",
			    lineColor:"black",
			    spotRadius:"3",
			    fillColor:"transparent",
			    minSpotColor: "#00ff00",
			    maxSpotColor: "#bf0000"});
			$("#sparkline_cpu_<%=vHostList.get(i).elementId %>").sparkline([<%=vHostList.get(i).recentTopTenCpuUsed %>],{
			    type: "line",
			    width:"100",
			    lineColor:"black",
			    fillColor:"transparent",
			    spotRadius:"3",
			    minSpotColor: "#00ff00",
			    maxSpotColor: "#bf0000"});
		<%}%>
			$('#datatable_tabletools').dataTable(); 
						
	});
</script>
	</body>

</html>
