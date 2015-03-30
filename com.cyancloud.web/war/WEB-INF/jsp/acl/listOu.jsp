<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
String path="acl/listOu";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>"/>
</jsp:include>
<!DOCTYPE html>
<html lang="en-us">
		<!-- Basic Styles -->
		<link href="${rootUrl}css/jqmini/demo.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/bootstrap.min.css">
		
		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
		
		<link rel="stylesheet" type="text/css" media="screen"	href="${rootUrl}css/smartadmin-skins.min.css">
        <!--引用的文件 Begin-->
        <link id="vsStyle" href="${rootUrl}css/treetable/vsStyle/jquery.treeTable.css" rel="stylesheet" type="text/css" />
        <script src="${rootUrl}js/scripts/jquery-2.1.1.min.js"></script>
        <script src="${rootUrl}js/treetable/jquery.treetable.lazy.js"></script>
        <!--引用的文件 End-->
        
		
		<script type="text/javascript" language="javascript">   		 	
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
            $('#datatable_tabletools').treeTable(option);

        });
    		
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
					<li>系统管理</li><li>部门管理</li>
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
									<span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;<h2>部门列表</h2></span>
				
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
										
										<table id="datatable_tabletools" class="table table-striped table-bordered table-hover" class="col-lg-12" >
											<thead>	
												<tr>
													<td align="right" colspan="4">
														<input type="button" class="btn bg-color-blue txt-color-white" value="新增" onclick="addUnit();"/>
													</td>
												</tr>											
												<tr>
													<th>部门名称</th>
													<th>部门领导</th>
													<th>备注</th>													
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${unitList }" var="vo" varStatus="list">
												<tr id="${vo.id }" pid="${vo.parentId }">
												<c:if test="${vo.isLeaf==true}">
													<td><span controller="true">&nbsp;&nbsp;<img src="${rootUrl}img/treetable/file.png"> &nbsp;${vo.name }</span></td>
												</c:if>
												<c:if test="${vo.isLeaf==false}">
													<td><span controller="true">&nbsp;&nbsp;<img src="${rootUrl}img/treetable/folder.png"> &nbsp;${vo.name }</span></td>
												</c:if>
													
													<td>${vo.leader.name }</td>
													<td>${vo.note }</td>													
													<td>
														<button class='btn bg-color-blue txt-color-white' onclick="editUnit(${vo.id });">修改</button>&nbsp;&nbsp;
														<button class='btn bg-color-blue txt-color-white' onclick="allocationLeader(${vo.id });">分配领导</button>&nbsp;&nbsp;
														<button class='btn bg-color-blue txt-color-white' onclick="viewAccount(${vo.id });">管理员工</button>&nbsp;&nbsp;
														<button class='btn bg-color-red txt-color-white' onclick="deleteUnit(${vo.id });">删除</button>&nbsp;&nbsp;
														
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
			
	})
		
		function addUnit(){
			var html ='<div id="dialog-window" title="新增部门"><iframe id="myFrame"src="${rootUrl}acl/addUnit.do" frameBorder="0" style="border: 0; " scrolling="no"  class="col-lg-12" height="100%"></iframe></div>';
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
					var myForm = myFrameWin.document.getElementById("addUnitForm");
					ajaxSubmit(myForm);
				}
			}]			      
							      
		    }));
		}
		
		function editUnit(id){
			var html ='<div id="dialog-window" title="修改部门"><iframe id="myFrame" src="${rootUrl}acl/editUnit.do?id='+id+'" frameBorder="0" style="border: 0;" scrolling="no" class="col-lg-12" height="100%"></iframe></div>';
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
					var myForm = myFrameWin.document.getElementById("eidtUnitForm");
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
		
		function viewAccount(id){
			window.location = "${rootUrl }acl/viewAccountByUnit.do?id="+id;
		}
		
		function deleteUnit(id){
	 		$.ajax({  
				type:"POST",  
				url:"${rootUrl }acl/checkAccount2Unit.do?id="+id,  
				dataType:"html",  
				success:function(data){   
                    	if(data == 'true') {
                    		$("#alert-message").html("<h3>该部门下有人员,不能被删除！<h3>")  ;
						$("#alert").dialog("open");
                    	} else {
                    		$("#isDelete-message").html("<h3>如有子部门也将删除,确认删除？<h3>")  ;
						$("#isDelete").dialog("open");
						$("#isDelete").dialog({param_id:"${rootUrl}acl/deleteUnit.do?id="+id});
                    	}
				},  
				error:function(){  
					alert("异步加载失败");  
				}  
			});  
	 		
	 	}
		
		function allocationLeader(unitId){			
			var html ='<div id="dialog-window" title="新增人员"><iframe id="myFrame"src="${rootUrl}acl/allocationLeader2Unit.do?unitId='+unitId+'" frameBorder="0" style="border: 0; " scrolling="no"  class="col-lg-12" height="100%"></iframe></div>';
		    $(html).dialog($.extend({
		      modal: true,
		      width:900,
		      height:600,
		      closeOnEscape: false,
		      draggable: true,
		      resizable: false,
		      close: function(event, ui) {
		        $(this).dialog("destroy"); // 关闭时销毁
		        window.location.reload(true);
		      }	      
							      
		    }));
		}

		</script>
	</body>

</html>