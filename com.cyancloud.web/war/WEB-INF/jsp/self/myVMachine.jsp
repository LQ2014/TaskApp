<%@page import="java.text.DateFormat"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.web.util.CommonUtils"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="self/listMyMachine";
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
						服务目录
					</li>
					<li>
						我的虚拟机
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
									我的虚拟机
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
												<th data-class="phone,tablet">
													操作系统
												</th>
												<th  width="80px">
													置备内存(MB)
												</th>
												<th class="col-xs-6 col-sm-4 col-md-2 col-lg-3">
													已用存储空间(GB) / 置备存储空间(GB)
												</th>
												<th>
													有效期
												</th>
												<th data-class="phone,tablet" width="60px">
													开机状态
												</th>
												<th data-class="expand">
													操作
												</th>
											</tr>
										</thead>
										<tbody>
										<%
										SimpleDateFormat  d = new SimpleDateFormat("yyyy-MM-dd");
										for(int i =0;vMachineList!=null && i<vMachineList.size();i++){
											VMachine vMachine = vMachineList.get(i);
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
													<%=vMachine.osType %>
												</td>
												<td>
													<%=vMachine.memory %>
												</td>
												<td>
													<div class="progress" style="margin-bottom:0px;height:18px">
														<div class="progress-bar bg-color-blue" style="width: <%=percent %>%;"></div>
														<span class="pull-right"><%=usedCap%>/<%=totalCap%></span>
													</div>
												</td>
												<td>
													<%=vMachine.getExpireDate()==null?"":d.format(vMachine.getExpireDate()) %>
												</td>
												<td>
													<div>
													<%if(vMachine.powerStatus.equals("poweredOn")) {%>已开启<%}%>
													<%if(vMachine.powerStatus.equals("poweredOff")) {%>已关闭<%}%>
													<%if(vMachine.powerStatus.equals("suspended")) {%>已休眠<%}%>
													<%if(vMachine.powerStatus.equals("starting")) {%>正在开启<%}%>
													<%if(vMachine.powerStatus.equals("stopping")) {%>正在关闭<%}%>
													</div>
												</td>
												<td>
													<%if(vMachine.powerStatus.equals("poweredOn")) {%>
														<button class="btn bg-color-yellow txt-color-white" onclick="powerOff('<%=vMachine.name %>')">关机</button>&nbsp;
														<button class="btn bg-color-blue txt-color-white" onclick="window.open('${rootUrl }vm/connect.do?instId=<%=vMachine.instId %>')">控制台</button>
													<%}if(vMachine.powerStatus.equals("poweredOff")) {%>
														<button class="btn bg-color-green txt-color-white" onclick="powerOn('<%=vMachine.name %>')">开机</button>
													<%}if(vMachine.powerStatus.equals("suspended")) {%>
														<button class="btn bg-color-green txt-color-white" onclick="powerOn('<%=vMachine.name %>')">开机</button>&nbsp;
														<button class="btn bg-color-yellow txt-color-white" onclick="powerOff('<%=vMachine.name %>')">关机</button>
													
													<%}%>
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
		<!-- 弹出窗口 -->
		<div id="power" style="display:none;margin:0;">
			<div id="power-message">
				
			</div>
		</div>
		<!-- 弹出窗口 -->
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
	function powerOff(name){
		$("#power-message").html("<h3>确认关机？<h3>")  ;
		$("#power").dialog("open");
		$("#power").dialog({url:"${rootUrl}self/vmPowerOff.do?VM_name="+name});
	}
	function powerOn(name){
		$("#power-message").html("<h1>确认开机？<h1>")  ;
		$("#power").dialog("open");
		$("#power").dialog({url:"${rootUrl}self/vmPowerOn.do?VM_name="+name});
	}
	$(document).ready(function() {
		pageSetUp();
		/* TABLETOOLS */
		$('#datatable_tabletools').dataTable(); 
			
		$("#power").dialog({
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
					ajaxFunction($("#power").dialog("option","url"));
					$(this).dialog("close");
				}
			}]
						
		});
	});
</script>
	</body>

</html>
