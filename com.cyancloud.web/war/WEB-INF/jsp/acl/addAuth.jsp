<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		function typeVerify(me){
			if(/^\d+$/.test($("#type").val())){
				$("#type_verify").hide();
			}else{
				$("#type_verify").show();	
			}
		}
        function selectParent(e) {
            var buttonEdit = e.sender;
            var win = new TreeSelectWindow();
            win.set({
                expandOnLoad: true,           
                url: "${rootUrl}acl/listAuthTree.do" ,   
                title: "选择权限",
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
                    	document.getElementById('parentId').value = data.id;
                        buttonEdit.setValue(data.id);
                        buttonEdit.setText(data.text);

                    }
                }
            });
        }
        
		</script>
	</head>
	<body>
			<form id="myForm"  name="myForm" class="form-horizontal" action="${rootUrl }acl/doAddAuth.do"  method="post" >
				<fieldset>
						<input name="authenticity_token" type="hidden">
						<input type="hidden" id="parentId" name="parentId">
						<div class="form-group">
							<label class="col-md-2 control-label">名称</label>
							<div class="col-md-10">
								<input class="form-control" type="text" name="name" id="name">
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 control-label">图标</label>
							<div class="col-md-10">
								<input class="form-control" type="text" name="css" id="css" value="glyphicon glyphicon-th">
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-2 control-label">类型</label>
							<div class="col-md-10">
								<input class="form-control" type="text" name="type" id="type" onChange="typeVerify(this)">
								<div class="has-error" id="type_verify" hidden=true>
								<span class="help-block "><i class="fa fa-warning"></i>只能输入数字</span>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 control-label">权限代码</label>
							<div class="col-md-10">
								<input class="form-control" type="text" name="code" id="code">
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 control-label">父权限</label>
							<div class="col-md-10">
								<input id="selParentId" class="mini-buttonedit" onbuttonclick="selectParent"/> 
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 control-label">备注</label>
							<div class="col-md-10">
								<input class="form-control" type="area" name="remark" id="remark">
								<div class="checkbox">
									<label>
										<input type="checkbox" name="isMenu" id="isMenu">
										功能菜单 </label>
								</div>
							</div>
						</div>
					</fieldset>
			</form>
	</body>
</html>
