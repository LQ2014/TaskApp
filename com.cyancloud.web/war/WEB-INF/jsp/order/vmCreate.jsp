<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.web.util.CommonUtils"%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="order/delay"/>
</jsp:include>
<%
	List<VResourcePool> poolList = (List<VResourcePool>)request.getAttribute("poolList");
	List<VMachine> templateList = (List<VMachine>)request.getAttribute("templateList");
	String dcode = (String) request.getSession().getAttribute("dcode");
	String dname = (String) request.getSession().getAttribute("dname");
	String uname=(String) request.getSession().getAttribute("ucode");
%>
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
					<li>服务门户</li><li>虚拟机创建</li>
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
				<section id="widget-grid" class="">
				
					<!-- row -->
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
								<header>
									<span>&nbsp;&nbsp;<i class="fa fa-edit"></i>&nbsp;&nbsp;<h2>虚拟机创建</h2></span>
									
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
									<form id="applyForm" class="smart-form" action="${rootUrl }order/doDelay.do" method="post" onsubmit="return check();">
										<input type="hidden" name="unitOu" value="<%=dcode %>">
										<input type="hidden" id="poolName" value="">
											<fieldset>
												<section class="form-group col-md-12">
													<div class="col-md-3"></div>
													<label class="col-md-1 control-label">虚拟机名称</label>
													<div class="col-md-5">
														<input class="form-control" type="text" name="vmName" id="vmName">
													</div>
												</section>
												<section class="form-group col-md-12">
													<div class="col-md-3"></div>
													<label class="col-md-1 control-label">数据中心名称</label>
													<div class="col-md-5">
														<input class="form-control" type="text" name="dcName" id="dcName" value="Cyanway-Demo">
													</div>
												</section>
												<section class="form-group col-md-12">
													<div class="col-md-3"></div>
													<label class="col-md-1 control-label">资源池</label>
													<div class="col-md-5">
														<select class="form-control" id="poolId" name="poolId">
															<%if(poolList != null && poolList.size() > 0) {
																for(int i=0;i<poolList.size();i++) {
																	VResourcePool pool = (VResourcePool)poolList.get(i);
															%>
															
															<option value="<%=pool.elementId%>"><%=pool.name%></option>
															<%
																}
															}%>
														</select>
													</div>
												</section>
												<section class="form-group col-md-12">
													<div class="col-md-3"></div>
													<label class="col-md-1 control-label">模板</label>
													<div class="col-md-5">
														<select class="form-control" id="templateId" name="templateId">
															<%if(templateList != null && templateList.size() > 0) {
																for(int i=0;i<templateList.size();i++) {
																	VMachine template = (VMachine)templateList.get(i);
															%>
															
															<option value="<%=template.elementId%>"><%=template.name%></option>
															<%
																}
															}%>
														</select>
													</div>
												</section>
											</fieldset>
											<footer>
												<button type="submit" class="btn btn-primary">提交</button>
												&nbsp;
												<button class="btn btn-default" type="reset">重置</button>
											</footer>
										</form>
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

		
		

		<!-- MAIN APP JS FILE -->
		<script src="${rootUrl}js/app.min.js"></script>

		<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
		<!-- Voice command : plugin -->
		<script src="${rootUrl}js/speech/voicecommand.min.js"></script>

		<!-- PAGE RELATED PLUGIN(S)
		<script src="..."></script> -->
		

		<script type="text/javascript">
		
		// DO NOT REMOVE : GLOBAL FUNCTIONS!
		
		$(document).ready(function() {
			
			pageSetUp();

			// PAGE RELATED SCRIPTS
		
			// class switcher for radio and checkbox
			/* $('input[name="demo-switcher-1"]').change( function() {
				  //alert($(this).val())
				  $this = $(this);
				  
				  myNewClass = $this.attr('id');
				  
				  $('.demo-switcher-1 input[type="checkbox"]').removeClass();
				  $('.demo-switcher-1 input[type="checkbox"]').addClass("checkbox "+ myNewClass);
				  
				  $('.demo-switcher-1 input[type="radio"]').removeClass();
				  $('.demo-switcher-1 input[type="radio"]').addClass("radiobox "+ myNewClass);
			  
			}) */
		
		})

		</script>

		

	</body>

</html>
