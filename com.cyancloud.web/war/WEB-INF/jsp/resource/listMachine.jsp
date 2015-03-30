<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.web.util.CommonUtils,java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="resource/listMachine";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<%
	List<VMachine> vMachineList = (List<VMachine>)request.getAttribute("vMachineList");
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
	
									<table id="machine"
										class="table table-striped table-bordered table-hover">
	
										<thead>
											<tr>
												<th class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													序号
												</th>
												<th class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													机器名称
												</th>
												<th data-class="phone,tablet" class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													开机状态
												</th>
												<th data-class="phone,tablet" class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													操作系统
												</th>
												<th data-class="phone,tablet" class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													CPU核数(个)
												</th>
												<th data-class="phone,tablet" class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													CPU使用(MHZ)
												</th>
												<th  class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													置备内存(MB)
												</th>
												<th data-class="phone,tablet" class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													内存使用(MB)
												</th>
												<th class="col-xs-6 col-sm-4 col-md-2 col-lg-3">
													已用存储空间(GB) / 置备存储空间(GB)
												</th>
												<th data-class="expand" class="col-xs-6 col-sm-4 col-md-2 col-lg-1">
													状态
												</th>
											</tr>
										</thead>
										<tbody>
										<%for(int i =0;vMachineList!=null && i<vMachineList.size();i++){
											VMachine vMachine = vMachineList.get(i);
											String totalCap = "";
											if(vMachine.totalCapacity != null) {
												Double cap = Double.valueOf(vMachine.totalCapacity)/1024;
												DecimalFormat fmtOfNumber= new  DecimalFormat("#####0");
												totalCap = fmtOfNumber.format(cap);
											}
											String usedCap = "";
											if(vMachine.capacity != null) {
												Double cap = Double.valueOf(vMachine.capacity)/1024;
												usedCap = CommonUtils.getFormatValue(cap);
											}
											String percent =  CommonUtils.getFormatValue((Double.valueOf(vMachine.capacity)/1024)/(Double.valueOf(vMachine.totalCapacity)/1024)*100);
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
													<span id="sparkline_cpu_<%=vMachine.elementId %>"></span>
													<%-- <span class="sparkline txt-color-green" data-sparkline-type="line" data-sparkline-width="80px" data-maxspot-color="black"data-fill-color="transparent" data-sparkline-spotradius="3" data-sparkline-height="15px" data><%=vMachine.recentTenCpuUsed %></span> --%>
												</td>
												<td>
													<%=vMachine.memory %>
												</td>
												<td>
													<span id="sparkline_mem_<%=vMachine.elementId %>"></span>
												</td>
												<td>
													<div class="progress" style="margin-bottom:0px;height:18px">
														<div class="progress-bar bg-color-blue" style="width: <%=percent %>%;"></div>
														<span class="pull-right"><%=usedCap%>/<%=totalCap%></span>
													</div>
												</td>
												<td>
													<%if(vMachine.powerStatus.equals("poweredOn")) {%>
													<img src="${rootUrl}/img/event-<%=vMachine.status.toLowerCase()%>.png" alt="活动（图标）" style="height: 12px; width: 12px; "/><%}%>
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
	$(document).ready(function() {
		pageSetUp();
		<%for(int i=0;i<vMachineList.size();i++){ %>
			$("#sparkline_mem_<%=vMachineList.get(i).elementId %>").sparkline([<%=vMachineList.get(i).recentTenMemUsed %>],{
			    type: "line",
			    width:"100",
			    lineColor:"black",
			    spotRadius:"3",
			    fillColor:"transparent",
			    minSpotColor: "#00ff00",
			    maxSpotColor: "#bf0000"});
			$("#sparkline_cpu_<%=vMachineList.get(i).elementId %>").sparkline([<%=vMachineList.get(i).recentTenCpuUsed %>],{
			    type: "line",
			    width:"100",
			    lineColor:"black",
			    fillColor:"transparent",
			    spotRadius:"3",
			    minSpotColor: "#00ff00",
			    maxSpotColor: "#bf0000"});
		<%}%>
		
		$('#machine').dataTable(); 
	});
</script>
	</body>

</html>
