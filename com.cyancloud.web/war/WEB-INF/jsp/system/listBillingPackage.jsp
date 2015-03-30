<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.service.model.BillingPackageBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
String path="system/listBillingPackage";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>"/>
</jsp:include>
<%
	List<BillingPackageBean> packageList = (List<BillingPackageBean>)request.getAttribute("packageList");
%>
<!DOCTYPE html>
<html lang="en-us">
		
		<script type="text/javascript" language="javascript">
			function addPackage() {
     			var html ='<div id="dialog-window" title="新增套餐"><iframe id="myFrame" src="${rootUrl}system/addBillingPackage.do" frameBorder="0" style="border: 0; " scrolling="no" class="col-lg-12" height="100%"></iframe></div>';
			    return $(html).dialog($.extend({
			      modal: true,
			      width:600,
			      height:560,
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
						var myFrameWin = document.getElementById("myFrame").contentWindow;
						var myForm = myFrameWin.document.getElementById("myForm");
						ajaxSubmit(myForm);
					}
				}]
			      
								      
			    }));
    		}
    		
    		function editPackage(bpId) {
     			var html ="<div id='dialog-window' title='修改套餐'><iframe id='myFrame' src='${rootUrl}system/editBillingPackage.do?id="+bpId+"' frameBorder='0' style='border: 0;' scrolling='no' class='col-lg-12'  height='100%'></iframe></div>";
			    return $(html).dialog($.extend({
			      modal: true,
			      width:600,
			      height:560,
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
						var myFrameWin = document.getElementById("myFrame").contentWindow;
						var myForm = myFrameWin.document.getElementById("myForm");
						ajaxSubmit(myForm);
					}
				}]
			      
								      
			    }));
    		}
    		
    		function deletePackage(bpId){
		   		$("#confirm-message").html("<h3>您确认删除吗？<h3>")  ;
		   		$("#confirm").dialog("open");
				$("#confirm").dialog({url:"${rootUrl}system/deleteBillingPackage.do?id="+bpId});
 			}
 			
    		//将form转为AJAX提交
			function ajaxSubmit(frm) {
				//提交前检查
				if(check()) {
					var dataPara = getFormJson(frm);
    				$.ajax({
        				url: frm.action,
        				type: frm.method,
        				data: dataPara,
        				success: function(){
							$("#dialog-window").dialog("close"); 
							window.location.reload();
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
			
			function check(){
				var myFrameWin = document.getElementById("myFrame").contentWindow;
				var name = myFrameWin.document.getElementById("name").value;
        		var templateId = myFrameWin.document.getElementById('templateId').value;
        		var cpu = myFrameWin.document.getElementById('cpu').value;
        		var memory = myFrameWin.document.getElementById('memory').value;
        		var capacity = myFrameWin.document.getElementById('capacity').value;
        		if(name == '' || templateId == '' || cpu == '0' ||  memory == '0'||  capacity == '0') {
        			alert('操作提示：请补全信息!');
        			return false;
        		}
        		return true;
    		}

		   	function deletePackage(packageId){
		   		$("#confirm-message").html("<h3>您确认删除吗？<h3>")  ;
		   		$("#confirm").dialog("open");
				$("#confirm").dialog({url:"${rootUrl}system/deleteBillingPackage.do?id="+packageId});
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
					<li>系统管理</li><li>套餐设置</li>
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
									<span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;<h2>套餐列表</h2></span>
				
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
										<table id="datatable_tabletools" class="table table-striped table-bordered table-hover">
											<thead>
												<tr>
													<th>序号</th>
													<th>套餐名称</th>
													<th>操作系统</th>
													<th>CPU核数(个)</th>
													<th>内存(GB)</th>
													<th>存储空间(GB)</th>
													<th>模板</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<%
												if(packageList != null && packageList.size() > 0) {
												for(int i =0;i<packageList.size();i++){
													BillingPackageBean bp = packageList.get(i);
												%>
												<tr>
													<td><%=i+1%></td>
													<td><%=bp.getName()%></td>
													<td><%=bp.getOs()%></td>
													<td><%=bp.getCpu()%></td>
													<td><%=bp.getMemory()/1024%></td>
													<td><%=bp.getCapacity()/1024%></td>
													<td><%=bp.getTemplateName()%></td>
													<td>
														<button class="btn bg-color-blue txt-color-white" onclick="editPackage(<%=bp.getId() %>)">修改</button>&nbsp;
														<button class="btn bg-color-yellow txt-color-white" onclick="deletePackage(<%=bp.getId() %>)">删除</button>&nbsp;
														
													</td>
												</tr>	
												<%
													}
												}%>
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
				
					<!-- end row -->
				
				</section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN PANEL -->
			
		<!-- 弹出窗口 -->
		<div id="confirm" style="display:none;margin:0;">
			<div id="confirm-message">
				
			</div>
		</div>
		<!-- 弹出窗口 -->
		
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

		<!-- PAGE RELATED PLUGIN(S) -->
		<script src="${rootUrl}js/plugin/datatables/jquery.dataTables.min.js"></script>
		<script src="${rootUrl}js/plugin/datatables/dataTables.colVis.min.js"></script>
		<script src="${rootUrl}js/plugin/datatables/dataTables.tableTools.min.js"></script>
		<script src="${rootUrl}js/plugin/datatables/dataTables.bootstrap.min.js"></script>
		<script src="${rootUrl}js/plugin/datatable-responsive/datatables.responsive.min.js"></script>
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
				var responsiveHelper_dt_basic = undefined;
				var responsiveHelper_datatable_fixed_column = undefined;
				var responsiveHelper_datatable_col_reorder = undefined;
				var responsiveHelper_datatable_tabletools = undefined;
				
				var breakpointDefinition = {
					tablet : 1024,
					phone : 480
				};
	
	
			/* END BASIC */
			
		    
		    // custom toolbar
		    $("div.toolbar").html('<div class="text-right"><img src="${rootUrl}img/logo.png" alt="SmartAdmin" style="width: 111px; margin-top: 3px; margin-right: 10px;"></div>');
		    	   
		    // Apply the filter
		    $("#datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {
		    	
		        otable
		            .column( $(this).parent().index()+':visible' )
		            .search( this.value )
		            .draw();
		            
		    } );
		    /* END COLUMN FILTER */   
	    
	
			/* TABLETOOLS */
						$('#datatable_tabletools')
								.dataTable(
										{

											// Tabletools options: 
											//   https://datatables.net/extensions/tabletools/button_options
											"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"
													+ "t"
													+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
											"oTableTools" : {
												"aButtons" : [
														{
															"sExtends" : "text",
															"sButtonText": "新增",
															"fnClick":function(nButton, oConfig, oFlash){
																addPackage();
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
												responsiveHelper_datatable_tabletools
														.createExpandIcon(nRow);
											},
											"drawCallback" : function(oSettings) {
												responsiveHelper_datatable_tabletools
														.respond();
											}
										});
			
			
			// PAGE RELATED SCRIPTS
		
			$('.tree > ul').attr('role', 'tree').find('ul').attr('role', 'group');
			$('.tree').find('li:has(ul)').addClass('parent_li').attr('role', 'treeitem').find(' > span').attr('title', 'Collapse this branch').on('click', function(e) {
				var children = $(this).parent('li.parent_li').find(' > ul > li');
				if (children.is(':visible')) {
					children.hide('fast');
					$(this).attr('title', 'Expand this branch').find(' > i').removeClass().addClass('fa fa-lg fa-plus-circle');
				} else {
					children.show('fast');
					$(this).attr('title', 'Collapse this branch').find(' > i').removeClass().addClass('fa fa-lg fa-minus-circle');
				}
				e.stopPropagation();
			});	
			$("#confirm").dialog({
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
					ajaxFunction($("#confirm").dialog("option","url"));
					$(this).dialog("close");
				}
			}]
						
		});		
		
		})
		
		var _gaq = _gaq || [];
				_gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);
				_gaq.push(['_trackPageview']);
			
			(function() {
				var ga = document.createElement('script');
				ga.type = 'text/javascript';
				ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0];
				s.parentNode.insertBefore(ga, s);
			})();
		</script>
	</body>

</html>
