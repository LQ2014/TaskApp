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
        function selectParentUnit(e) {
            var buttonEdit = e.sender;
            var win = new TreeSelectWindow();
            win.set({
               // multiSelect: true,
                showFolderCheckBox: true,
                checkRecursive: true,     
                expandOnLoad: true,           
                url: "${rootUrl}acl/listOuTree.do?ids="+buttonEdit.getValue() ,   
                title: "选择上级部门",
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
                    	document.getElementById('unitParentId').value = data.id;
                        buttonEdit.setValue(data.id);
                        buttonEdit.setText(data.text);

                    }
                }
            }); 
        }
		
		</script>
	</head>
	<body>
		<form id="addUnitForm"  name="addUnitForm" class="form-horizontal" action="${rootUrl }acl/doAddUnit.do"  method="post" >
			<fieldset>
				<input name="authenticity_token" type="hidden">				
				<div class="row">
					<label class="col-md-2 control-label">部门名称</label>
					<div class="col-md-10">
						<input class="form-control required" type="text" name="name" id="name" >
					</div>
				</div>				
						
				<div class="row">
					<label class="col-md-2 control-label">上级部门</label>
					<div class="col-md-10">
						<input id="unitParentId" name="parentId" class="mini-buttonedit" allowInput=false onbuttonclick="selectParentUnit" text=""/>   
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label">备注</label>
					<div class="col-md-10">
						<textarea rows="4" name="note" class="form-control"></textarea>
					</div>
				</div>			
				
			</fieldset>
		</form>
	</body>
</html>
