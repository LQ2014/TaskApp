<%@page import="com.cyancloud.service.model.AccountBean"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.service.model.*"%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="order/transfer"/>
</jsp:include>
<%
	List<DesktopBean> desktopList = (List<DesktopBean>)request.getAttribute("desktopList");
	List<AccountBean> userList = (List<AccountBean>)request.getAttribute("userList");
	String dcode = (String) request.getSession().getAttribute("dcode");
	String dname = (String) request.getSession().getAttribute("dname");
	String uname=(String) request.getSession().getAttribute("ucode");
%>
<!DOCTYPE html>
<html lang="en-us">
		<script type="text/javascript">
		
			function NewDate(str) { 
				str = str.split(' '); 
				var year = str[0].split('-');
				var time = str[1].split(':');
				console.log(str);
				var date = new Date(); 
				date.setUTCFullYear(year[0], year[1] - 1, year[2]); 
				date.setUTCHours(time[0]-8,time[1],time[2],0); 
				return date; 
			} 
			function changeInfo() {
				var obj = document.getElementById("desktopId");
				var desktopId = obj.options[obj.selectedIndex].value;
				if(desktopId==-1){
					document.getElementById("cpu").value = "";
		        	document.getElementById("memory").value = "";
		        	document.getElementById("expireTime_view").innerHTML = "";
		        	document.getElementById("expireTime").value = "";
					return ;
				}
    			var cpu = '';
    			var memory = '';  
    			var capacity = ''; 
    			var desktopId = document.getElementById("desktopId").value;
    			if(desktopId != '0') {
    				$.ajax({
	        		url:"${rootUrl }desktop/getDesktopBeanById.do?desktopId="+desktopId,
	        		dataType:"json",
	        		success:function(data){
		        		$.each(data,function(i,p){
		        	    	cpu = p['cpu'];
		        	    	memory = p['memory'];
		        	    	expireTime = p['expireTime'];
		        	    	expireTime_view = p['expireTime_view'];
		        		});
		        		document.getElementById("cpu").value = cpu;
		        		document.getElementById("memory").value = memory;
		        		document.getElementById("expireTime_view").innerHTML = expireTime_view;
		        		document.getElementById("expireTime").value = NewDate(expireTime);
	        		}
        		}); 
    			}
				
			}
			
			function check() {
        		var desktopId = document.getElementById('desktopId').value;
        		var reason = document.getElementById('reason').value;
        		if(desktopId == '0' || reason == '') {
        			alert('操作提示：请补全信息!');
        			return false;
        		}
        		return true;
			}
			
		</script>
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
					<li>服务门户</li><li>桌面转移</li>
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
									<span>&nbsp;&nbsp;<i class="fa fa-edit"></i>&nbsp;&nbsp;<h2>转移桌面</h2></span>
									
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
									<form id="applyForm" class="smart-form" action="${rootUrl }order/doTransfer.do" method="post" onsubmit="return check();">
										<input type="hidden" name="unitOu" value="<%=dcode %>">
										<input type="hidden" name="expireTime" id="expireTime">
											<fieldset>
												<div class="row">
												<section class="col col-6">
													<label class="label">申请人</label>
													<label class="input">
															<input type="text" name="uname" id="uname" readonly style="background:#cccccc" value="<%=uname %>">
													</label>
												</section>
													<section class="col col-6">
														<label class="label">申请部门</label>
														<label class="input">
															<input type="text" name="dname" id="dname" readonly style="background:#cccccc" value="${dname }">
													</label>
															
													</section>
													
												</div>
												<div class="row">
													<section class="col col-6">
														<label class="label">桌面</label>
														<label class="input">
														<select class="form-control" name="desktopId" id="desktopId"  onchange="changeInfo()">
															<option value="-1">请选择</option>
															<%if(desktopList != null && desktopList.size() > 0) {
																for(int i=0;i<desktopList.size();i++) {
																DesktopBean bean = desktopList.get(i);
															%>
																<option value="<%=bean.getElementId()%>"><%=bean.getName()%></option>
															<%
																}
															}%>
														</select>
													</label>
													</section>
													<section class="col col-6">
														<label class="label">CPU</label>
														<label class="input">
															<input type="text" name="cpu" id="cpu" readonly style="background:#cccccc" >
														</label>
													</section>
												</div>
												<div class="row">
													<section class="col col-6">
														<label class="label">内存(GB)</label>
														<label class="input">
															<input type="text" name="memory" id="memory" readonly style="background:#cccccc" >
														</label>
													</section>
												</div>
												<div class="row">
												<section class="col col-6">
													<label class="label">到期时间</label>
													<label class="label" id="expireTime_view"></label>
													
												</div>
												
												<div class="row">
												<section class="col col-6">
													<label class="label">接收人</label>
														<label class="input">
														<select class="form-control" name="templateDesc" id="templateDesc" >
															<%if(userList != null && userList.size() > 0) {
																for(int i=0;i<userList.size();i++) {
																Account account = userList.get(i);
																if(!account.getUcode().equalsIgnoreCase(uname)){
															%>
																<option value="<%=account.getId()%>"><%=account.getUname()%></option>
															<%}
																}
															}%>
														</select>
												</section>
													
												</div>
												
												<section>
													<label class="label">原因</label>
													<label class="textarea">
														<textarea rows="4" name="reason" id="reason"></textarea>
													</label>
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
