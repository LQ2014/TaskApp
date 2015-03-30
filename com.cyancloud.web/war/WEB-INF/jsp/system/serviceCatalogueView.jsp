<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*"%>
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
        function listVerify(me){
			if(/^\d+$/.test($("#list").val())){
				$("#list_verify").hide();
			}else{
				$("#list_verify").show();	
			}
		}
        function selectRole(e) {
            var buttonEdit = e.sender;
            var win = new TreeSelectWindow();
            win.set({
                multiSelect: true,
                showFolderCheckBox: true,
                checkRecursive: true,     
                expandOnLoad: true,           
                url: "${rootUrl}acl/listRoleTree.do?ids="+buttonEdit.getValue() ,   
                title: "选择角色",
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
                    	document.getElementById('roleIds').value = data.id;
                        buttonEdit.setValue(data.id);
                        buttonEdit.setText(data.text);

                    }
                }
            }); 
        }
		</script>
	</head>
	<body>
	<% 	
		ServiceItem item = (ServiceItem)request.getAttribute("serviceItem"); 
		Map<String,String> roleMap = (Map<String,String>) request.getAttribute("roleMap");
		List<Object[]> params = (List<Object[]>) request.getAttribute("params");
		String typeId = request.getAttribute("typeId").toString();
	%>
		<form id="myServiceCataForm"  name="myServiceCataForm" class="form-horizontal" action="${rootUrl }system/addServiceCatalogue.do"  method="post" >
			<fieldset>
				<input name="authenticity_token" type="hidden">
				<input name="id" type="hidden" id="id" value="<%if(item!=null){%><%=item.getId()%><%}%>">
				<div class="row">
					<label class="col-md-3 control-label">服务名称</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="name" id="name" value="<%if(item!=null){%><%=item.getName()%><%}%>">
					</div>
				</div>

				<div class="row">
					<label class="col-md-3 control-label">图标</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="icon" id="icon" value="<%if(item!=null && item.getIcon()!=null){%><%=item.getIcon()%><%}else{%>glyphicon glyphicon-th<%}%>">
					</div>
				</div>
				<div class="row">
					<label class="col-md-3 control-label">服务说明</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="description" id="description" value="<%if(item!=null){%><%=item.getDescription()%><%}%>">
					</div>
				</div>
						
				<div class="row">
							
				</div>
						
				<div class="row">
					<label class="col-md-3 control-label">角色权限</label>
					<div class="col-md-10">
						<input id="roleIds" name="roleIds" class="mini-buttonedit" allowInput=false onbuttonclick="selectRole" text="<%if(roleMap!=null){%><%=roleMap.get("value")%><%}%>" value="<%if(roleMap!=null){%><%=roleMap.get("ids")%><%}%>"/>   
					</div>
				</div>
						
				<div class="row">
					<label class="col-md-3 control-label">服务分类</label>
					<div class="col-md-10">
						<section>
								<select class="form-control required" name="type" id="type" >
								<%if(params!=null){
									for(int i=0;i<params.size();i++){ 
										Object[] object = params.get(i);
								%>
									<option value="<%=object[0]%>" <%if(typeId.equals(object[0].toString())) {%>selected<%} %>><%=object[1]%></option>
								<%	} 
								}%>
								</select> <i></i> 
						</section>
					</div>
				</div>
				<div class="row">
					<label class="col-md-3 control-label">状态</label>
					<div class="col-md-10">
						<input type="radio" <%if(item==null || (item!=null && item.getState())){%>checked="checked"<%}%> name="state" value="1">
						<span>启用</span> 
						&nbsp;&nbsp;<input <%if(item!=null && !item.getState()){%>checked="checked"<%}%>type="radio" name="state" value="0">
						<span>禁用</span> 
					</div>
				</div>
				<div class="row">
					<label class="col-md-3 control-label">应用连接</label>
					<div class="col-md-10">
						<input class="form-control" type="text" name="url" id="url" value="<%if(item!=null){%><%=item.getUrl()%><%}%>">
					</div>
				</div>
				<div class="row">
					<label class="col-md-3 control-label">排序</label>
					<div class="col-md-10">
						<input class="form-control" type="text" onChange="listVerify(this)" name="list" id="list" value="<%if(item!=null){%><%=item.getList()%><%}else{%>1<%}%>">
						<div class="has-error" id="list_verify" hidden=true>
							<span class="help-block "><i class="fa fa-warning"></i>只能输入数字</span>
						</div>
					</div>
				</div>
			</fieldset>
		</form>
	</body>
</html>
