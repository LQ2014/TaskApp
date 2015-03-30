<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.web.util.CommonUtils"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html lang="en-us">
	<head>
				<script type="text/javascript">
	var mimetype = "application/x-vmware-remote-console-2012";
	var clsid = "CLSID:4AEA1010-0A0C-405E-9B74-767FC8A998CB";

	var isIE = /MSIE (\d+\.\d+);/.test(navigator.userAgent);
	var vmrc = null;
	
	function $(id)
	{
	   return document.getElementById(id);
	}

	function $V(id) {
	   return $(id).value;
	}
	
	function createPluginObject(parentId)
	{
	   var obj = document.createElement("object");
	   obj.setAttribute("id", "vmrc");
	   obj.setAttribute("height", "100%");
	   obj.setAttribute("width", "100%");
	   if (isIE) {
	      obj.setAttribute("classid", clsid);
	   } else {
	      obj.setAttribute("type", mimetype);
	   }

	   $(parentId).appendChild(obj);
	   return $('vmrc');
	}
	
	function init()
	{
	   vmrc = createPluginObject("main");
	   if (vmrc == null) {
	      return;
	   }
	   startup();
	   connect();
	 }
	
	
	function connect() {
		var host = "${virtualHost}";
		var ticket = "${ticket}";
		var vmid = "${instId}";
	   try {
	      var ret = vmrc.connect(host, "", true,
	                             ticket, "", "", vmid, "", "");
	   } catch (err) {
	      log('connect failed: ' + err);
	   }
	}
	
	function startup()
	{
	   var modes = 2;
	   var msgMode = 1;
	   var advancedConfig ="";

	   try {
	      var ret = vmrc.startup(modes, msgMode, advancedConfig);
	   } catch(err) {
	      log('startup call failed: ' + err);
	   }
	}
	
	function log(text)
	{
	  alert(text);
	}
	
</script>
	
	</head>
	<body onload="init()" style="padding:0; margin:0;">
    	<div style="width:100%; line-height:50px; text-align:center; color:#F00; font-size:24px;">按“Ctrl”+“Alt”+"Enter"可以全屏和退出全屏，按“Ctrl”+“Alt”可以释放鼠标</div>
		<!-- MAIN PANEL -->
		<div id="main" name="main" style="width: 100%; height:-moz-calc(100% - 50px); height:-webkit-calc(100% - 50px); height: calc(100% - 50px);position: absolute;top: 50px;left:0px; z-index:1048; overflow:hidden;">

			
		</div>

	</body>

</html>
