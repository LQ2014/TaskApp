<%@page import="net.sf.json.JSONArray"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.cyancloud.service.model.MailBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="system/configEmail";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path%>"/>
</jsp:include>

<%
	MailBean mail=(MailBean)request.getAttribute("mail");	
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
					<li>系统管理</li><li>邮件服务设置</li>
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
				<section id="widget-grid" class=""> <!-- row -->
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
						<header> <span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;
							<h2>
								邮件服务设置
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
                <br><br>
                <!-- STATS CONTAINER -->
                <div class="container">

			   <div class="row">
				  <div>通过设置邮件服务器，可在申请流程完成时，采用自动发邮件的通知远程用户</div>
				  <div class="col-md-1"></div>
			      <div class="col-md-5" >
			         <form id="cfg-mail" class="form-horizontal" role="form" action="${rootUrl}system/useConfigEmail.do" method="post">
			         <br>
						   <div class="form-group">
						   
						      <label for="smtpService" class="col-sm-3 control-label text-left"><span style="color:red">*</span>SMTP服务器</label>
						      <div class="col-sm-9">
						      <%if(mail.getHost()!=null) %>
						         <input type="text" name="host" class="form-control text-left required" id="smtpService" 
						            placeholder="" value="<%=mail.getHost()%>">
						            
						      </div>
						   </div>
						   <div class="form-group">
						      <label for="port" class="col-sm-3 control-label text-left"><span style="color:red">*</span>端口</label>
						      <div class="col-sm-9">
						      <%if(mail.getPort()!=null) %>
						         <input type="text" name="port" class="form-control text-left required digits" id="port" 
						            placeholder="" value="<%=mail.getPort()%>">
						            
						      </div>
						   </div>
						   <div class="form-group">
						      <label for="name" class="col-sm-3 control-label text-left">用户名</label>
						      <div class="col-sm-9">
						      <%if(mail.getUser()!=null) %>
						         <input type="text" name="user" class="text-left form-control required email" id="name" 
						            placeholder="" value="<%=mail.getUser()%>">
						            
						      </div>
						   </div>
						   <div class="form-group">
						      <label for="password" class="col-sm-3 control-label text-left">密码</label>
						      <div class="col-sm-9">
						      <%if(mail.getPassword()!=null) %>
						         <input type="password" name="password" class="form-control text-left required" id="password" 
						            placeholder="**" value="<%=mail.getPassword()%>">
						            
						      </div>
						   </div>
						   <div class="form-group">
						      <div class="col-sm-offset-5 col-sm-6">
						         <button id="testButton" type="button" class="btn btn-default bg-color-blue txt-color-white" onclick="test()")>测试</button>
						         &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
						         <button type="submit" class="btn btn-default bg-color-blue txt-color-white" onclick="use()">应用</button>
						      </div>
						   </div>
						 
						</form>
						
			      </div>
				  <div class="col-md-1"></div>
			      <div class="col-md-4">
			         <h4></h4>
			         <div>步骤<br>
			         1、设置邮箱服务器参数<br>
			         “SMTP服务器”：SMPT（Simple Mail Transfer Protocol）邮件服务器的IP地址。
			                           设置SMTP服务器的用户名和密码。<br>
			         2、测试设置的正确性<br>
			         	点击“测试”，检测与该邮箱服务器是否连通，系统将会弹出连通与否的提示信息。在测试连接服务器时，如输入的参数有误，系统可能反应较慢，需等待一会儿。<br>
			         3、单击“应用”
			        
			        </div>
					
			      </div>
				  
			   </div>
			<!-- END ROW -->

			<div id="faileL" style="color:red;display:none">连接测试失败，STMP服务器无法连通</div>	
			<div id="successL" style="color:green;display:none">STMP服务器连接成功</div>	
			</div>
			<!-- END CONTAINER -->
			</div>
							<!-- end widget content -->

						</div>
						<!-- end widget div -->

					</div>
					<!-- end widget --> </article>
					<!-- WIDGET END -->
			</div>
			<!-- END RIBBON -->
			</div>
			

		</div>
		<!-- END MAIN PANEL -->
		<!-- 测试窗口 -->
			
		<!--================================================== -->

		<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)-->
		 

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

		<!-- SPARKLINES -->
		<script src="${rootUrl}js/plugin/sparkline/jquery.sparkline.min.js"></script>

		<!-- JQUERY VALIDATE -->
		<script src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>
		<script src="${rootUrl}js/plugin/jquery-validate/messages_zh.js"></script>

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

		<!-- Demo purpose only -->
		

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
		//将form转为AJAX提交
		function ajaxSubmit(frm) {
			//提交前检查
			
			if($(frm).valid()) {
				var dataPara = getFormJson(frm); 
	    		$.ajax({
	        		url: frm.action,	
	        		type: frm.method,
	        		data: dataPara,
	        		success:function(){
	
	        		}
	        		
	    		});
			}
		}

		//将form中的值转换为键值对。
		function getFormJson(frm) {
	    	var o = {};
	    	var a = $(frm).serializeArray();
	    	$.each(a, function () {
	        	if (o[this.name] !== undefined) {
	           		if (!o[this.name].push) {
	              		o[this.name] = [o[this.name]];
	           		}
	           		o[this.name].push(this.value || '');
	        	} else {
	            	o[this.name] = this.value || '';
	        	}
	    	});
	    	return o;
		}
		function use(){
			ajaxSubmit($("#cfg-mail"));			
		}
		function test() {
			var frm=document.getElementById("cfg-mail");
			if($(frm).valid()) { 
			 var html ='<div id="dialog-window" title="测试邮件"><iframe id="testWin" src="${rootUrl}system/testConfigEmail.do" frameBorder="0" style="border: 0; " scrolling="no"  class="col-lg-12" height="100%"></iframe></div>';
				$(html).dialog($.extend({
					modal: true,
					width:660,
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
							var myFrameWin = document.getElementById("testWin").contentWindow;
							var myForm = myFrameWin.document.getElementById("testmail");
							var frm=document.getElementById("cfg-mail");
							if($(myForm).valid()) { 
								var data2=getFormJson(frm);
								var data1=getFormJson(myForm);
								var dataPara=$.extend({},data1,data2);
								console.log(data1);
								console.log(dataPara);
								$.ajax({
						        		url: myForm.action,
						        		dataType:"text",
						        		type: myForm.method,	
						        		data: dataPara,
						        		success:function(data){				    
						        			if(data=="true"){
							        			document.getElementById("successL").style.display="";	
						        				document.getElementById("faileL").style.display="none";	        				
						        			}else{
						        				document.getElementById("faileL").style.display="";	        				
							        			document.getElementById("successL").style.display="none";	
						        			}
						        		}
						        	});
						        	$(this).dialog("close");
						        } 
					       
						}
					}]
				}));
			}
			}

		$(document).ready(function() {
			
			pageSetUp();
			// PAGE RELATED SCRIPTS
		
			// class switcher for radio and checkbox
			$("#cfg-mail").validate();

		});

		</script>

		

	</body>

</html>
