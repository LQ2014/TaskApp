<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en-us">
	<head>
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/font-awesome.min.css">
		
		<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-skins.min.css">
		
		<!-- SmartAdmin RTL Support is under construction
			 This RTL CSS will be released in version 1.5
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-rtl.min.css"> -->

		<!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update.
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/your_style.css"> -->

		<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/demo.min.css">

		<!-- FAVICONS -->
		<link rel="shortcut icon" href="${rootUrl}img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="${rootUrl}img/favicon/favicon.ico" type="image/x-icon">

		<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="${rootUrl}img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="${rootUrl}img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="${rootUrl}img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="${rootUrl}img/splash/touch-icon-ipad-retina.png">
		
		<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="${rootUrl}img/splash/iphone.png" media="screen and (max-device-width: 320px)">
		<style type="text/css">
			.smart-btn{
				float: right;
				height: 31px;
				margin: 10px 0 0 5px;
				padding: 0 22px;
				font: 300 15px/29px 'Open Sans',Helvetica,Arial,sans-serif;
				cursor: pointer;
			}
		</style>
	</head>
	<body id="myBody" onload="onload();" style="border:solid 1px #AAAAAA;">
		<!-- MAIN PANEL -->
		<div id="main" role="main">
			<div id="content">

				<!-- widget grid -->
				<section id="widget-grid" class=""> <!-- row -->
				<div class="row">					
					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						
						<div id="myTable1111" class="jarviswidget jarviswidget-color-blueDark" data-widget-editbutton="false" data-widget-deletebutton="false">
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
								<div class="table-responsive">
									<table id="datatable_tabletools1" class="table table-bordered table-striped table-condensed table-hover smart-form has-tickbox">
										<thead>											
											<tr>
												<th>
													选择
												</th>
												<th>
													用户名
												</th>
												<th>
													姓名
												</th>
												<th>
													邮箱
												</th>
												<th>
													手机
												</th>
																								
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${listAccount }" var="account" varStatus="list">
											<tr>
												<td >
													<label class="checkbox">
														<input type="checkbox" name="checkbox" value="${account.id}" onclick="checkBoxAll(this)">
														<i></i>
													</label>
												</td>
													
												<td>
													${account.code}
												</td>
												<td>
													${account.name}
												</td>
												<td>
													${account.email}
												</td>
												<td>
													${account.phone}
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
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
		
		<!-- 删除确认窗口 -->
		<div id="isDelete" style="display:none;margin:0;">
			<div id="isDelete-message">
				
			</div>
		</div>
		<!-- 删除确认窗口 -->
		
		<!-- 操作提示-->
			<div id="operateAjax" style="text-align:center; line-height:40px; padding:10px 0; border-radius:4px; vertical-align:middle;display:none;"><img src="${rootUrl}img/ajax_loader_large.gif" alt="SmartAdmin" style="width: 22px;margin-right: 6px;">正在提交数据，请稍后...</div>
			<!-- 操作提示-->	

		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
		<script>
	if (!window.jQuery) {
		document.write('<script src="${rootUrl}js/libs/jquery-2.1.1.min.js"><\/script>');
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
		<script src="${rootUrl}js/plugin/jquery-blockUI/jquery.blockUI.js"></script>

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

	$(document).ready(function() {
		pageSetUp();

		/* // DOM Position key index //
		
		l - Length changing (dropdown)
		f - Filtering input (search)
		t - The Table! (datatable)
		i - Information (records)
		p - Pagination (paging)
		r - pRocessing 
		< and > - div elements
		<"#id" and > - div with an id
		<"class" and > - div with a class
		<"#id.class" and > - div with an id and class
		
		Also see: http://legacy.datatables.net/usage/features
		 */

		/* BASIC ;*/		
		var responsiveHelper_datatable_tabletools = undefined;
		var breakpointDefinition = {
			tablet : 1024,
			phone : 480
		};
		
		/* TABLETOOLS */
		 var table = $('#datatable_tabletools1').dataTable({
			"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"+
					"t"+
					"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",      
			"oTableTools": {
				"aButtons": [{
					"sExtends" : "text",
					"sButtonText": "分配",
					"fnClick":function(nButton, oConfig, oFlash){
						addLeader();
					}
				}]
 			},
			"autoWidth" : true,
			"preDrawCallback" : function() {
				// Initialize the responsive datatables helper once.
				if (!responsiveHelper_datatable_tabletools) {
					responsiveHelper_datatable_tabletools = new ResponsiveDatatablesHelper($('#datatable_tabletools1'), breakpointDefinition);
				}
			},
			"rowCallback" : function(nRow) {
				responsiveHelper_datatable_tabletools.createExpandIcon(nRow);
			},
			"drawCallback" : function(oSettings) {
				responsiveHelper_datatable_tabletools.respond();
			},
			"scrollY":        "440px",
			"scrollCollapse": true,
			"paging":         false
		});	
		
		function addLeader(){
			//window.location.reload(true);
			var leaderId = getAllCheckBoxVal();
			if(leaderId && leaderId.length>0){
				$.ajax({
					url : '${rootUrl}acl/doAllocationLeader2Unit.do',
					dataType : 'json',
					data : {unitId : '${unit.id}', leaderId : leaderId[0]},
					beforeSend:function(){				           		
		            	$.blockUI({ message: $('#operateAjax'),css: { width: '240px', borderRadius:'6px',border:'1px solid rgb(204, 204, 204)'} });
		            }, 
					success : function(jsonData){
						if(jsonData.success){
							$.unblockUI();  
							window.location.reload(true);							
						}
					}
				});
			}
		}	
	
		
		function getAllCheckBoxVal(){
			var checkboxs = document.getElementsByName("checkbox");
			var accountIds = [];
			for(var i=0;i<checkboxs.length;i++){
				var checkbox = checkboxs[i];
				if(checkbox.checked){
					accountIds.push(checkbox.value);
				}
			}
			return accountIds;
		}
		 
		
	});
		
	
	function checkBoxAll(e){
		var checkboxs = document.getElementsByName("checkbox");
		if(e.checked){
			for(var n=0;n<checkboxs.length;n++){
				if(checkboxs[n]!=e){
					$(checkboxs[n]).removeAttr('checked');
				}
			}
		}
	}	
	</script>
	</body>

</html>
