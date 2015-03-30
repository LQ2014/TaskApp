<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page import="com.cyancloud.model.system.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
String path="acl/listAuth";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<!DOCTYPE html>
<html lang="en-us">
		
    	<!--引用的文件 Begin-->
        <link id="vsStyle" href="${rootUrl}css/treetable/vsStyle/jquery.treeTable.css" rel="stylesheet" type="text/css" />
        <script src="${rootUrl}js/scripts/jquery-2.1.1.min.js"></script>
        <script src="${rootUrl}js/treetable/jquery.treetable.lazy.js"></script>
        <!--引用的文件 End-->
    	<script type="text/javascript" language="javascript">
    		function importAuth(){
    			$("#importWindow").dialog("open");
    		}
			function add() {
     			var html ='<div id="dialog-window" title="新增权限"><iframe id="myFrame" src="${rootUrl}acl/addAuth.do" frameBorder="0" style="border: 0; " scrolling="no" class="col-lg-12" height="100%"></iframe></div>';
			    return $(html).dialog($.extend({
			      modal: true,
			      width:720,
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
						var myForm = myFrameWin.document.getElementById("myForm");
						ajaxSubmit(myForm);
					}
				}]
			      
								      
			    }));
    		}
			function edit(id) {
     			var html ='<div id="dialog-window" title="修改权限"><iframe id="myFrame" src="${rootUrl}acl/editAuth.do?id='+id+'" frameBorder="0" style="border: 0;" scrolling="no" class="col-lg-12" height="100%"></iframe></div>';
			    return $(html).dialog($.extend({
			      modal: true,
			      width:720,
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
						var myForm = myFrameWin.document.getElementById("myForm");
						ajaxSubmit(myForm);
					}
				}]
			      
								      
			    }));
    		}
    		function check(){
    			var myFrameWin = document.getElementById("myFrame").contentWindow;
				var name = myFrameWin.document.getElementById("name").value;
        		var type = myFrameWin.document.getElementById('type').value;
        		if(name == '' || type == '') {
        			alert('操作提示：请补全信息!');
        			return false;
        		}
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
			
			$(function(){
            var option = {
                theme:'vsStyle',
                expandLevel : 2,
                beforeExpand : function($treeTable, id) {
                    //判断id是否已经有了孩子节点，如果有了就不再加载，这样就可以起到缓存的作用
                    if ($('.' + id, $treeTable).length) { return; }
                },
                onSelect : function($treeTable, id) {
                    window.console && console.log('onSelect:' + id);
                    
                }

            };
            $('#myTreeTable').treeTable(option);

        });
		</script>
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
						安全管理
					</li>
					<li>
						权限管理
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
				<section id="widget-grid" class="">
				
					<!-- row -->
					<div class="row">
				
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<!-- Widget ID (each widget will need unique ID)-->
							<div class="jarviswidget jarviswidget-color-blueDark" id="myTable" data-widget-editbutton="false" data-widget-deletebutton="false">
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
									<span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;<h2>权限管理</h2></span>
				
								</header>
				
								<!-- widget div-->
								<div>
				
									<!-- widget edit box -->
									<div class="jarviswidget-editbox">
										<!-- This area used as dropdown edit box -->
				
									</div>
									<!-- end widget edit box -->
							<!--start-->
									<div class="widget-body no-padding">
										<table id="myTreeTable" class="table table-striped table-bordered table-hover col-lg-12">
											<thead>
												<tr>
													<td align="right" colspan="8">
														<input type="button" class="btn bg-color-blue txt-color-white" value="导入" onclick="importAuth();"/>
														<input type="button" class="btn bg-color-blue txt-color-white" value="新增" onclick="add();"/>
													</td>
												</tr>
												<tr>
													<th class="col-xs-6 col-sm-4 col-md-2 col-lg-2">名称</th>
													<th class="col-xs-6 col-sm-4 col-md-2 col-lg-2">图标</th>
													<th>类型</th>
													<th class="col-xs-6 col-sm-4 col-md-2 col-lg-2">权限代码</th>
													<th>父权限</th>
													<th class="col-xs-6 col-sm-4 col-md-2 col-lg-1">是否为菜单</th>
													<th>备注</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${authList }" var="vo" varStatus="list">
												<tr id="${vo.id }" pid="${vo.parentId }">
												<c:if test="${vo.isLeaf==true}">
													<td><span controller="true">&nbsp;&nbsp;<img src="${rootUrl}img/treetable/file.png"> &nbsp;${vo.name }</span></td>
												</c:if>
												<c:if test="${vo.isLeaf==false}">
													<td><span controller="true">&nbsp;&nbsp;<img src="${rootUrl}img/treetable/folder.png"> &nbsp;${vo.name }</span></td>
												</c:if>
													<td><span class="${vo.css }"></span></td>
													<td>${vo.type }</td>
													<td>${vo.code }</td>
													<td>${vo.parentName }</td>
													<td>
														<c:if test="${vo.isMenu==true}">是</c:if>
														<c:if test="${empty vo.isMenu or vo.isMenu==false}">否</c:if>
													</td>
													<td>${vo.remark }</td>
													<td>
														<button class='btn bg-color-blue txt-color-white' onclick="edit(${vo.id });">修改</button>&nbsp;&nbsp;
													<span class="dropdown">	
													 <button type="button" class="btn bg-color-blue txt-color-white dropdown-toggle"  data-toggle="dropdown">
												     		更多操作
													 <span class="caret"></span>
													 </button>								   
													 <ul class="dropdown-menu" role="menu" >
													    <li role="presentation">
													       <a href="javascript:void(0);"  class="padding-10 padding-top-0 padding-bottom-0" onclick="deleteAuth(${vo.id })">删除</a>
													    </li>
													    <c:if test="${vo.isLeaf==false}">
													    <li class="divider"></li>													    
													    <li role="presentation">												    
													       <a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="eidtAuthIcon(${vo.id })" >修改图标</a>
													    </li>	
													    </c:if>											      
													</ul>
												</span>
													
													
													</td>
												</tr>	
												</c:forEach>
												
											
											</tbody>
										</table>
									
									</div>
								<!--end-->

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
				<form enctype="multipart/form-data" action="${rootUrl }system/importData.do?type=auth" class="smart-form" id="importForm" method="post">
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
			<!-- 信息窗口 -->
			<div id="alert" style="display:none;margin:0;">
				<div id="alert-message">
				
				</div>
			</div>
			<!-- 信息窗口-->

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
		function setValue() {
            var obj = mini.get("select1");
            obj.setValue("base,button,ajax");
        }
        function getValue() {
            var obj = mini.get("select1");
            alert(obj.getValue() + ":" + obj.getText());
        }
        function enable() {
            var obj = mini.get("select1");
            obj.enable();
        }
        function disable() {
            var obj = mini.get("select1");
            obj.disable();
        }

        function beforenodeselect(e) {
            //禁止选中父节点
            if (e.isLeaf == false) e.cancel = true;
        }

        function onCloseClick(e) {
            var obj = e.sender;
            obj.setText("");
            obj.setValue("");
        }  
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
 	function deleteAuth(id){
 		$.ajax({  
						type:"POST",  
						url:"${rootUrl }acl/checkRole2Right.do?id="+id,  
						dataType:"html",  
						success:function(data){   
	                     	if(data == 'true') {
	                     		$("#alert-message").html("<h3>该权限和角色有关联,不能被删除！<h3>")  ;
								$("#alert").dialog("open");
	                     	} else {
	                     		$("#isDelete-message").html("<h3>如有子权限也将被删除,确认删除？<h3>")  ;
								$("#isDelete").dialog("open");
								$("#isDelete").dialog({param_id:"${rootUrl}acl/deleteAuth.do?id="+id});
	                     	}
						},  
						error:function(){  
							alert("异步加载失败");  
						}  
					});  
 		
 	}
	function typeVerify(me){
		if(/^\d+$/.test($("#type").val())){
			$("#type_verify").hide();
		}else{
			$("#type_verify").show();	
		}
	}
	
	
	function eidtAuthIcon(id){ 	
 		var html ="<div  id='dialog-window' title='修改图标'><iframe id='editAuthIconFrame' src='${rootUrl}acl/loadAuthIcon.do?id="+id+"' frameBorder='0' style='border: 0;' scrolling='no' class='col-lg-12' height='3650'></iframe></div>";
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
				var editIconFrameWin = document.getElementById("editAuthIconFrame").contentWindow;
				var editIconForm = editIconFrameWin.document.getElementById("edit-icon-form");	
				var dataPara = getFormJson(editIconForm); 
   				$.ajax({
       				url: "${rootUrl }acl/editAuthIcon.do",
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
		$("#aclTable").dataTable({

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
					}
				}],
				"sSwfPath" : "${rootUrl}js/plugin/datatables/swf/copy_csv_xls_pdf.swf"
			}
			,
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
