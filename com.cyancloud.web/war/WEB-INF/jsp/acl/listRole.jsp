<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.Role,com.cyancloud.service.model.RoleBean,com.cyancloud.model.system.SystemParam"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
String path="acl/listRole";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>"/>
</jsp:include>
<%
	List<RoleBean> roleList = (List<RoleBean>)request.getAttribute("roleList");
	List<SystemParam> paramList = (List<SystemParam>)request.getAttribute("paramList");
%>
<!DOCTYPE html>
<html lang="en-us">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    	<script src="${rootUrl}js/scripts/boot.js" type="text/javascript"></script>
    	<script src="${rootUrl}js/commonlibs/TreeSelectWindow.js" type="text/javascript"></script>
		<script type="text/javascript" language="javascript">
			function check(){
				var name = document.getElementById("name").value;
				if(name == ''){
        			alert("操作提示：请补全信息");
        			document.getElementById("name").focus();
        			return false;
    			}
    			return true;
    		}

			function changeState(roleId,state) {
     			var msg = "启用";
     			if(state == 0) {
     				msg = "禁用";
     			}
     			$("#confirm-message").html("<h3>您确认"+msg+"吗？<h3>")  ;
		   		$("#confirm").dialog("open");
				$("#confirm").dialog({url:'${rootUrl }acl/changeRoleState.do?roleId='+roleId+'&state='+state});
    		}
   			function editRole(param){
   				var array = param.split(',');
		   		var dialog = $("#myDialog").dialog("open");
		   		$("#myDialog").dialog({"title": "修改角色"});
				document.getElementById("roleForm").action = "${rootUrl }acl/editRole.do";
		   		document.getElementById("id").value = array[0];
		   		document.getElementById("name").value = array[1];
		   		document.getElementById("type").value = array[2];
		   		document.getElementById("description").value = array[3];
		   		setRadio('state',array[4]);
		   	}
		   	
		   	function setRadio(name,radioValue){ 
				var oRadio = document.getElementsByName(name);
				for(var i=0;i<oRadio.length;i++) {
					if(oRadio[i].value==radioValue) {
						oRadio[i].checked=true; //修改选中状态
						break; //停止循环
					}
				}
			}
		   	function deleteRole(roleId){
		   		$("#confirm-message").html("<h3>您确认删除吗？<h3>")  ;
		   		$("#confirm").dialog("open");
				$("#confirm").dialog({url:"${rootUrl}acl/deleteRole.do?roleId="+roleId});
 			}
        	function alloUser(roleId) {
           		var win = new TreeSelectWindow();
            	win.set({
                	multiSelect: true,
                	showFolderCheckBox: true,
                	checkRecursive: true,                
                	url: "${rootUrl}acl/listUserTree.do?roleId="+roleId,   
                	title: "选择用户",
                	expandOnLoad: true,
            		allowSelect: false,
            		enableHotTrack: false,
                	width: 350,
                	height: 450
            	});
            
            	win.show();
            	//初始化数据
           		win.setData(null, function (action) {
                	if (action == "ok") {
                    	//获取数据
                    	var data = win.getData();
                    	if (data) {
                    		ajaxFunction('${rootUrl }acl/alloUser.do?roleId='+roleId+'&userId='+data.id);
                    	}
                	}
            	});
        	}
        	
        	function alloAuth(roleId) {
           		var win = new TreeSelectWindow();
            	win.set({
                	multiSelect: true,
                	showFolderCheckBox: true,
                	checkRecursive: true,                
                	url: "${rootUrl}acl/listAuthTree.do?roleId="+roleId,   
                	title: "选择菜单",
                	expandOnLoad: true,
            		allowSelect: false,
            		enableHotTrack: false,
                	width: 350,
                	height: 450
            	});
            
            	win.show();
            	//初始化数据
           		win.setData(null, function (action) {
                	if (action == "ok") {
                    	//获取数据
                    	var data = win.getData();
                    	if (data) {
                    		ajaxFunction('${rootUrl }acl/alloAuth.do?roleId='+roleId+'&authId='+data.id);
                    	}
                	}
            	});
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
					<li>安全管理</li><li>角色管理</li>
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
									<span>&nbsp;&nbsp;<i class="fa fa-table"></i>&nbsp;&nbsp;<h2>角色列表</h2></span>
				
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
													<th>角色名称</th>
													<th>角色类型</th>
													<th class="col-xs-6 col-sm-4 col-md-2 col-lg-3">角色描述</th>
													<th>用户总数</th>
													<th>状态</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<%
												if(roleList != null && roleList.size() > 0) {
												for(int i =0;i<roleList.size();i++){
													RoleBean role = roleList.get(i);
													String status = "启用";
													Long state = role.getState();
													if(state == null || state == 0) {
														status = "禁用";
													}
												%>
												<tr>
													<td><%=i+1%></td>
													<td><%=role.getName()%></td>
													<td><%=role.getRoleType()%></td>
													<td><%=role.getDescription()%></td>
													<td><%=role.getUserNumber()%></td>
													<td><%=status%></td>
													<td>
														<button class="btn bg-color-blue txt-color-white" onclick="editRole('<%=role.getId() %>,<%=role.getName() %>,<%=role.getType() %>,<%=role.getDescription() %>,<%=role.getState() %>')">修改</button>&nbsp;
														<span class="dropdown">	
															<button type="button" class="btn bg-color-blue txt-color-white dropdown-toggle"  data-toggle="dropdown">更多操作<span class="caret"></span></button>								   
															<ul class="dropdown-menu" role="menu" >
																<li role="presentation">												    
																	<a href="javascript:void(0);" onclick="deleteRole(<%=role.getId() %>)" class="padding-10 padding-top-0 padding-bottom-0">删除</a>
																</li>
																<li class="divider"></li>
																<li role="presentation">
																<%if(state != null && state == 1) {%>
																	<a href="javascript:void(0);" onclick="changeState(<%=role.getId()%>,0)" class="padding-10 padding-top-0 padding-bottom-0">禁用</a>	
																<%} else { %>
																	<a href="javascript:void(0);" onclick="changeState(<%=role.getId()%>,1)" class="padding-10 padding-top-0 padding-bottom-0">启用</a>	
																<%}%>
																</li>
																<li role="presentation">												    
																	<a href="javascript:void(0);" onclick="alloUser('<%=role.getId() %>')" class="padding-10 padding-top-0 padding-bottom-0">分配用户</a>
																</li>
																<li role="presentation">												    
																	<a href="javascript:void(0);" onclick="alloAuth('<%=role.getId() %>')" class="padding-10 padding-top-0 padding-bottom-0">分配权限</a>
																</li>
															</ul>
														</span>
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
		<div id="myDialog" style="display:none;margin:0;">
			<form id ="roleForm" class="form-horizontal" method="post" onsubmit="return check();" >
				<fieldset>
					<input name="id" type="hidden" id="id">
					<div class="form-group">
						<label class="col-md-2 control-label">角色名称</label>
						<div class="col-md-10">
							<input class="form-control" type="text" name="name" id="name">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">角色类型</label>
						<div class="col-md-10">
							<select class="form-control" name="type" id="type">
								<c:forEach items="${paramList }" var="p" varStatus="list">
									<option value="${p.value }">${p.description }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">描述</label>
						<div class="col-md-10">
							<textarea class="form-control" rows="4" name="description" id="description"></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">状态</label>
						<div class="col-md-10">
							<input type="radio" checked="checked" name="state" value="1">
							<span>启用</span> 
							&nbsp;&nbsp;<input type="radio" name="state" value="0">
							<span>禁用</span> 
						</div>
					</div>
				</fieldset>
			</form>
			</div>
		<!-- 弹出窗口 -->
			
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
																$("#myDialog").dialog("open");
																document.getElementById("roleForm").reset(); 
																$("#myDialog").dialog({"title": "新增角色"});
														   		document.getElementById("roleForm").action = "${rootUrl }acl/addRole.do";
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
			
			/* END TABLETOOLS */
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
					});
					
		$(document).ready(function() {
			
			pageSetUp();
			
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
