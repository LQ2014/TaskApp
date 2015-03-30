<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
String path="acl/listUser";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>"/>
</jsp:include>
<!DOCTYPE html>
<html lang="en-us">
	<script type="text/javascript" language="javascript">
    	
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
					<li>安全管理</li><li>用户管理</li>
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
									<span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;<h2>用户管理</h2></span>
				
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
										<table id="datatable_tabletools" class="table table-striped table-bordered table-hover" class="col-lg-12" >
											<thead>
												<tr>
													<th>序号</th>
													<th>用户名</th>
													<th>中文名</th>
													<th>所属部门</th>
													<th>类型</th>
													<th>有效日期</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${accountList }" var="vo" varStatus="list">
												<tr>
													<td>${ list.count}</td>
													<td>${vo.ucode }</td>
													<td>${vo.uname }</td>
													<td>${vo.deptName}</td>
													<td>${vo.typeName}</td>
													<td>${vo.dateline}</td>
													<td>
														<c:if test="${vo.state==0}">
															<a href="${rootUrl }acl/changeAccountState.do?id=${vo.id}" class="btn bg-color-green txt-color-white"><fmt:message key="usable"/></a>
														</c:if>
														<c:if test="${vo.state==1}">
															<a href="${rootUrl }acl/changeAccountState.do?id=${vo.id}" class="btn bg-color-yellow txt-color-white"><fmt:message key="disable"/></a>
														</c:if>
														<button class='btn bg-color-blue txt-color-white' onclick="editUser(${vo.id });">修改</button>&nbsp;&nbsp;
														<%-- 
														<button class='btn bg-color-blue txt-color-white' onclick="setContacts(${vo.id });">设置通讯录</button>&nbsp;&nbsp;
														<button class='btn bg-color-red txt-color-white' onclick="deleteUser(${vo.id });">删除</button>&nbsp;&nbsp;
														--%>
													</td>
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
				
					<!-- end row -->
				
				</section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<!-- END MAIN PANEL -->

		<!--================================================== -->

		<!-- 弹出窗口 -->
		<div id="confirm" style="display:none;margin:0;">
			<div id="confirm-message">
				
			</div>
		</div>
		<!-- 弹出窗口 -->
		<!--================================================== -->
		<!-- 删除确认窗口 -->
		<div id="isDelete" style="display:none;margin:0;">
			<div id="isDelete-message">
				
			</div>
		</div>
		<!-- 删除确认窗口 -->
		<!-- 信息窗口 -->
		<div id="alert" style="display:none;margin:0;">
			<div id="alert-message">
			
			</div>
		</div>
		<!-- 信息窗口-->
		

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
		
			// Apply the filter
		    $("#datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {
		    	
		        otable
		            .column( $(this).parent().index()+':visible' )
		            .search( this.value )
		            .draw();
		            
		    } );
			
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
											],
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

			/* END TABLETOOLS */
			$("#isDelete").dialog({
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
						ajaxFunction($("#isDelete").dialog("option","param_id"));
						$(this).dialog("close");
					}
				}]
			});
			
			$("#alert").dialog({
				autoOpen : false,
				modal : true,
				draggable:false,
				position:"center",
				resizable :false,
				title:"操作提示",	
				height:210, 
				width:350, 
				buttons : [{
					html : "关闭",
					"class" : "btn btn-default",
					click : function() {
						$(this).dialog("close");
					}
				}]
			});

			$("#myDialog").dialog({
			autoOpen : false,
			modal : true,
			height:430, 
			width:600, 
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
					$("#roleForm").submit();
				}
			}]
		
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
		
		});
		
		function addUser(){
			var html ='<div id="dialog-window" title="新增用户"><iframe id="myFrame"src="${rootUrl}acl/addUser.do" frameBorder="0" style="border: 0; " scrolling="no"  class="col-lg-12" height="100%"></iframe></div>';
		    $(html).dialog($.extend({
		      modal: true,
		      width:620,
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
					var myFrameWin = document.getElementById("myFrame").contentWindow;
					var myForm = myFrameWin.document.getElementById("addUserForm");
					ajaxSubmit(myForm);
				}
			}]			      
							      
		    }));
		}
		
		function editUser(id){
			var html ='<div id="dialog-window" title="修改用户"><iframe id="myFrame" src="${rootUrl}acl/editUser.do?id='+id+'" frameBorder="0" style="border: 0;" scrolling="no" class="col-lg-12" height="100%"></iframe></div>';
		    return $(html).dialog($.extend({
		      modal: true,
		      width:620,
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
					var myFrameWin = document.getElementById("myFrame").contentWindow;
					var myForm = myFrameWin.document.getElementById("eidtUserForm");
					ajaxSubmit(myForm);
				}
			}]
		      
							      
		    }));
			
		}
		
		function check(){			
    		return true;
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
		
		function setContacts(id){
			var html ='<div id="dialog-window" title="设置通讯录"><iframe id="myFrame" src="${rootUrl}acl/setContacts.do?id='+id+'" frameBorder="0" style="border: 0;" scrolling="no" class="col-lg-12" height="100%"></iframe></div>';
		    return $(html).dialog($.extend({
		      modal: true,
		      width:650,
		      height:500,
		      closeOnEscape: false,
		      draggable: true,
		      resizable: false,
		      close: function(event, ui) {
		        $(this).dialog("destroy"); // 关闭时销毁
		      },
		      buttons : [{
					html : "清空",
					"class" : "btn btn-danger",
					click : function() {
						//关闭当前Dialog 
						var myFrameWin = document.getElementById("myFrame").contentWindow;
						var myForm = myFrameWin.document.getElementById("setContactsForm");
						$(myForm).find(":text").val("");
					}
				}, {
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
					var myForm = myFrameWin.document.getElementById("setContactsForm");
					ajaxSubmit(myForm);
				}
			}]
		      
							      
		    }));
		}
		
		function deleteUser(id){
			$("#isDelete-message").html("<h5>确认删除用户的所有信息（包含权限）？<h5>")  ;
			$("#isDelete").dialog("open");
			$("#isDelete").dialog({param_id:"${rootUrl}acl/deleteUser.do?id="+id});
	 	}

		</script>
	</body>

</html>
