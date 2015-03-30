<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="system/serviceCatalogue";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<%
	List<Object[]> itemList = (List<Object[]>)request.getAttribute("itemList");
	Map<String,String> roleMap = (Map<String,String>)request.getAttribute("roleMap");
%>
<!DOCTYPE html>
<html lang="en-us">
		<style>
			/*
			 * Glyphicons
			 *
			 * Special styles for displaying the icons and their classes in the docs.
			 */
		
			.bs-glyphicons {
				padding-left: 0;
				padding-bottom: 1px;
				margin-bottom: 20px;
				list-style: none;
				overflow: hidden;
			}
			.bs-glyphicons li {
				float: left;
				width: 25%;
				height: 115px;
				padding: 10px;
				margin: 0 -1px -1px 0;
				font-size: 12px;
				line-height: 1.4;
				text-align: center;
				border: 1px solid #ddd;
			}
			.bs-glyphicons .glyphicon {
				margin-top: 5px;
				margin-bottom: 10px;
				font-size: 24px;
			}
			.bs-glyphicons .glyphicon-class {
				display: block;
				text-align: center;
			}
			.bs-glyphicons li:hover {
				background-color: rgba(86,61,124,.1);
			}
		
			@media (min-width: 768px) {
				.bs-glyphicons li {
					width: 12.5%;
				}
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
						系统管理
					</li>
					<li>
						服务目录管理
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
								服务目录管理
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
									class="table table-striped table-bordered table-hover">

									<thead>
										<tr>
											<th >
												序号
											</th>
											<th >
												图标
											</th>
											<th>
												服务名称
											</th>
											<th>
												排序
											</th>
											<th>
												服务分类
											</th>
											<th >
												状态
											</th>
											<th >
												服务说明
											</th>
											<th >
												角色权限
											</th>
											<th data-hide="phone,tablet" class="col-xs-6 col-sm-4 col-md-2 col-lg-2">
												操作
											</th>
										</tr>
									</thead>
									<tbody>
									<%for(int i =0;itemList!=null && i<itemList.size();i++){
										ServiceItem item = (ServiceItem)itemList.get(i)[1];
										//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
										//String life = sdf.format(order.getCtime().getTime());
									%>
										<tr>
											<td>
												<%=i+1 %>
											</td>
											<td>
												
												<span class="<%=item.getIcon() %>"></span>
											</td>
											<td>
												<%=item.getName() %>
											</td>
											<td>
												<%=item.getList() %>
											</td>
											<td>
												<%=itemList.get(i)[0]==null?"":itemList.get(i)[0] %>
											</td>
											<td>
												<%if(item.getState()!=null && item.getState()) {%>启用<%}else{ %>禁用<%} %>
											</td>
											<td>
												<%=item.getDescription() %>
											</td>
											<td>
												<%if(roleMap.get(item.getId()+"")!=null){%><%=roleMap.get(item.getId()+"") %><%} %>
											</td>
											<td>
												<button class='btn bg-color-blue txt-color-white' onclick="edit(<%=item.getId() %>)">修改</button> 
																						<span class="dropdown">
												   <button type="button" class="btn bg-color-blue txt-color-white dropdown-toggle"  data-toggle="dropdown">
												     		更多操作
												      <span class="caret"></span>
												   </button>								   
												   <ul class="dropdown-menu" role="menu" >
												      <li role="presentation">
												         <a href="javascript:void(0);"  class="padding-10 padding-top-0 padding-bottom-0" onclick="deleteCatalogue(<%=item.getId() %>)">删除</a>
												      </li>
												      <li class="divider"></li>
												      <li role="presentation">												    
												         <a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="eidtIcon(<%=item.getId() %>)" >修改图标</a>
												      </li>												      
												   </ul>
												</span>
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
					<!-- end widget --> </article>
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
			<!-- 导入窗口 -->
			<div id="importWindow" style="display:none;margin:0;">
				<form enctype="multipart/form-data" action="${rootUrl }system/importData.do?type=systemItem" class="smart-form" id="importForm" method="post">
					<fieldset>
						<section>
							<label for="file" class="input input-file">
								<div class="button"><input type="file" name="myfile" id = "file" onchange="this.parentNode.nextSibling.value = this.value">选择文件</div><input type="text" placeholder="Include some files" readonly="">
							</label>
						</section>
					</fieldset>
				</form>
			</div>
			<!-- 导入窗口 -->
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
		<script
			src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>

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
	
	function add() {
     			var html ='<div id="dialog-window" title="新增服务目录"><iframe id="myFrame"src="${rootUrl}system/loadServiceCatalogueView.do" frameBorder="0" style="border: 0; " scrolling="no"  class="col-lg-12" height="100%"></iframe></div>';
			    $(html).dialog($.extend({
			      modal: true,
			      width:710,
			      height:600,
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
						var myForm = myFrameWin.document.getElementById("myServiceCataForm");
						ajaxSubmit(myForm);
					}
				}]
			      
								      
			    }));
    		}
			function edit(Id) {
     			var html ="<div id='dialog-window' title='修改服务目录'><iframe id='myFrame' src='${rootUrl}system/loadServiceCatalogueView.do?id="+Id+"' frameBorder='0' style='border: 0;' scrolling='no' class='col-lg-12' height='100%'></iframe></div>";
			    $(html).dialog($.extend({
			      modal: true,
			      width:710,
			      height:600,
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
						var myForm = myFrameWin.document.getElementById("myServiceCataForm");
						myForm.action = "${rootUrl }system/editServiceCatalogue.do";
						ajaxSubmit(myForm);
					}
				}]
								      
			    }));
    		}
    		function check(){
    			var myFrameWin = document.getElementById("myFrame").contentWindow;
				var name = myFrameWin.document.getElementById("name").value;
        		var icon = myFrameWin.document.getElementById("icon").value;
        		var description = myFrameWin.document.getElementById("description").value;
        		//var roleIds = myFrameWin.mini.get("roleIds").getValue();
        		var list = myFrameWin.document.getElementById("list").value;
        		var listVerify = myFrameWin.document.getElementById("list_verify");
        		if(!(/^\d+$/.test(list))){
        			$(listVerify).show();
        			return false;
        		}
        		if(name == '' || name.trim() == '' || icon == '' || icon.trim() == '' || description == '' || description.trim() == '') {
        			alert('操作提示：请补全信息!');
        			return false;
        		}
        		$(listVerify).hide();
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
			
 	function deleteCatalogue(id){
 		$("#isDelete-message").html("<h3>确认删除？<h3>");
		$("#isDelete").dialog("open");
		$("#isDelete").dialog({param_id:"${rootUrl}system/deleteServiceCatalogue.do?id="+id});
 	}
 	
 	function eidtIcon(id){ 	
 		var html ="<div  id='dialog-window' title='修改图标'><iframe id='editIconFrame' src='${rootUrl}system/loadServiceCatalogueIcon.do?id="+id+"' frameBorder='0' style='border: 0;' scrolling='no' class='col-lg-12' height='2910'></iframe></div>";
	    $(html).dialog($.extend({ 
	      modal: true,
	      width:1000,
	      height:600,	          
	      scroll :false,
	      closeOnEscape: false,
	      draggable: true,
	      resizable: false,
	      close: function(event, ui) {
	        $(this).dialog("close"); // 关闭时销毁
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
				var editIconFrameWin = document.getElementById("editIconFrame").contentWindow;
				var editIconForm = editIconFrameWin.document.getElementById("edit-icon-form");	
				var dataPara = getFormJson(editIconForm); 
   				$.ajax({
       				url: "${rootUrl }system/editServiceCatalogueIcon.do",
       				type: editIconForm.method,
       				data: dataPara,
       				success: function(){
						$("#dialog-window").dialog("close"); 
						window.location.reload();
					} 
   				});
			}
		}]
						      
	    }));
	    
 	}
 	
 	
	$(document).ready(function() {
		pageSetUp();
		var responsiveHelper_datatable_tabletools = undefined;

		var breakpointDefinition = {
			tablet : 1024,
			phone : 480
		};
						
		/* TABLETOOLS */
		$('#datatable_tabletools').dataTable({
			"sDom" : "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-6 hidden-xs'T>r>"
				+ "t"
				+ "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-sm-6 col-xs-12'p>>",
			"oTableTools" : {
				"aButtons" : [{
					"sExtends" : "text",
					"sButtonText": "导入",
					"fnClick":function(nButton, oConfig, oFlash){
						$("#importWindow").dialog("open");
					}
				},{
					"sExtends" : "text",
					"sButtonText": "新增",
					"fnClick":function(nButton, oConfig, oFlash){
						add();
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
		$("#importWindow").dialog({
			autoOpen : false,
			modal : true,
			draggable:false,
			position:"center",
			resizable :false,
			title:"导入数据",	
			height:210, 
			width:500, 
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
					var form = document.getElementById("importForm");	
					form.submit();
					$(this).dialog("close");
				}
			}]
		});
	});
</script>
	</body>

</html>
