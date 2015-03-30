<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*,net.sf.json.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.service.model.*"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
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
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" /><link href="${rootUrl}css/jqmini/demo.css" rel="stylesheet" type="text/css" />
    	<script src="${rootUrl}js/scripts/boot.js" type="text/javascript"></script>
    	<script src="${rootUrl}js/commonlibs/TreeSelectWindow.js" type="text/javascript"></script>  
    	
		
		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
		
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-skins.min.css">
		<!-- SmartAdmin RTL Support is under construction
			 This RTL CSS will be released in version 1.5
		<link rel="stylesheet" type="text/css" media="screen" href="${rootUrl}css/smartadmin-rtl.min.css"> -->
<% 
	List<VResourcePool> poolList = (List<VResourcePool>)request.getAttribute("poolList");
	List<VMachine> templateList = (List<VMachine>)request.getAttribute("templateList");
	List<VCenter> vCenterList = (List<VCenter>)request.getAttribute("vCenterList");
	List<BillingPackageBean> packageList = (List<BillingPackageBean>) request.getAttribute("packageList");
	Map<Long,BillingPackageBean> billMap = (Map<Long,BillingPackageBean>) request.getAttribute("billMap");
	Map<Long,VMachine> vmMap = (Map<Long,VMachine>) request.getAttribute("vmMap");
 %>
		<script type="text/javascript" language="javascript">
        function listVerify(me){
			if(/^\d+$/.test($("#list").val())){
				$("#list_verify").hide();
			}else{
				$("#list_verify").show();	
			}
		}
       	function alloUser(e) {
       		var buttonEdit = e.sender;
           	var win = new TreeSelectWindow();
            win.set({
               	multiSelect: true,
               	showFolderCheckBox: false,
               	checkRecursive: false,                
               	url: "${rootUrl}acl/listUserTree.do?roleId=-1",   
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
                   		document.getElementById('userIds').value = data.id;
                   		console.log(data)
                        buttonEdit.setValue(data.id);
                        buttonEdit.setText(data.text);
                   	}
                }
            }); 
        }
        
        function clickCombo(){
        	document.getElementById("template_id").disabled =  true;
        	document.getElementById("combo_id").disabled =  false;
        	changeCombo();
        }
        
        function clickTemplate(){
        	document.getElementById("template_id").disabled =  false;
        	document.getElementById("combo_id").disabled =  true;
        	changeTemp();
        }
        
      	function changeTemp(){
      		var obj = document.getElementById("template_id");
			var template_id = obj.options[obj.selectedIndex].value;
			var vmmap = <%=JSONObject.fromObject(vmMap).toString()%>;
			if(template_id==0 || vmmap[template_id]==null){
				document.getElementById("vm_cpu").value = "";
		       	document.getElementById("vm_memory").value = "";
		       	document.getElementById("vm_os").value = "";
	        	document.getElementById("vm_hdisk").value = "";
	        	return
			}
			
			document.getElementById("vm_cpu").value = vmmap[template_id].cpuNum;
			document.getElementById("vm_os").value = vmmap[template_id].osType;
		    document.getElementById("vm_memory").value = vmmap[template_id].memory/1024;
	        document.getElementById("vm_hdisk").value = parseInt(vmmap[template_id].totalCapacity/1024);
      	}
      	
      	function changeCombo(){
      		var obj = document.getElementById("combo_id");
			var combo_id = obj.options[obj.selectedIndex].value;
			var vmmap = <%=JSONObject.fromObject(billMap).toString()%>;
			if(combo_id==0 || vmmap[combo_id]==null){
				document.getElementById("vm_cpu").value = "";
				document.getElementById("vm_os").value = "";
		       	document.getElementById("vm_memory").value = "";
	        	document.getElementById("vm_hdisk").value = "";
	        	return
			}
			document.getElementById("vm_cpu").value = vmmap[combo_id].cpu;
			document.getElementById("vm_os").value = vmmap[combo_id].os;
		    document.getElementById("vm_memory").value = vmmap[combo_id].memory/1024;
	        document.getElementById("vm_hdisk").value = parseInt(vmmap[combo_id].capacity/1024);
      	}
		</script>
	</head>
	<body>
		<form id="createVMForm"  name="createVMForm" class="smart-form" action=""  method="post" >
			<fieldset>
				<div class="row" >
					<section class="col col-2">
						<label class="control-label">虚拟机名称</label>
					</section>
					<section class="col col-10">
						<input class="form-control" type="text" name="vmName" id="vmName">
					</section>
				</div>

				<div class="row">
					<section class="col col-2">
						<label style="margin-top:6px;">数据中心</label>
					</section>
					<section class="col col-4">
						<label class="input">
							<select class="form-control" name="memory" id="memory">
								<option value="0">请选择</option>
								<%if(vCenterList != null && vCenterList.size() > 0) {
									for(int i=0;i<vCenterList.size();i++) {
									VCenter vc = vCenterList.get(i);
								%>
									<option value="<%=vc.getElementId() %>"><%=vc.getServerName()%></option>
								<%
									}
								}%>
							</select>
						</label>
					</section>
					<section class="col col-2">
						<label style="margin-top:6px">资源池</label>
					</section>
					<section class="col col-4">
						<label class="input">
							<select class="form-control" name="memory" id="memory" >
								<option value="0">请选择</option>
								<%if(poolList != null && poolList.size() > 0) {
									for(int i=0;i<poolList.size();i++) {
									VResourcePool pool = poolList.get(i);
								%>
									<option value="<%=pool.getElementId()%>"><%=pool.getName()%></option>
								<%
									}
								}%>
							</select>
						</label>
					</section>
				</div>
				
				<div class="row">
					<section class="col col-2">
						<input type="radio" checked name="state" value="1" onclick="clickCombo()">&nbsp&nbsp
						<label style="margin-top:6px;">套餐</label>
					</section>
					<section class="col col-4">
						<label class="input">
							<select class="form-control" checked name="memory" id="combo_id" onchange="changeCombo()">
								<option value="0">请选择</option>
								<%if(packageList != null && packageList.size() > 0) {
									for(int i=0;i<packageList.size();i++) {
									BillingPackageBean bill = packageList.get(i);
								%>
									<option value="<%=bill.getId()%>"><%=bill.getName()%></option>
								<%
									}
								}%>
							</select>
						</label>
					</section>
					<section class="col col-2">
						<input type="radio"  name="state" value="1" onclick="clickTemplate()">&nbsp&nbsp
						<label style="margin-top:6px">模板</label>
					</section>
					<section class="col col-4">
						<label class="input">
							<select class="form-control" disabled = true name="memory" id="template_id" onchange="changeTemp()">
								<option value="0">请选择</option>
								<%if(templateList != null && templateList.size() > 0) {
									for(int i=0;i<templateList.size();i++) {
									VMachine vm = templateList.get(i);
								%>
									<option value="<%=vm.getElementId()%>"><%=vm.getName()%></option>
								<%
									}
								}%>
							</select>
						</label>
					</section>
				</div>
				
				<div class="row">
					<section class="col col-2">
						<label style="margin-top:6px;">操作系统</label>
					</section>
					<section class="col col-4">
						<label class="input">
							<input class="form-control" type="text" readOnly id="vm_os">
						</label>
					</section>
					<section class="col col-2">
						<label style="margin-top:6px">CPU核数（个）</label>
					</section>
					<section class="col col-4">
						<input class="form-control" type="text" readOnly id="vm_cpu">
					</section>
				</div>
				<div class="row">
					<section class="col col-2">
						<label style="margin-top:6px;">内存（GB）</label>
					</section>
					<section class="col col-4">
						<label class="input">
							<input class="form-control" type="text" readOnly id="vm_memory">
						</label>
					</section>
					<section class="col col-2">
						<label style="margin-top:6px">存储空间（GB）</label>
					</section>
					<section class="col col-4">
						<input class="form-control" type="text" readOnly id="vm_hdisk">
					</section>
				</div>
				<div class="row" >
					<section class="col col-2">
						<label class="control-label">使用人</label>
					</section>
					<input id="userIds" name="userIds" class="mini-buttonedit col col-4" allowInput=false onbuttonclick="alloUser"/>   
					<section class="col col-6">
						<label class="control-label">如不选择，则该虚拟机不指定使用人</label>
					</section>
				</div>
				<div class="row" >
					<section class="col col-2">
						<label class="control-label">使用期限</label>
					</section>
					<section class="col col-4">
						<input type="radio" name="life" value="3">
						<span>三个月</span> 
						&nbsp;&nbsp;<input type="radio" name="life" value="6">
						<span>半年</span> 
						&nbsp;&nbsp;<input type="radio" name="life" value="12" checked="checked">
						<span>一年</span>
					</section>
				</div>
			</fieldset>
		</form>
	</body>
</html>
