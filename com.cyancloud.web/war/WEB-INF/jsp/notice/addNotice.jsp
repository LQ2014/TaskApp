<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*"%>
<% 
String path="notice/listNotice";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" /><link href="${rootUrl}css/jqmini/demo.css" rel="stylesheet" type="text/css" />
    	<script src="${rootUrl}js/scripts/boot.js" type="text/javascript"></script>
    	<script src="${rootUrl}js/commonlibs/TreeSelectWindow.js" type="text/javascript"></script>  
    	
    	<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen"
			href="${rootUrl}css/bootstrap.min.css">
		
		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
		
		<link rel="stylesheet" type="text/css" media="screen"
			href="${rootUrl}css/smartadmin-skins.min.css">
		<!-- SmartAdmin RTL Support is under construction
			 This RTL CSS will be released in version 1.5
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-rtl.min.css"> -->
		<script type="text/javascript" language="javascript">       
        function selectUnit(e) {
            var buttonEdit = e.sender;
            var win = new TreeSelectWindow();
            win.set({
               	multiSelect: true,
                showFolderCheckBox: true,
                checkRecursive: false,     
                expandOnLoad: true,           
                url: "${rootUrl}acl/listOuTree.do?ids="+buttonEdit.getValue() ,   
                title: "选择部门",
                width: 400,
                height: 400
            });
            
            win.show();

            //初始化数据
            win.setData(null, function (action) {
                if (action == "ok") {
                    //获取数据
                    var data = win.getData();
                    if (data) {
                    	document.getElementById('unitIds').value = data.id;
                        buttonEdit.setValue(data.id);
                        buttonEdit.setText(data.text);

                    }
                }
            }); 
        }
		
		</script>
	</head>
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
					<li>通知公告</li><li>发布通知公告</li>
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
									<span>&nbsp;&nbsp;<i class="fa fa-edit"></i>&nbsp;&nbsp;<h2>发布通知公告</h2></span>
									
								</header>
								<!-- widget div-->
								<div>
									<!-- widget edit box -->
									<div class="jarviswidget-editbox">
										<!-- This area used as dropdown edit box -->
									</div>
									<!-- end widget edit box -->
				
									<!-- widget content -->
									<div class="widget-body">
									<form id="addNoticeForm"  name="addNoticeForm" class="form-horizontal" action="${rootUrl }notice/doAddNotice.do"  method="post" >
										<fieldset>
											<input name="authenticity_token" type="hidden">	
											<div class="form-group">
												<label class="col-md-2 control-label">标题</label>
												<div class="col-md-7">
													<input class="form-control required" type="text" name="title" id="title" >
												</div>
											</div>		
											<div class="form-group">
												<label class="col-md-2 control-label">选择部门</label>
												<div class="col-md-10">
													<input id="unitIds" name="unitIds" class="mini-buttonedit" allowInput=false onbuttonclick="selectUnit" text=""/>   
												</div>
											</div>
											<div class="form-group">
												<label class="col-md-2 control-label">选择人员</label>
												<div class="col-md-10">
													<input id="employeeIds" name="employeeIds" class="mini-buttonedit" allowInput=false onbuttonclick="selectEmployee" text=""/>   
												</div>
											</div>
											<div class="form-group">
												<label class="col-md-2 control-label">内容</label>
												<div class="col-md-7">
													<textarea rows="6" name="content" class="form-control required" id="noticecontent"></textarea>
												</div>
											</div>	
											<div class="form-group">
												<label class="col-md-2 control-label">&nbsp;&nbsp;</label>												
												<div class="col-md-7">
													<div class="checkbox">
															<label>
															  <input type="checkbox" class="checkbox style-0" name="flagIsPublished" id="flagIsPublished">
															  <span>是否立即发布</span>
															</label>
														</div>
												</div>
											</div>	
					
																											
										</fieldset>
										<div class="smart-form">
										<footer style="background:#FFF;">
											<button type="button" onclick="back()" class="btn btn-primary">返回</button>
											&nbsp;
											<button class="btn btn-default" type="reset">重置</button>
											&nbsp;
											<button type="button" class="btn btn-primary" onclick="submitForm()">提交</button>
										</footer>
										</div>
									</form>
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
				
				</section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<!-- END MAIN PANEL -->

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

		
		

		<!-- MAIN APP JS FILE -->
		<script src="${rootUrl}js/app.min.js"></script>

		<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
		<!-- Voice command : plugin -->
		<script src="${rootUrl}js/speech/voicecommand.min.js"></script>

		<!-- PAGE RELATED PLUGIN(S)
		<script src="..."></script> -->
		

		<script type="text/javascript">
		
		// DO NOT REMOVE : GLOBAL FUNCTIONS!
		
		$(document).ready(function() {			
			pageSetUp();
			$("#addNoticeForm").reset();
		})
		
		function back(){
			window.location = "${rootUrl }notice/listNotice.do";
		}
		
		function selectEmployee(e){
			var buttonEdit = e.sender;
			var html ='<div id="dialog-window" title="选择员工"><iframe id="myFrame"src="${rootUrl}notice/selectEmployee.do" frameBorder="0" style="border: 0; " scrolling="no"  class="col-lg-12" height="100%"></iframe></div>';
		    $(html).dialog($.extend({
				modal: true,
				width:900,
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
						$(this).dialog("close");
					}
				}, {
					html : "<i class='fa fa-check'></i>&nbsp; 确定",
					"class" : "btn btn-primary",
					click : function() {
						var checkboxs = document.getElementById("myFrame").contentWindow.document.getElementsByName("checkbox");
						var employeeIds = "";
						var employeeName = "";
						if(checkboxs){
							for(var i=0;i<checkboxs.length;i++){
								var checkbox = checkboxs[i];
								if(checkbox.checked){
									employeeIds+=($(checkbox).attr("value")+",");
									employeeName+=($(checkbox).attr("hiddentext")+",");
								}
							}
							employeeIds = employeeIds.substring(0,employeeIds.lastIndexOf(","));
							employeeName = employeeName.substring(0,employeeName.lastIndexOf(","));
						}	
						document.getElementById('employeeIds').value = employeeIds;
						buttonEdit.setValue(employeeIds);
                        buttonEdit.setText(employeeName);
						$(this).dialog("close");
						
					}
				}]
		    }));
		}
		
		function submitForm(){
			var unitIds = $('#unitIds').val();
			var employeeIds = $('#employeeIds').val();	
			var flagIsPublished = document.getElementById("flagIsPublished").checked;
			var title = $("#title").val();
			var content = $("#noticecontent").val();			
			if(!unitIds && !employeeIds){
				alert('请选择通知公告发布的部门或者员工！');
				return false;
			}
			if($("#addNoticeForm").valid()){
				$.ajax({
					url : '${rootUrl }notice/doAddNotice.do',
					dataType :'json',
					method : 'post',
					data : {unitIds: unitIds,employeeIds:employeeIds,noticetilte:title,content:content,flagIsPublished:flagIsPublished},
					success : function(jsonData){
						if(jsonData.success){
							alert('发布通知成功！')
							window.location.reload(true);
						}else{
							alert('发布通知失败！')
						}
					}
				});
			}
			
		}

		</script>

		

	</body>

</html>