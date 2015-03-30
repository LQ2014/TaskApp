<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.web.util.CommonUtils"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="vm/listMachine";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<%
	List<VMachine> vMachineList = (List<VMachine>)request.getAttribute("vMachineList");
	List<VResourcePool> poolList = (List<VResourcePool>)request.getAttribute("poolList");
	List<VMachine> templateList = (List<VMachine>)request.getAttribute("templateList");
%>
<!DOCTYPE html>
<html lang="en-us">
		<script type="text/javascript" language="javascript">
			function check() {
		   		var vmName = document.getElementById('vmName').value;
		   		var dcName = document.getElementById('vmName').value;
		   		var poolId = document.getElementById('poolId').value;
		   		var templateId = document.getElementById('templateId').value;
		   		if(vmName != '' && dcName != '' && poolId != '' && templateId != '') {
		   			return true;
		   		} else {
		   			alert('操作提示:请补全信息!');
		   			return false;
		   		}
		   		
    		}
		</script>
		<style>
		.centre{
		position:absolute;
		margin-left:25%;
		}
		.btn-link-underline{
		width:100%;
		text-align:left;
		color:black;
		}
		.btn-link-underline:hover{
		text-decoration:none;
		background:#104E8B;
		color:white;
		}
		</style>
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
						虚拟机管理
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
									<table id="datatable_tabletools"
										class="table table-striped table-bordered table-hover"
										width="100%"  >
										<thead>
											<tr>
												<th>
													序号
												</th>
												<th>
													机器名称
												</th>
												<th>
													开机状态
												</th>
												<th>
													操作系统
												</th>
												<th>
													CPU核数(个)
												</th>
												<!-- 
												<th>
													CPU使用(MHZ)
												</th>
												 -->
												<th>
													置备内存(MB)
												</th>
												<!-- 
												<th>
													内存使用(MB)
												</th>
												
												<th class="col-xs-6 col-sm-4 col-md-2 col-lg-3">
													已用存储空间(GB) / 置备存储空间(GB)
												</th>  -->
												<th>
													用户
												</th>
												<th>
													有效期
												</th>
												<th>
													状态
												</th>
												<th class="col-lg-2">
													操作
												</th>
											</tr>
										</thead>
										<tbody>
										<%for(int i =0;vMachineList!=null && i<vMachineList.size();i++){
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
													<div>
													<%if(vMachine.powerStatus.equals("poweredOn")) {%>已开启<%}%>
													<%if(vMachine.powerStatus.equals("poweredOff")) {%>已关闭<%}%>
													<%if(vMachine.powerStatus.equals("suspended")) {%>已休眠<%}%>
													<%if(vMachine.powerStatus.equals("suspending")) {%>正在休眠<%}%>
													<%if(vMachine.powerStatus.equals("starting")) {%>正在开启<%}%>
													<%if(vMachine.powerStatus.equals("stopping")) {%>正在关闭<%}%>
													<%if(vMachine.powerStatus.equals("restarting")) {%>正在重启<%}%>
													</div>
												</td>
												<td>
													<%=vMachine.osType%>
												</td>
												<td>
													<%=vMachine.cpuNum %>
												</td>
												<!-- 
												<td>
													<span class="sparkline txt-color-green" data-sparkline-type="line" data-sparkline-width="80px" data-fill-color="transparent" data-sparkline-spotradius="3" data-sparkline-height="15px"><%=vMachine.recentTenCpuUsed %></span>
												</td>
												 -->
												<td>
													<%=vMachine.memory %>
												</td>
												<!-- 
												<td>
													<span class="sparkline txt-color-green" data-sparkline-type="line" data-sparkline-width="80px" data-fill-color="transparent" data-sparkline-spotradius="3" data-sparkline-height="15px"><%=vMachine.recentTenMemUsed %></span>
												</td>
												 -->
<%-- 												<td>
													<div class="progress" style="margin-bottom:0px;height:18px">
														<div class="progress-bar bg-color-blue" style="width: <%=percent %>%;"></div>
														<span class="pull-right"><%=usedCap%>/<%=totalCap%></span>
													</div>
												</td> --%>
												<td>
													<%if(vMachine.getOwner()!=null){%>
													<%=vMachine.getOwner() %><%}else{ %>
													<%="" %>
													<%} %>
												</td>
												<td>
													<%if(vMachine.getExpireDate()!=null){
													SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd ");
            										 String a2=sdf.format(vMachine.getExpireDate());%>
													<%=a2 %>
													<%} %>
												</td>
												<td>
													<%if(vMachine.powerStatus.equals("poweredOn")) {%>
													<img src="${rootUrl}/img/event-<%=vMachine.status.toLowerCase()%>.png" alt="活动（图标）" style="height: 12px; width: 12px; "/><%}%>
												</td>
												<td>
													<%if(vMachine.powerStatus.equals("poweredOn")) {%>
														<button class="btn bg-color-yellow txt-color-white" onclick="powerOff('<%=vMachine.name %>')">关机</button>

															<!-- <button class="btn bg-color-blue txt-color-white" onclick="operate()">更多操作</button> -->
														<div class="btn-group">
															   <button type="button" class="btn btn-primary dropdown-toggle" 
															      data-toggle="dropdown">
															      	更多操作 <span class="caret"></span>
															   </button>
															   <ul class="dropdown-menu" role="menu" style="width:10px;">
															      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="window.open('${rootUrl }vm/connect.do?instId=<%=vMachine.instId %>')">控制台</a></li>
															      <li class="divider"></li>
															      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0"  onclick="powerRest('<%=vMachine.name %>')">休眠</a></li>
															      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="powerRestart('<%=vMachine.name %>')" style="text-decoration:none;">重启</a></li>
															      <li class="divider"></li>
															      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="createSnapshot('<%=vMachine.instId%>');">创建快照</a></li>
															      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="restoreSnapshot('<%=vMachine.name %>','<%=vMachine.elementId%>','<%=vMachine.instId%>');">还原快照</a></li>
															      
															   </ul>
														</div>
													<%}if(vMachine.powerStatus.equals("poweredOff")) {%>
														<button class="btn bg-color-green txt-color-white" onclick="powerOn('<%=vMachine.name %>')">开机</button>
														<div class="btn-group">
															   <button type="button" class="btn btn-primary dropdown-toggle" 
															      data-toggle="dropdown">
															      	更多操作 <span class="caret"></span>
															   </button>
															   <ul class="dropdown-menu" role="menu">
															      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="toTemplate('<%=vMachine.name %>')" style="text-decoration:none;">转化为模板</a></li>
															      <li class="divider"></li>
															      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="createSnapshot('<%=vMachine.instId %>');" style="text-decoration:none;">创建快照</a></li>
															      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="restoreSnapshot('<%=vMachine.name %>','<%=vMachine.elementId%>','<%=vMachine.instId%>');" style="text-decoration:none;">还原快照</a></li>
															   </ul>
														</div>
													<%}if(vMachine.powerStatus.equals("suspended")) {%>
														<button class="btn bg-color-green txt-color-white" onclick="powerOn('<%=vMachine.name %>')">开机</button>
														<div class="btn-group">
																   <button type="button" class="btn btn-primary dropdown-toggle" 
																      data-toggle="dropdown">
																      	更多操作 <span class="caret"></span>
																   </button>
																   <ul class="dropdown-menu" role="menu">
																      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="powerOff('<%=vMachine.name %>')" style="text-decoration:none;">关机</a></li>
																      <%-- <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="powerRestart('<%=vMachine.name %>')" style="text-decoration:none;">唤醒</a></li> --%>
																   </ul>
														</div>
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
		<div id="addMachineDialog" style="display:none;margin:0;">
			<form id ="addMachineForm" class="form-horizontal" method="post" onsubmit="return check()" >
				<fieldset>
					<div class="form-group">
						<label class="col-md-2 control-label">虚拟机名称</label>
						<div class="col-md-10">
							<input class="form-control" type="text" name="vmName" id="vmName">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">数据中心名称</label>
						<div class="col-md-10">
							<input class="form-control" type="text" name="dcName" id="dcName" value="Cyanway-Demo">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">资源池</label>
						<div class="col-md-10">
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
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">模板</label>
						<div class="col-md-10">
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
					</div>
				</fieldset>
			</form>
			</div>
		<div id="power" style="display:none;margin:0;">
			<div id="power-message">
				
			</div>
		</div>
		
		<!-- 弹出窗口 -->
		<div id="addsnapshot" style="display:none;margin:0;">
				<form class="form-horizontal" action="" id="adds" method="post">
					<fieldset>
						<div class="form-group">
							<label class="col-md-2 control-label">名称</label>
							<div class="col-md-9">
								<input class="form-control required" type="text" name="name" id="name">
							</div>
						</div>					
						<div class="form-group">
							<label class="col-md-2 control-label">说明</label>
							<div class="col-md-9">
								<textarea class="form-control required" type="text" name="description" id="description" rows="8" ></textarea>
							</div>
						</div>
					</fieldset>
				</form>
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
		<script src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>
		<script src="${rootUrl}js/plugin/jquery-validate/messages_zh.js"></script>

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
	
	function createVM() {
     			var html ='<div id="dialog-window" title="新增虚拟机"><iframe id="myFrame" src="${rootUrl}vm/loadVMachineView.do" frameBorder="0" style="border: 0; " scrolling="no"  class="col-lg-12" height="100%"></iframe></div>';
			    $(html).dialog($.extend({
			      modal: true,
			      width:660,
			      height:515,
			      closeOnEscape: false,
			      draggable: true,
			      resizable: false,
			      close: function(event, ui) {
			        $(this).dialog("destroy"); // 关闭时销毁
			      },
			      buttons : [{
					html : "取消",
					"class" : "btn btn-default",
					click : function() {
						//关闭当前Dialog 
						$(this).dialog("close");
					}
				}, {
					html : "确定",
					"class" : "btn btn-primary",
					click : function(btn) {
						$(this).dialog("close");
					}
				}]
			      
								      
			    }));
    		}
	function powerOff(name){
		$("#power-message").html("<h3>确认关机？<h3>")  ;
		$("#power").dialog("open");
		$("#power").dialog({height:210,width:300});
		$("#power").dialog({url:"${rootUrl}vm/vmPowerOff.do?VM_name="+name});
	}
	function powerRest(name){
		$("#power-message").html("<h3>确认休眠？<h3>")  ;
		$("#power").dialog("open");
		$("#power").dialog({height:210,width:300});
		$("#power").dialog({url:"${rootUrl}vm/vmPowerRest.do?VM_name="+name});
	}
	function powerOn(name){
		$("#power-message").html("<h1>确认开机？<h1>")  ;
		$("#power").dialog("open");
		$("#power").dialog({height:210,width:300});
		$("#power").dialog({url:"${rootUrl}vm/vmPowerOn.do?VM_name="+name});
	}
	function powerRestart(name){
		$("#power-message").html("<h1>确认唤醒？<h1>")  ;
		$("#power").dialog("open");
		$("#power").dialog({height:210,width:300});
		$("#power").dialog({url:"${rootUrl}vm/vmPowerRestart.do?VM_name="+name});
	}
	function toTemplate(name){
		$("#power-message").html("<h3>当前虚拟机将转化为模板并从虚拟机列表中删除,确认转化为模板？<h3>");
		$("#power").dialog("open");
		$("#power").dialog({height:230,width:350});
		$("#power").dialog({url:"#"});
	}
	function createSnapshot(instId){
		$("#addsnapshot").dialog("open");
		$("#addsnapshot").dialog({height:350,width:450});
	    $("#addsnapshot").dialog({url:"${rootUrl}vm/createSnapshot.do?vmInst="+instId});
	}
	function restoreSnapshot(vmName,vmId,instId){
				var html ='<div id="dialog-window" title='+vmName+'虚拟机><iframe id="myFrame" src="${rootUrl}vm/selectSnapshot.do?vmId='+vmId+'&instId='+instId+'" frameBorder="0" style="border: 0;" scrolling="no" class="col-xs-12" height="100%"></iframe></div>';
			    return $(html).dialog($.extend({
			      modal: true,
			      width:600,
			      height:400,
			      closeOnEscape: false,
			      draggable: true,
			      resizable: false,
			      close: function(event, ui) {
			        $(this).dialog("destroy"); // 关闭时销毁
			      },
			      buttons : [{
					html : "取消",
					"class" : "btn btn-default",
					click : function() {
						//关闭当前Dialog 
						$(this).dialog("close");
					}
				}, {
					html : "确定",
					"class" : "btn btn-primary",
					click : function(btn) {
					   var myW=document. getElementById("myFrame").contentWindow;			
					   var radios=myW.document.getElementsByName("vs");
					  var number=-1;
							  for ( var i = 0; i < radios.length; i++) {
								  if (radios[i].checked==true) {
								  number=i;
								   }
							  }
							   var vmInstv=myW.document.getElementById("vmInstV").innerHTML;
							  if(number>-1){	  
							  	$.ajax({
							        	url:"${rootUrl}vm/restoreSnapshot.do?vmInst="+vmInstv+"&snapInst="+radios[number].value,
							        	type: "get",	
							        	success:function(data){	
							        		window.location.href="${rootUrl}vm/listMachine.do";
							        	}
						        	});
							  }else{
							  alert("该快照不能被还原");
							  }
					$(this).dialog("close");
					}
				}]
			      
								      
			    }));
	}
	$(document).ready(function() {
		pageSetUp();
			$("#addsnapshot").validate();
		/* BASIC ;*/
		var responsiveHelper_datatable_tabletools = undefined;

		var breakpointDefinition = {
			tablet : 1024,
			phone : 480
		};
			
		
		$('#datatable_tabletools').dataTable({
			// Tabletools options: 
			//   https://datatables.net/extensions/tabletools/button_options
			"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"
				+ "t"
				+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
			"oTableTools" : {
			"aButtons" : [{
				"sExtends" : "text",
				"sButtonText": "新增",
				"fnClick":function(nButton, oConfig, oFlash){
					createVM();
					/* $("#addMachineDialog").dialog("open");
					document.getElementById("addMachineForm").reset(); 
					$("#addMachineDialog").dialog({"title": "新增"});
					document.getElementById("addMachineForm").action = "${rootUrl }vm/addMachine.do"; */
				}
			}],
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
				responsiveHelper_datatable_tabletools.createExpandIcon(nRow);
			},
			"drawCallback" : function(oSettings) {
				responsiveHelper_datatable_tabletools.respond();
			}
		}); 
		/* END TABLETOOLS */
		$("#addMachineDialog").dialog({
			autoOpen : false,
			modal : true,
			height:350, 
			width:640, 
			buttons : [{
				html : "取消",
				"class" : "btn btn-default",
				click : function() {
				$(this).dialog("close");
				}
			}, {
				html : "<i class='fa fa-check'></i>&nbsp; 保存",
				"class" : "btn btn-primary",
				click : function() {
					$("#addMachineForm").submit();
				}
			}]
						
		});
						
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
		$("#addsnapshot").dialog({
					autoOpen : false,
					modal : true,
					draggable:false,
					position:"center",
					resizable :false,
					title : "创建快照",
					height:350, 
					width:450, 
					buttons : [{
						html : "取消",
						"class" : "btn btn-default",
						click : function() {
							$(this).dialog("close");
						}
					}, {
						html : "保存",
						"class" : "btn btn-primary",
						click : function() {		
							var frm=document.getElementById("adds");
						if($(frm).valid()){
						        	var name=document.getElementById("name").value;
						        	var description=document.getElementById("description").value;
						        	var urla=$("#addsnapshot").dialog("option","url")+"&snapName="+name+"&snapDescription="+description;
						        	$.ajax({
							        	url:urla,
							        	type: "get",	
							        	success:function(data){	
							        		window.location.href="${rootUrl}vm/listMachine.do";
							        	}
						        	});
						        	$(this).dialog("close");
						     }
						}
					}]
				});

	});
</script>
	</body>

</html>
