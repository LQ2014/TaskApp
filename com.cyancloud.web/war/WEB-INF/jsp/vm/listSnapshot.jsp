<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.service.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="vm/listSnapshot";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<%
	List<VSnapshotBean> vSnapshotList = (List<VSnapshotBean>)request.getAttribute("vSnapshotList");
%>
<!DOCTYPE html>
<html lang="en-us">
	<!--引用的文件 Begin-->
        <link id="vsStyle" href="${rootUrl}css/treetable/vsStyle/jquery.treeTable.css" rel="stylesheet" type="text/css" />
        <script src="${rootUrl}js/scripts/jquery-2.1.1.min.js"></script>
        <script src="${rootUrl}js/treetable/jquery.treetable.lazy.shut.js"></script>
    <!--引用的文件 End-->
<script type="text/javascript">
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
						虚拟机
					</li>
					<li>
						快照管理
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
						
						<!-- 实体机 -->
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
									快照管理
								</h2>
							</span> </header>
	
							<!-- widget div-->
							<div>
	
								<!-- widget edit box -->
								<div class="jarviswidget-editbox">
									<!-- This area used as dropdown edit box -->
	
								</div>
								<!-- end widget edit box -->
								<!--start-->
									<div class="widget-body no-padding">
										<table id="myTreeTable" class="table table-striped table-bordered table-hover table-responsive" >
											<div class="container">
											<thead>		
											<tr>
											<div class="row">
												<th class="col-sm-2 col-md-2">
													所属虚拟机
												</th>
												<th class="col-sm-1 col-md-2">
													快照名称
												</th>
												<th class=" hidden-xs col-sm-1 col-md-1">
													创建人
												</th>
												<th class="col-sm-1 col-md-2">
													创建时间
												</th>
												<th class="hidden-xs col-sm-3 col-md-3">
													描述
												</th>				
												<th class="col-xs-5 col-sm-4 col-md-2 ">
													操作
												</th>
												</div>
											</tr>			
											</thead>
											<tbody>	
											
											<%
											String vmInst="";
											for(VSnapshotBean bean :vSnapshotList){
												if(!bean.getVmInst().equalsIgnoreCase(vmInst)){
												vmInst=bean.getVmInst();
											%>
											<tr id="<%=vmInst%>" pid="0"  >
												<td ><span controller="true">&nbsp;&nbsp;<img src="${rootUrl}img/treetable/folder.png"> &nbsp;<%=bean.getVmName() %></span></td>
												<td ></td>
												<td class="hidden-xs"></td>
												<td ></td>
												<td class="hidden-xs"></td>
												<td></td>
											</tr>
											<%
											}	
											%>
											<tr id="<%=bean.getInstId()%>" pid="<%=vmInst%>">
												<td ><span controller="true">&nbsp;&nbsp;<img src="${rootUrl}img/treetable/file.png"> &nbsp;<%=bean.getVmName()%></span></td>
												<td ><%=bean.getName() %></td>
												<td class="hidden-xs" ></td>
												<td ><%=bean.getSnapCreateTime() %></td>
												<td class="hidden-xs"><%=bean.getDescription() %></td>
												<td>
												 <button class="btn bg-color-yellow txt-color-white" onclick="removeS('<%=bean.getVmInst()%>','<%=bean.getInstId()%>');">删除</button>
<%-- 																	<%=vSnapshot[7]%><%=vSnapshot[8]%> --%>
														<div class="btn-group">
														   <button type="button" class="btn btn-primary dropdown-toggle" 
														      data-toggle="dropdown">
														      	更多操作 <span class="caret"></span>
														   </button>
														   <ul class="dropdown-menu" role="menu" style="width:10px;">
														      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="restoreS('<%=bean.getVmInst()%>','<%=bean.getInstId()%>');">还原快照</a></li>
														      <li><a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" onclick="editS('<%=bean.getInstId()%>','<%=bean.getName()%>','<%=bean.getDescription()%>');">编辑快照</a></li>
														   </ul>
													</div>
												</td>
										</tr>	
											<% 
												
												}
											%>																
											</tbody>
											</div>
										</table>
									
									</div>
									<!--end-->
							</div>
							<!-- end widget div -->
	
						</div>
						<!-- 物理机 -->
						
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
		<div id="snapshot" style="display:none;margin:0;">
			<div id="snapshot-message">
				
			</div>
		</div>
		<!-- 编辑快照-->
		<div id="editSnapshot" style="display:none;margin:0;">
		<form id="editSnapshotForm" class="form-horizontal" role="form">
			<br>
			   <div class="form-group">
			      <label for="firstname" class="col-sm-3 control-label">快照名称：</label>
			      <div class="col-sm-8">
			         <input type="text" class="form-control required" id="snapName"  name="snapName"
			            placeholder="请输入名字">
			      </div>
			   </div>
			   <div class="form-group">
			      <label for="lastname" class="col-sm-3 control-label">快照描述：</label>
			      <div class="col-sm-8">
			            <textarea class="form-control required" rows="3"  id="snapDescription" name="snapDescription"></textarea>
			      </div>
			   </div>
		</div>
		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
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
		<script
			src="${rootUrl}js/plugin/jquery-validate/jquery.validate.min.js"></script>
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
	function removeS(vmInst,snapInst){
	
		$("#snapshot-message").html("<h3>是否删除当前快照？</h3>")  ;
		$("#snapshot").dialog("open");
		$("#snapshot").dialog({height:210,width:400});
		$("#snapshot").dialog({url:"${rootUrl}vm/removeSnapshot.do?vmInst="+vmInst+"&snapInst="+snapInst});
	}
	function restoreS(vmInst,snapInst){
		$("#snapshot-message").html("<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;此操作将使虚拟机状态丢失，您可通过保存快照方式保存当前状态。请问是否恢复当前快照？</h5>")  ;
		$("#snapshot").dialog("open");
		$("#snapshot").dialog({height:210,width:400});
		$("#snapshot").dialog({url:"${rootUrl}vm/restoreSnapshot.do?vmInst="+vmInst+"&snapInst="+snapInst});
	}	
	function editS(snapInst,snapName,snapDescription){
		$("#snapName").val(snapName);
		$("#snapDescription").val(snapDescription);
		$("#editSnapshot").dialog("open");
		$("#editSnapshot").dialog({height:300,width:450});
		$("#editSnapshot").dialog({url:"${rootUrl}vm/editSnapshot.do?snapInst="+snapInst});
	}
	$(document).ready(function() {
		pageSetUp();
		/* TABLETOOLS */
			
		$("#snapshot").dialog({
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
				click : function() {
					ajaxFunction($("#snapshot").dialog("option","url"));
					$(this).dialog("close");
				}
			}]
						
		});
      $("#editSnapshot").dialog({
			autoOpen : false,
			modal : true,
			draggable:false,
			position:"center",
			resizable :false,
			title:"编辑快照",	
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
					if($('#editSnapshotForm').valid()){
					var url=$("#editSnapshot").dialog("option","url");
					var snapName=document.getElementById("snapName").value;
					var snapDescription=document.getElementById("snapDescription").value;
					window.location.href=$("#editSnapshot").dialog("option","url")+"&snapName="+snapName+"&snapDescription="+snapDescription;
					$(this).dialog("close");
					}
				}
			}]
						
		});
			$('#myTreeTable').dataTable(); 
			$('#editSnapshotForm').validate();
						
	});
</script>
	</body>

</html>
