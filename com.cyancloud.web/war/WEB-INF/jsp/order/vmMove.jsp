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
					document.getElementById("cpuNum").value = "";
		       		document.getElementById("memory").value = "";
	        		document.getElementById("totalCapacity").value = "";
	        		document.getElementById("fullPathName").value = "";
					document.getElementById("ipAddress").value = "";
					document.getElementById("osType").value = "";
	        		return
				}
				document.getElementById("fullPathName").value = vmmap[vm_id].fullPathName;
				document.getElementById("ipAddress").value = vmmap[vm_id].ipAddress;
				document.getElementById("osType").value = vmmap[vm_id].osType;
				document.getElementById("cpuNum").value = vmmap[vm_id].cpuNum;
		        document.getElementById("memory").value = vmmap[vm_id].memory/1024;
	        	document.getElementById("totalCapacity").value = parseInt(vmmap[vm_id].totalCapacity/1024);
			}
			
			function check() {
        		var vm_id = document.getElementById('vm_id').value;
        		var move_path = document.getElementById('move_path').value;
        		if(vm_id == '0' || move_path == '') {
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
					<li>服务门户</li><li>虚拟机迁移</li>
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
									<span>&nbsp;&nbsp;<i class="fa fa-edit"></i>&nbsp;&nbsp;<h2>虚拟机迁移</h2></span>
									
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
													<section class="col col-6">
														<label class="label">IP</label>
														<label class="input">
																<input type="text" name="ipAddress" id="ipAddress" readonly style="background:#cccccc">
														</label>
													</section>
												</div>
												<div class="row">
													<section class="col col-6">
														<label class="label">操作系统</label>
														<label class="input">
																<input type="text" name="osType" id="osType" readonly style="background:#cccccc">
														</label>
													</section>
													<section class="col col-6">
														<label class="label">CPU</label>
														<label class="input">
																<input type="text" name="cpuNum" id="cpuNum" readonly style="background:#cccccc">
														</label>
													</section>
												</div>
												<div class="row">
													<section class="col col-6">
														<label class="label">内存</label>
														<label class="input">
																<input type="text" name="memory" id="memory" readonly style="background:#cccccc">
														</label>
													</section>
													<section class="col col-6">
														<label class="label">硬盘</label>
														<label class="input">
																<input type="text" name="totalCapacity" id="totalCapacity" readonly style="background:#cccccc">
														</label>
													</section>
												</div>
												<div class="row">
													<section class="col col-6">
														<label class="label">存储地址</label>
														<label class="input">
																<input type="text" name="fullPathName" id="fullPathName" readonly style="background:#cccccc">
														</label>
													</section>
												</div>
												<div class="row">
													<section class="col col-6">
														<label class="label">迁移至</label>
														<label class="input">
																<input type="text" name="move_path" id="move_path">
														</label>
													</section>
												</div>
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
