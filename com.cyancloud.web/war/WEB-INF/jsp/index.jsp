<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.service.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
String path="index";
DesktopStat stat = (DesktopStat)request.getAttribute("desktopStat");
float desktopusage=0;
float capusage= 0;
float cpuusage=0;
float memusage=0;
float activeusg=0;
if(stat!=null){
	if(stat.getDesktopCount()!=null && stat.getDesktopCount()>0){
		desktopusage=  100*(stat.getDesktopUsed().floatValue()/stat.getDesktopCount().floatValue());
		activeusg=  100*(stat.getDesktopActive().floatValue()/stat.getDesktopCount().floatValue());
		}
	if(stat.getStorageCapacity()!=null && stat.getStorageCapacity()>0)	
		capusage=  100*(1- stat.getStorageFreeSpace().floatValue()/stat.getStorageCapacity().floatValue());
	if(stat.getCpuAllSpeed()!=null && stat.getCpuAllSpeed()>0){
		if(stat.getCpuUsed()!=null){
			cpuusage=  100*(stat.getCpuUsed().floatValue()/stat.getCpuAllSpeed().floatValue());	
		}else{
			cpuusage = 0;
		}
	}
		
	if(stat.getMemory()!=null && stat.getMemory()>0){
		if(stat.getMemoryUsed()!=null){
			memusage=  100*(stat.getMemoryUsed().floatValue()/stat.getMemory().floatValue());
		}else{
			memusage = 0;
		}
	}
}

List<ActiveDesktopStat> activeDesktopList = (List<ActiveDesktopStat>)request.getAttribute("activeDesktopList");

%>

