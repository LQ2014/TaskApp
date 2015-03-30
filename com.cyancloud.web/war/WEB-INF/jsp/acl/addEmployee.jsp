<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.cyancloud.model.system.*"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" /><link href="${rootUrl}css/jqmini/demo.css" rel="stylesheet" type="text/css" />
    	<script src="${rootUrl}js/scripts/boot.js" type="text/javascript"></script>
    	<script src="${rootUrl}js/commonlibs/TreeSelectWindow.js" type="text/javascript"></script>  
    	<script src="${rootUrl}js/ajaxfileupload.js" type="text/javascript"></script>
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
               // multiSelect: true,
                showFolderCheckBox: true,
                checkRecursive: true,     
                expandOnLoad: true,           
                url: "${rootUrl}acl/listOuTree.do?ids="+buttonEdit.getValue() ,   
                title: "选择部门",
                width: 350,
                height: 250
            });
            
            win.show();

            //初始化数据
            win.setData(null, function (action) {
                if (action == "ok") {
                    //获取数据
                    var data = win.getData();
                    if (data) {
                    	document.getElementById('unitId').value = data.id;
                        buttonEdit.setValue(data.id);
                        buttonEdit.setText(data.text);

                    }
                }
            }); 
        }
		
		</script>
	</head>
	<body style="overflow-x : hidden; width: 95%;">
		<form id="addEmployeeForm"  name="addEmployeeForm" class="form-horizontal" action="${rootUrl }acl/doAddEmployee.do"  method="post" >
			<fieldset>
				<input name="authenticity_token" type="hidden">				
				<div class="row">
					<label class="col-md-2 control-label">工号</label>
					<div class="col-md-10">
						<input class="form-control required" message="请输入工号" type="text" name="code" id="code" >
					</div>
				</div>				
				<div class="row">
					<label class="col-md-2 control-label">头像</label>
					<div class="col-md-10">
						<input type="file" name="icon" id="icon">
   						<input type="button" value="上传" id="upload">
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">姓名</label>
					<div class="col-md-10">
						<input class="form-control required" message="请输入姓名" type="text" name="name" id="name" >
					</div>
				</div>	
				<div class="row">
					<label class="col-md-2 control-label">昵称</label>
					<div class="col-md-10">
						<input class="form-control required" message="请输入昵称" type="text" name="nickname" id="nickname" >
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">手机</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="phone" id="phone" >
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">微信</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="weixin" id="weixin" >
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">QQ</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="qq" id="qq" >
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">邮箱</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="email" id="email" >
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">地址</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="address" id="address" >
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">简介</label>
					<div class="col-md-10">
						<textarea class="form-control" rows="4" name="resume" id="resume"></textarea>
					</div>
				</div>			
				<div class="row">
					<label class="col-md-2 control-label">所属部门</label>
					<div class="col-md-10">
						<input id="unitId" name="unitId" class="mini-buttonedit" allowInput=false onbuttonclick="selectUnit" text=""/>   
					</div>
				</div>
				<!-- 
				<div class="row">
					<label class="col-md-2 control-label">备注</label>
					<div class="col-md-10">
						<textarea rows="4" name="note" class="form-control"></textarea>
					</div>
				</div>			
				 -->
			</fieldset>
		</form>
	</body>
	<script type="text/javascript">
	$("#upload").click(function(){
		var file = $("#icon").val();
		if(file==""){
			alert("请选择上传的头像");
			return;
		}
		else{
			//判断上传的文件的格式是否正确
  			var fileType = file.substring(file.lastIndexOf(".")+1);
  			if(fileType!="png"&&fileType!="jpg"){
  				alert("上传文件格式错误");
  				return;
  			}
			else{
				var url = "/upload/uploadIcon.do?nowtime="+new Date().getTime() + "&code=" + $("#code").val();
  				$.ajaxFileUpload({
  					url:url,
  					secureuri:false,
  					fileElementId:"icon",        //file的id
     					dataType:"text",                  //返回数据类型为文本
  					success:function(data,status){
  						if(data=="1"){
  				 			alert("请上传宽度大于200像素和高度大于200像素的图片");
  						}
  						else if(data=="2"){
  				 			alert("请上传宽高比不超过2的图片");
  						}
  						else if(data=="3"){
  				 			alert("请上传文件大小不大于2M的图片");
  						}	
  						else{
  				 			$("#uploadImage").hide();
  				 			$("#srcImg").attr("src",data);
  				 			$("#previewImg").attr("src",data);
  				 			$("#cutImage").show();
  				 			$("#bigImage").val(data);
  				 			cutImage();         //截取头像
  				 		}
  					}
				});
			}
		}
	});
	</script>
</html>
