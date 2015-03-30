<%@page import="com.cyancloud.service.model.AccountBean"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.service.model.*,com.cyancloud.model.vm.*,net.sf.json.*"%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="order/vmDilatation"/>
</jsp:include>
<%
	List<VMachine> vMachineList = (List<VMachine>)request.getAttribute("vMachineList");
	Map<Long,VMachine> vMachineMap = (Map<Long,VMachine>)request.getAttribute("vMachineMap");
	String dcode = (String) request.getSession().getAttribute("dcode");
	String dname = (String) request.getSession().getAttribute("dname");
	String uname=(String) request.getSession().getAttribute("ucode");
%>
<!DOCTYPE html>
<html lang="en-us">
		<script type="text/javascript">
			function changeInfo(param) {
				var obj = document.getElementById("vm_id");
				var vm_id = obj.options[obj.selectedIndex].value;
				var vmmap = <%=JSONObject.fromObject(vMachineMap).toString()%>;
				if(vm_id==0){
					document.getElementById("vmcpu").value = "";
		       		document.getElementById("vmmemory").value = "";
	        		document.getElementById("totalCapacity").value = "";
	        		return
				}
				document.getElementById("vmcpu").value = vmmap[vm_id].cpuNum;
		        document.getElementById("vmmemory").value = vmmap[vm_id].memory/1024;
	        	document.getElementById("totalCapacity").value = parseInt(vmmap[vm_id].totalCapacity/1024);
			}
			
			function check() {
        		var vm_id = document.getElementById('vm_id').value;
        		var reason = document.getElementById('reason').value;
        		if(vm_id == '0' || reason == '') {
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
					<li>服务门户</li><li>虚拟机扩容</li>
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
									<span>&nbsp;&nbsp;<i class="fa fa-edit"></i>&nbsp;&nbsp;<h2>虚拟机扩容</h2></span>
									
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
									<form id="applyForm" class="smart-form" style="margin-left:100px;margin-right:100px;"action="" method="post" onsubmit="return check();">
										<input type="hidden" name="unitOu" value="<%=dcode %>">
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
														<label class="label">虚拟机</label>
														<label class="input">
														<select class="form-control" name="vm_id" id="vm_id"  onchange="changeInfo()">
															<option value="0">请选择</option>
															<%if(vMachineList != null && vMachineList.size() > 0) {
																for(int i=0;i<vMachineList.size();i++) {
																VMachine vm = vMachineList.get(i);
															%>
																<option value="<%=vm.getElementId()%>"><%=vm.getName()%></option>
															<%
																}
															}%>
														</select>
													</label>
													</section>
												</div>
												<div class="row">
													<section class="col col-1">
														<label style="margin-top:6px;width:50px">CPU(个)</label>
													</section>
													<section class="col col-2">
														<label class="input">
															<input type="text" name="vmcpu" id="vmcpu" readonly style="background:#cccccc" >
														</label>
													</section>
													<section class="col col-1">
														<label style="margin-top:6px;">请选择</label>
													</section>
													<section class="col col-2">
														<label class="input">
															<select class="form-control" name="cpu" id="cpu" >
																<option value="1">1</option>
																<option value="2">2</option>
																<option value="4">4</option>
															</select>
														</label>
													</section>
												</div>
												<div class="row">
													<section class="col col-1">
														<label style="margin-top:6px;width:50px">内存(G) </label>
													</section>
													<section class="col col-2">
														<label class="input">
															<input type="text" name="vmmemory" id="vmmemory" readonly style="background:#cccccc" >
														</label>
													</section>
													<section class="col col-1">
														<label style="margin-top:6px">请选择</label>
													</section>
													<section class="col col-2">
														<label class="input">
															<select class="form-control" name="memory" id="memory">
																<option value="1">1</option>
																<option value="2">2</option>
																<option value="4">4</option>
																<option value="8">8</option>
															</select>
														</label>
													</section>
												</div>
												<div class="row">
													<section class="col col-1">
														<label style="margin-top:6px;width:50px">存储(G) </label>
													</section>
													<section class="col col-2">
														<label class="input">
															<input type="text" name="totalCapacity" id="totalCapacity" readonly style="background:#cccccc" >
														</label>
													</section>
													<section class="col col-1">
														<label style="margin-top:6px">请选择</label>
													</section>
													<section class="col col-2">
														<label class="input">
															<select class="form-control" name="memory" id="memory">
																<option value="50">50</option>
																<option value="100">100</option>
																<option value="200">200</option>
																<option value="300">300</option>
																<option value="500">500</option>
																<option value="1024">1024</option>
															</select>
														</label>
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

		<script type="text/javascript">
		
		$(document).ready(function() {
			
			pageSetUp();
		
		})

		</script>
	</body>
</html>