<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="index"/>
</jsp:include>
<!DOCTYPE html>
<html lang="en-us">
	<body id="myBody" onload="onload();">
		<!-- MAIN PANEL -->
		<div id="main" role="main">

			<!-- RIBBON -->
			<div id="ribbon">

				<span class="ribbon-button-alignment"> 
					<span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh"  rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> 您的布局将重置到初始状态." data-html="true">
						<i class="fa fa-refresh"></i>
					</span> 
				</span>

				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>首页</li>
				</ol>
				<!-- end breadcrumb -->

				<!-- You can also add more buttons to the
				ribbon for further usability

				Example below:

				<span class="ribbon-button-alignment pull-right">
				<span id="search" class="btn btn-ribbon hidden-xs" data-title="search"><i class="fa-grid"></i> Change Grid</span>
				<span id="add" class="btn btn-ribbon hidden-xs" data-title="add"><i class="fa-plus"></i> Add</span>
				<span id="search" class="btn btn-ribbon" data-title="search"><i class="fa-search"></i> <span class="hidden-mobile">Search</span></span>
				</span>-->

			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">
				<!-- 
				<div class="row">
					<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
						<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i> Dashboard <span>> My Dashboard</span></h1>
					</div>
				</div>
				 -->
				<!-- widget grid -->
				<section id="widget-grid" class="">
					<!-- row -->
					<div class="row">
						<article class="col-sm-12">
							<!-- new widget -->
							<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
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
								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2>实时</h2>

									<ul class="nav nav-tabs pull-right in" id="myTab">
										<li class="active">
											<a data-toggle="tab" href="#s1"><i class="fa fa-clock-o"></i> <span class="hidden-mobile hidden-tablet">实时数据</span></a>
										</li>
										<!-- 
										<li>
											<a data-toggle="tab" href="#s2"><i class="fa fa-facebook"></i> <span class="hidden-mobile hidden-tablet">性能</span></a>
										</li>

										<li>
											<a data-toggle="tab" href="#s3"><i class="fa fa-dollar"></i> <span class="hidden-mobile hidden-tablet">桌面</span></a>
										</li>
										 -->
									</ul>

								</header>

								<!-- widget div-->
								<div class="no-padding">
									<!-- widget edit box -->
									<div class="jarviswidget-editbox">
										活动桌面
									</div>
									<!-- end widget edit box -->

									<div class="widget-body">
										<!-- content -->
										<div id="myTabContent" class="tab-content">
											<div class="tab-pane fade active in padding-10 no-padding-bottom" id="s1">
												<div class="row no-space">
													<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
														<span class="demo-liveupdate-1"> <span class="onoffswitch-title">活动桌面</span></span>
														<div id="saleschart" class="chart-large txt-color-blue"></div>
													</div>
													<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 show-stats">

														<div class="row">
															<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12"> <span class="text">已分配桌面<span class="pull-right">${desktopStat.desktopUsed}/${desktopStat.desktopCount}</span> </span>
																<div class="progress">
																	<div class="progress-bar bg-color-blueDark" style="width: <%=desktopusage%>%;"></div>
																</div> </div>
															<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12"> <span class="text">存储使用<span class="pull-right">${desktopStat.storageCapacity -desktopStat.storageFreeSpace}G/${desktopStat.storageCapacity}G</span> </span>
																<div class="progress">
																	<div class="progress-bar bg-color-greenLight" style="width: <%=capusage%>%;"></div>
																</div> </div>
															<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12"> <span class="text">CPU使用<span class="pull-right">${desktopStat.cpuUsed }/${desktopStat.cpuAllSpeed}</span> </span>
																<div class="progress">
																	<div class="progress-bar bg-color-blue" style="width: <%=cpuusage%>%;"></div>
																</div> </div>
															<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12"> <span class="text">内存使用<span class="pull-right">${desktopStat.memoryUsed }G/${desktopStat.memory}G</span> </span>
																<div class="progress">
																	<div class="progress-bar bg-color-blue" style="width: <%=memusage%>%;"></div>
																</div> </div>
														</div>
													</div>
												</div>

												<div class="show-stat-microcharts">
													<div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">

														<div class="easy-pie-chart txt-color-orangeDark" data-percent="<%=activeusg %>" data-pie-size="50">
															<span class="percent percent-sign"><%=activeusg %></span>
														</div>
														<span class="easy-pie-title"> 活动桌面<i class="fa fa-caret-up icon-color-bad"></i> </span>
														<ul class="smaller-stat hidden-sm pull-right">
															<li>
																<span class="label bg-color-blueDark"><i class="fa fa-caret-up"></i>${maxActive }</span>
															</li>
															<li>
																<span class="label bg-color-blue"><i class="fa fa-caret-down"></i>${minActive}</span>
															</li>
														</ul>
														<div class="sparkline txt-color-greenLight hidden-sm hidden-md pull-right" data-sparkline-type="line" data-sparkline-height="33px" data-sparkline-width="70px" data-fill-color="transparent">
															${statList }
														</div>
													</div>
													<div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
														<div class="easy-pie-chart txt-color-greenLight" data-percent="<%=capusage %>" data-pie-size="50">
															<span class="percent percent-sign"><%=capusage %> </span>
														</div>
														<span class="easy-pie-title"> 存储使用 <i class="fa fa-caret-down icon-color-good"></i></span>
														<ul class="smaller-stat hidden-sm pull-right">
															<li>
																<span class="label bg-color-blueDark"><i class="fa fa-caret-up"></i>${desktopStat.maxCapacity }G</span>
															</li>
															<li>
																<span class="label bg-color-blue"><i class="fa fa-caret-down"></i>${desktopStat.minCapacity}G</span>
															</li>
														</ul>
														<div class="sparkline txt-color-blue hidden-sm hidden-md pull-right" data-sparkline-type="line" data-sparkline-height="33px" data-sparkline-width="70px" data-fill-color="transparent">
															${desktopStat.recnetTopTenCapUsed }
														</div>
													</div>
													<div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
														<div class="easy-pie-chart txt-color-blue" data-percent="<%=cpuusage %>" data-pie-size="50">
															<span class="percent percent-sign"><%=cpuusage %> </span>
														</div>
														<span class="easy-pie-title"> CPU使用 <i class="fa fa-caret-up icon-color-good"></i></span>
														<ul class="smaller-stat hidden-sm pull-right">
															<li>
																<span class="label bg-color-blueDark"><i class="fa fa-caret-up"></i><fmt:formatNumber value="${desktopStat.maxCpu/desktopStat.cpuAllSpeed }" type="percent" pattern="#0%"/></span>
															</li>
															<li>
																<span class="label bg-color-blue"><i class="fa fa-caret-down"></i> <fmt:formatNumber value="${desktopStat.minCpu/desktopStat.cpuAllSpeed }" type="percent" pattern="#0%"/></span>
															</li>
														</ul>
														<div class="sparkline txt-color-darken hidden-sm hidden-md pull-right" data-sparkline-type="line" data-sparkline-height="33px" data-sparkline-width="70px" data-fill-color="transparent">
															${desktopStat.recentTopTenCpuUsed }
														</div>
													</div>
													<div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
														<div class="easy-pie-chart txt-color-darken" data-percent="<%=memusage %>" data-pie-size="50">
															<span class="percent percent-sign"><%=memusage %> <i class="fa fa-caret-up"></i></span>
														</div>
														<span class="easy-pie-title"> 内存使用 <i class="fa fa-caret-down icon-color-good"></i></span>
														<ul class="smaller-stat hidden-sm pull-right">
															<li>
																<span class="label bg-color-red"><i class="fa fa-caret-up"></i> <fmt:formatNumber value="${desktopStat.maxMemory/desktopStat.memory }" type="percent" pattern="#0%"/></span>
															</li>
															<li>
																<span class="label bg-color-blue"><i class="fa fa-caret-down"></i> <fmt:formatNumber value="${desktopStat.minMemory/desktopStat.memory }" type="percent" pattern="#0%"/></span>
															</li>
														</ul>
														<div class="sparkline txt-color-red hidden-sm hidden-md pull-right" data-sparkline-type="line" data-sparkline-height="33px" data-sparkline-width="70px" data-fill-color="transparent">
															${desktopStat.recnetTopTenMemUsed }
														</div>
													</div>
												</div>

											</div>
											<!-- end s1 tab pane -->

											<div class="tab-pane fade" id="s2">
												<div class="widget-body-toolbar bg-color-white">

													<form class="form-inline" role="form">

														<div class="form-group">
															<label class="sr-only" for="s123">Show From</label>
															<input type="email" class="form-control input-sm" id="s123" placeholder="Show From">
														</div>
														<div class="form-group">
															<input type="email" class="form-control input-sm" id="s124" placeholder="To">
														</div>

														<div class="btn-group hidden-phone pull-right">
															<a class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown"><i class="fa fa-cog"></i> More <span class="caret"> </span> </a>
															<ul class="dropdown-menu pull-right">
																<li>
																	<a href="javascript:void(0);"><i class="fa fa-file-text-alt"></i> Export to PDF</a>
																</li>
																<li>
																	<a href="javascript:void(0);"><i class="fa fa-question-sign"></i> Help</a>
																</li>
															</ul>
														</div>

													</form>

												</div>
												<div class="padding-10">
													<div id="statsChart" class="chart-large has-legend-unique"></div>
												</div>

											</div>
											<!-- end s2 tab pane -->


											<div class="tab-pane fade" id="s3">

												<div class="widget-body-toolbar bg-color-white smart-form" id="rev-toggles">

													<div class="inline-group">

														<label for="gra-0" class="checkbox">
															<input type="checkbox" name="gra-0" id="gra-0" checked="checked">
															<i></i> 分配 </label>
														<label for="gra-1" class="checkbox">
															<input type="checkbox" name="gra-1" id="gra-1" checked="checked">
															<i></i> 活动 </label>
														<label for="gra-2" class="checkbox">
															<input type="checkbox" name="gra-2" id="gra-2" checked="checked">
															<i></i> 最佳 </label>
													</div>

													<div class="btn-group hidden-phone pull-right">
														<a class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown"><i class="fa fa-cog"></i> More <span class="caret"> </span> </a>
														<ul class="dropdown-menu pull-right">
															<li>
																<a href="javascript:void(0);"><i class="fa fa-file-text-alt"></i> Export to PDF</a>
															</li>
															<li>
																<a href="javascript:void(0);"><i class="fa fa-question-sign"></i> Help</a>
															</li>
														</ul>
													</div>

												</div>

												<div class="padding-10">
													<div id="flotcontainer" class="chart-large has-legend-unique"></div>
												</div>
											</div>
											<!-- end s3 tab pane -->
										</div>

										<!-- end content -->
									</div>

								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->

						</article>
					</div>
					<!-- end row -->

					<!-- row -->
					<div class="row">
				
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<!-- Widget ID (each widget will need unique ID)-->
							<div id="myTable1" class="jarviswidget jarviswidget-color-blueDark" class="jarviswidget jarviswidget-color-blueDark"  data-widget-editbutton="false" data-widget-deletebutton="false">
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
								<header>
									<span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;<h2>我的待办</h2></span>
				
								</header>
				
								<!-- widget div-->
								<div>
				
									<!-- widget edit box -->
									<div class="jarviswidget-editbox">
										<!-- This area used as dropdown edit box -->
				
									</div>
									<!-- end widget edit box -->
				
									<!-- widget content -->
									<div class="widget-body no-padding">
										<table class="table table-bordered">
												<thead>
													<tr>
														<th>申请时间</th>
														<th>申请人</th>
														<th>任务类型</th>
														<th class="col-xs-6 col-sm-4 col-md-2 col-lg-2">申请原因</th>
														<th>操作</th>
													</tr>
												</thead>
												<tbody>
												<c:forEach items="${orderList }" var="vo" varStatus="items"> 
													<tr>
														<td><fmt:formatDate value="${vo.ctime.time }" type="date"/></td>
														<td>${vo.username }</td>
														<td>${vo.type }</td>
														<td>${vo.reason }</td>
														<td><a href="${rootUrl }self/todo.do">查看</a></td>
													</tr>
												</c:forEach>
												</tbody>
											</table>
									
									</div>
									<!-- end widget content -->
				
								</div>
								<!-- end widget div -->
				
							</div>
							<!-- end widget -->
							
							<!-- NEW WIDGET START -->
							<div id="myTable2" class="jarviswidget jarviswidget-color-blueDark" data-widget-editbutton="false" data-widget-deletebutton="false">
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
								<header>
									<span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;<h2>告警事件</h2></span>
				
								</header>
				
								<!-- widget div-->
								<div>
				
									<!-- widget edit box -->
									<div class="jarviswidget-editbox">
										<!-- This area used as dropdown edit box -->
				
									</div>
									<!-- end widget edit box -->
				
									<!-- widget content -->
									<div class="widget-body no-padding">
										
										<table class="table table-bordered">
												<thead>
													<tr>
														<th>发生时间</th>
														<th>类型</th>
														<th>节点</th>
														<th>告警级别</th>
														<th>事件描述</th>
														
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${eventList }" var="vo" varStatus="items" begin="1" end="5"> 
													<tr>
														<td>${ vo.lastOccourence}</td>
														<td>${ vo.eventType}</td>
														<td>${ vo.node}</td>
														<td>${vo.severity }</td>
														<td>${vo.description }</td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
									
									</div>
									<!-- end widget content -->
				
								</div>
								<!-- end widget div -->
				
							</div>
							<!-- end widget -->
				
						</article>
						<!-- WIDGET END -->
				
					</div>
					<!-- end row -->

				</section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<!-- END MAIN PANEL -->
		<!--================================================== -->

		
		 

		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
		<script>
			if (!window.jQuery) {
				document.write('<script src="${rootUrl}js/libs/jquery-2.1.1.min.js"><\/script>');
			}
		</script>

		<script>
			if (!window.jQuery.ui) {
				document.write('<script src="${rootUrl}js/libs/jquery-ui-1.10.3.min.js"><\/script>');
			}
		</script>

		<!-- IMPORTANT: APP CONFIG -->
		<script src="${rootUrl}js/app.config.js"></script>
		
		<!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
		<script src="${rootUrl}js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script> 
		
		<!-- BOOTSTRAP JS -->
		<script src="${rootUrl}js/bootstrap/bootstrap.min.js"></script>
		
		<!-- CUSTOM NOTIFICATION -->
		<script src="${rootUrl}js/notification/SmartNotification.min.js"></script>

		<!-- JARVIS WIDGETS -->
		<script src="${rootUrl}js/smartwidgets/jarvis.widget.min.js"></script>

		<!-- EASY PIE CHARTS -->
		<script src="${rootUrl}js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

		<!-- SPARKLINES -->
		<script src="${rootUrl}js/plugin/sparkline/jquery.sparkline.min.js"></script>

		<!-- JQUERY VALIDATE -->
		<script src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>

		<!-- JQUERY MASKED INPUT -->
		<script src="${rootUrl}js/plugin/masked-input/jquery.maskedinput.min.js"></script>

		<!-- JQUERY SELECT2 INPUT -->
		<script src="${rootUrl}js/plugin/select2/select2.min.js"></script>

		<!-- JQUERY UI + Bootstrap Slider -->
		<script src="${rootUrl}js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

		<!-- browser msie issue fix -->
		<script src="${rootUrl}js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

		<!-- FastClick: For mobile devices -->
		<script src="${rootUrl}js/plugin/fastclick/fastclick.min.js"></script>

		<!--[if IE 8]>

		<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>

		<![endif]-->

		<!-- Demo purpose only 
		<script src="${rootUrl}js/demo.min.js"></script>
		-->
		<!-- MAIN APP JS FILE -->
		<script src="${rootUrl}js/app.min.js"></script>

		<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
		<!-- Voice command : plugin -->
		<script src="${rootUrl}js/speech/voicecommand.min.js"></script>
		
		<!-- SmartChat UI : plugin -->
		<script src="${rootUrl}js/smart-chat-ui/smart.chat.ui.min.js"></script>
		<script src="${rootUrl}js/smart-chat-ui/smart.chat.manager.min.js"></script>
		
		<!-- PAGE RELATED PLUGIN(S) -->
		
		<!-- Flot Chart Plugin: Flot Engine, Flot Resizer, Flot Tooltip -->
		<script src="${rootUrl}js/plugin/flot/jquery.flot.cust.min.js"></script>
		<script src="${rootUrl}js/plugin/flot/jquery.flot.resize.min.js"></script>
		<script src="${rootUrl}js/plugin/flot/jquery.flot.time.min.js"></script>
		<script src="${rootUrl}js/plugin/flot/jquery.flot.tooltip.min.js"></script>
		
		<!-- Vector Maps Plugin: Vectormap engine, Vectormap language -->
		<script src="${rootUrl}js/plugin/vectormap/jquery-jvectormap-1.2.2.min.js"></script>
		<script src="${rootUrl}js/plugin/vectormap/jquery-jvectormap-world-mill-en.js"></script>
		
		<!-- Full Calendar -->
		<script src="${rootUrl}js/plugin/moment/moment.min.js"></script>
		<script src="${rootUrl}js/plugin/fullcalendar/jquery.fullcalendar.min.js"></script>
		<script>
		// PAGE RELATED SCRIPTS

			/* chart colors default */
			var $chrt_border_color = "#efefef";
			var $chrt_grid_color = "#DDD"
			var $chrt_main = "#E24913";
			/* red       */
			var $chrt_second = "#6595b4";
			/* blue      */
			var $chrt_third = "#FF9F01";
			/* orange    */
			var $chrt_fourth = "#7e9d3a";
			/* green     */
			var $chrt_fifth = "#BD362F";
			/* dark red  */
			var $chrt_mono = "#000";
			
			$(document).ready(function() {

				// DO NOT REMOVE : GLOBAL FUNCTIONS!
				pageSetUp();

				/* sales chart */

				if ($("#saleschart").length) {
					function getData() {
					var res=[];
					<c:forEach items="${activeDesktopList }" var="ad" varStatus="list">
						var point = ${ad.time};
						var value = ${ad.count};
						res.push([point,value]);
					</c:forEach>
					return res;
					
					}
					
					
					//var d = [[1196463600000, 0], [1196550000000, 0], [1196636400000, 0], [1196722800000, 77], [1196809200000, 3636], [1196895600000, 3575], [1196982000000, 2736], [1197068400000, 1086], [1197154800000, 676], [1197241200000, 1205], [1197327600000, 906], [1197414000000, 710], [1197500400000, 639], [1197586800000, 540], [1197673200000, 435], [1197759600000, 301], [1197846000000, 575], [1197932400000, 481], [1198018800000, 591], [1198105200000, 608], [1198191600000, 459], [1198278000000, 234], [1198364400000, 1352], [1198450800000, 686], [1198537200000, 279], [1198623600000, 449], [1198710000000, 468], [1198796400000, 392], [1198882800000, 282], [1198969200000, 208], [1199055600000, 229], [1199142000000, 177], [1199228400000, 374], [1199314800000, 436], [1199401200000, 404], [1199487600000, 253], [1199574000000, 218], [1199660400000, 476], [1199746800000, 462], [1199833200000, 500], [1199919600000, 700], [1200006000000, 750], [1200092400000, 600], [1200178800000, 500], [1200265200000, 900], [1200351600000, 930], [1200438000000, 1200], [1200524400000, 980], [1200610800000, 950], [1200697200000, 900], [1200783600000, 1000], [1200870000000, 1050], [1200956400000, 1150], [1201042800000, 1100], [1201129200000, 1200], [1201215600000, 1300], [1201302000000, 1700], [1201388400000, 1450], [1201474800000, 1500], [1201561200000, 546], [1201647600000, 614], [1201734000000, 954], [1201820400000, 1700], [1201906800000, 1800], [1201993200000, 1900], [1202079600000, 2000], [1202166000000, 2100], [1202252400000, 2200], [1202338800000, 2300], [1202425200000, 2400], [1202511600000, 2550], [1202598000000, 2600], [1202684400000, 2500], [1202770800000, 2700], [1202857200000, 2750], [1202943600000, 2800], [1203030000000, 3245], [1203116400000, 3345], [1203202800000, 3000], [1203289200000, 3200], [1203375600000, 3300], [1203462000000, 3400], [1203548400000, 3600], [1203634800000, 3700], [1203721200000, 3800], [1203807600000, 4000], [1203894000000, 4500]];
					var d = getData();
					
					
					var options = {
						xaxis : {
							mode : "time",
							tickLength : 1
						},
						yaxis : {
							min:0
						},
						series : {
							lines : {
								show : true,
								lineWidth : 1,
								fill : true,
								fillColor : {
									colors : [{
										opacity : 0.1
									}, {
										opacity : 0.15
									}]
								}
							},
							points: { show: true },
							shadowSize : 0
						},
						selection : {
							mode : "x"
						},
						grid : {
							hoverable : true,
							clickable : true,
							tickColor : $chrt_border_color,
							borderWidth : 0,
							borderColor : $chrt_border_color
						},
						tooltip : true,
						tooltipOpts : {
							content : "<b>采集时间:%x</b> \n <span>活动桌面:%y</span>",
							dateFormat : "%0m-%0d %H:%M",
							defaultTheme : false
						},
						colors : [$chrt_second]

					};

					var plot = $.plot($("#saleschart"), [d], options);
				};

				/* end sales chart */
			});

		</script>
		

	</body>

</html>
