<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.service.model.DesktopBean,net.sf.json.JSONArray,com.cyancloud.model.desktop.DesktopSession,java.text.DecimalFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
	String path="report/listDesktopActiveTime";
	List<DesktopSession> list = (List<DesktopSession>)request.getAttribute("desktopList");
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<!DOCTYPE html>
<html lang="en-us">
	<body id="myBody" onload="onload();">&nbsp; 
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
						桌面在线时长统计
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
					<div hidden=true><reportName>云桌面</reportName></div>
					<!-- NEW WIDGET START -->
					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						
						<!-- Widget ID (each widget will need unique ID)-->
						<div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">
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
							<!-- widget div-->
							<div>
								<!-- widget edit box -->
								<div class="jarviswidget-editbox">
									<!-- This area used as dropdown edit box -->
								</div>
								<!-- end widget edit box -->
								<!-- widget content -->
								<div class="widget-body no-padding">
									<div class="collapse navbar-collapse bg-color-grey">
										<form class="navbar-form navbar-left" role="search">
											<label><h3><strong>Top&nbsp&nbsp</strong></h3></label>
											<select class="form-control required" name="topnum" id="topnum" >
												<option value="5">5个</option>
												<option value="10">10个</option>
												<option value="15">15个</option>
												<option value="20">20个</option>
											</select> <i></i> 
											<button class="btn btn-primary" type="button" onclick="loadChart()">
												查询
											</button>
										</form>
									</div>
									<div id="bar-chart" class="chart"></div>
								</div>
								<!-- end widget content -->
							</div>
							<!-- end widget div -->
						</div>
						<!-- end widget -->
						
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
									桌面连接记录
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
	
									<table id=desktopSessionTable
										class="table table-striped table-bordered table-hover">
	
										<thead>
											<tr>
												<th>
													序号
												</th>
												<th>
													开始时间
												</th>
												<th class="col-xs-6 col-sm-4 col-md-2 col-lg-2">
													桌面名称
												</th>
												<th>
													用户名称
												</th>
												<th>
													活动时长(分钟)
												</th>
											</tr>
										</thead>
										<tbody>
										<%for(int i =0;list!=null && i<list.size();i++){
											DesktopSession desk = list.get(i);
											DecimalFormat df = new DecimalFormat("0.00");
											SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
											if(desk.activeTime !=null){
											Double time = desk.activeTime==null?0.00:desk.activeTime/60.00;
											String[] name = desk.getDesktopName().split("\\.");
											
										%>
											<tr>
												<td>
													<%=i+1 %>
												</td>
												<td>
													<%=sdf.format(desk.startTime)%>
												</td>
												<td>
													<%=name[0]%>
												</td>
												<td>
													<%=desk.getUserName() %>
												</td>
												<td>
													<%=df.format(time) %>
												</td>
											</tr>
										<%	
										}
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
		<!-- Flot Chart Plugin: Flot Engine, Flot Resizer, Flot Tooltip -->
		<script src="${rootUrl}js/plugin/echart/echarts-all.js"></script>
		<script type="text/javascript">
	
	function loadChart(){
		var topnum = document.getElementById("topnum").value;
		$.ajax({
        	url: "${rootUrl}report/loadDesktopActiveTime.do?topnum="+topnum,
        	type: "post",
        	dataType:"json",
        	success: function(data){
	        	var chart = echarts.init(document.getElementById("bar-chart"));
	        	chart.dispose();
	        	console.log(chart);
				option = {
					title : {
				        text: '在线总时长'
				    },
				    tooltip : {
				        trigger: 'axis',
				        formatter: function (params) {
				            var tar = params[0];
				            return "桌面名称：" + tar.name +"<br/>" + "在线时长：" + tar.value;
				        }
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            dataZoom : {show: true},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    xAxis : [
				        {
				            type : 'category',
				            data : data[0].xAxis,
				            axisLabel:{
				            	rotate:20
				            }
				        }
				    ],
				    yAxis : [
				        {
				        	name: '时长(分)',
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				        	name:'在线时长',
				            type:'bar',
				            data:data[0].data,
				            itemStyle: {
				                normal: {
				                    color:'#C1232B'
				                }
			            	},
				        }
				    ],
				    calculable:true
				};
			     
				var myChart = echarts.init(document.getElementById("bar-chart"));
				myChart.setOption(option);
			} 
    	});
	}
	$(document).ready(function() {
		$('#desktopSessionTable').dataTable({
			"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"+
				"t"+
				"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
		    "oTableTools": {
		        "aButtons": [{
	                "sExtends": "xls",
	                "sButtonText":"导出数据"
	            }],
		    "sSwfPath": "${rootUrl}js/plugin/datatables/swf/copy_csv_xls.swf"
		}});
		loadChart();
	});
</script>
	</body>

</html>
