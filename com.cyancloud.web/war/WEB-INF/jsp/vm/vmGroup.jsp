<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cyancloud.model.system.*,com.cyancloud.model.desktop.*,com.cyancloud.model.vm.*,com.cyancloud.web.util.CommonUtils"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
String path="vm/listMachine";
%>
<jsp:include page="/WEB-INF/jsp/include.jsp">
	<jsp:param name="page" value="<%=path %>" />
</jsp:include>
<!DOCTYPE html>
<script src="${rootUrl}js/libs/jquery-2.1.1.min.js"></script>
<script src="${rootUrl}js/libs/jquery-ui-1.10.3.min.js"></script>
<script src="${rootUrl}js/app.config.js"></script>
<script src="${rootUrl}js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script>
<script src="${rootUrl}js/bootstrap/bootstrap.min.js"></script>
<script src="${rootUrl}js/app.min.js"></script>
<link rel="stylesheet" href="${rootUrl }js/plugin/jstree/themes/default/style.min.css" />
<script src="${rootUrl }js/plugin/jstree/jstree.js"></script>
<script src="${rootUrl}js/plugin/datatables/jquery.dataTables.min.js"></script>
<script src="${rootUrl}js/plugin/datatables/dataTables.colVis.min.js"></script>
<script src="${rootUrl}js/plugin/datatables/dataTables.tableTools.min.js"></script>
<script src="${rootUrl}js/plugin/datatables/dataTables.bootstrap.min.js"></script>
<script src="${rootUrl}js/plugin/datatable-responsive/datatables.responsive.min.js"></script>
<script>
	function create(){
		$("#createGroup").dialog("open");
	}
	//将form转为AJAX提交
	function ajaxSubmit(frm) {
		//提交前检查
		if(true) {
			var dataPara = getFormJson(frm);
    		$.ajax({
        		url: frm.action,
        		type: frm.method,
        		data: dataPara,
        		success: function(){
					$("#createGroup").dialog("close"); 
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
	$(document).ready(function() {
		var t = $("#vmTable").dataTable();
		var tree = $("#jstree").jstree({
		    "core" : {
		    	"check_callback" : true,
		        "data":{
		        	"dataType":"json",
		        	"url" : "${rootUrl}vm/loadGroupTree.do",
		            "data" : function (node) {
		                return  { "pid" : node.id };
		            }
		        },
		     	"animation":true,
		     	"multiple":true,
		     	"themes":{
            		"dots" : true,  
            		"icons" : true,
            		"stripes": true,
            		"variant":true
		     	}
		     },
		     "contextmenu":{
		     	"items":function (o, cb) { // Could be an object directly
					return {
						"create" : {
							"separator_before"	: false,
							"separator_after"	: true,
							"_disabled"			: false, //(this.check("create_node", data.reference, {}, "last")),
							"label"				: "新建",
							"action"			: function (data) {
								var inst = $.jstree.reference(data.reference),
									obj = inst.get_node(data.reference);
								inst.create_node(obj, {}, "last", function (new_node) {
									setTimeout(function () { inst.edit(new_node); },0);
								});
							}
						},
						"rename" : {
							"separator_before"	: false,
							"separator_after"	: false,
							"_disabled"			: false, //(this.check("rename_node", data.reference, this.get_parent(data.reference), "")),
							"label"				: "修改",
							"action"			: function (data) {
								var inst = $.jstree.reference(data.reference),
									obj = inst.get_node(data.reference);
								inst.edit(obj);
							}
						},
						"remove" : {
							"separator_before"	: false,
							"icon"				: false,
							"separator_after"	: false,
							"_disabled"			: false, //(this.check("delete_node", data.reference, this.get_parent(data.reference), "")),
							"label"				: "删除",
							"action"			: function (data) {
								var inst = $.jstree.reference(data.reference),
									obj = inst.get_node(data.reference);
								if(inst.is_selected(obj)) {
									inst.delete_node(inst.get_selected());
								}
								else {
									inst.delete_node(obj);
								}
							}
						}
					};
				}
		     },
		     "types" : {
		     	"#":{
		     		"valid_children" : []
		     	},
		     	"default":{
		     		"valid_children" : ["leaf"]
		     	},
		     	"root":{
		     		"valid_children" : ["default","parent","leaf" ]
		     	},
		     	"parent" : {
			        "valid_children" : ["leaf"]
			    },
                "leaf" : {
                	"valid_children" : []
                }
             },     
		     "plugins" : [ "contextmenu","dnd","types" ]
		});
		var isAdd = false;
		tree.bind("rename_node.jstree",function(event,node,position){
			var url = "${rootUrl}vm/renameVmGroup.do";
			var data = {id:node.node.id,name:node.node.text,parentId:node.node.parent};
			if(isAdd){
				url = "${rootUrl}vm/addVmGroup.do";
				data = {name:node.node.text,parentId:node.node.parent};
			}
			$.ajax({
        		url: url,
        		type: "post",
        		data: data,
        		success: function(data){
        			if(isAdd){
        				var tree = $("#jstree").jstree(true); 
        				tree.set_id(node.node,data);
        				tree.set_type(node.node,"parent");
        			}
        			isAdd = false;
				} 
    		});
		});
		tree.bind("create_node.jstree",function(node,parent,position){
			isAdd = true;
		});
		tree.bind("delete_node.jstree",function(node,selected,event){
			 $.ajax({
        		url: "${rootUrl}vm/deleteVmGroup.do",
        		type: "post",
        		data: {id:selected.node.id},
        		success: function(){
					//window.reload();
				} 
    		});  
		});
		tree.bind("move_node.jstree",function(data,element,helper){
			var url = "${rootUrl}vm/moveVmToGroup.do",
				data = {vmId:element.node.id.split("_")[1],groupId:element.parent=="nogroup"?-1:element.parent};
			
			if(element.node.type!="leaf"){
				url = "${rootUrl}vm/renameVmGroup.do";
				data = {id:element.node.id,name:element.node.text,parentId:element.parent};
			}
			$.ajax({
        		url: url,
        		type: "post",
        		data: data,
        		success: function(){
					
				} 
    		});
		});
		tree.bind("select_node.jstree",function(node,selected,event){
			if(selected.node.type!="parent"){return;}
			$.ajax({
        		url: "${rootUrl}vm/loadVMList.do",
        		type: "post",
        		dataType:"json",
        		data: {groupId:selected.node.id},
        		success: function(data){
        			t.fnDestroy();
        			$("#vmTable").dataTable({
					    "data":data.data,
					    "columnDefs":[{
					    	"targets": [0], // 目标列位置，下标从0开始 
					    	"data": null, // 数据列名 
					    	"bSortable": false,
					    	"render": function(data, type, record,index) { 
					    		return index.row+1;
					    	}
					    }],
					    "columns": [
					    	{ "data": null },
				            { "data": "name"},
				            { "data": null},
				            { "data": "osType"},
				            { "data": null},
				            { "data": "ipAddress"},
				            { "data": "cpuNum"},
				            { "data": "cpuUsedMHZ"},
				            { "data": "memory"},
				            { "data": "memoryUsed"},
				            { "data": "capacity"},
				            { "data": null},
				            { "data": "status"}
				        ]
					});
				} 
    		});
		});
		$("#createGroup").dialog({
			autoOpen : false,
			modal : true,
			draggable:false,
			position:"center",
			resizable :true,
			title : "创建虚拟机组",
			height:400, 
			width:600, 
			buttons : [{
				html : "取消",
				"class" : "btn btn-default",
				click : function() {
					$(this).dialog("close");
				}
			}, {
				html : "保存",
				"class" : "btn btn-primary",
				click : function() {
					ajaxSubmit(document.getElementById("createGroupForm"));
				}
			}]
		});
	});
$.jstree.plugins.contextmenu = function (options, parent) {
		this.bind = function () {
			parent.bind.call(this);

			var last_ts = 0;
			this.element
				.on("contextmenu.jstree", ".jstree-anchor", $.proxy(function (e) {
						e.preventDefault();
						last_ts = e.ctrlKey ? e.timeStamp : 0;
						if(!this.is_loading(e.currentTarget)) {
							this.show_contextmenu(e.currentTarget, e.pageX, e.pageY, e);
						}
					}, this))
				.on("click.jstree", ".jstree-anchor", $.proxy(function (e) {
						if(this._data.contextmenu.visible && (!last_ts || e.timeStamp - last_ts > 250)) { // work around safari & macOS ctrl+click
							$.vakata.context.hide();
						}
					}, this));
			/*
			if(!('oncontextmenu' in document.body) && ('ontouchstart' in document.body)) {
				var el = null, tm = null;
				this.element
					.on("touchstart", ".jstree-anchor", function (e) {
						el = e.currentTarget;
						tm = +new Date();
						$(document).one("touchend", function (e) {
							e.target = document.elementFromPoint(e.originalEvent.targetTouches[0].pageX - window.pageXOffset, e.originalEvent.targetTouches[0].pageY - window.pageYOffset);
							e.currentTarget = e.target;
							tm = ((+(new Date())) - tm);
							if(e.target === el && tm > 600 && tm < 1000) {
								e.preventDefault();
								$(el).trigger('contextmenu', e);
							}
							el = null;
							tm = null;
						});
					});
			}
			*/
			$(document).on("context_hide.vakata.jstree", $.proxy(function () { this._data.contextmenu.visible = false; }, this));
		};
		this.teardown = function () {
			if(this._data.contextmenu.visible) {
				$.vakata.context.hide();
			}
			parent.teardown.call(this);
		};

		/**
		 * prepare and show the context menu for a node
		 * @name show_contextmenu(obj [, x, y])
		 * @param {mixed} obj the node
		 * @param {Number} x the x-coordinate relative to the document to show the menu at
		 * @param {Number} y the y-coordinate relative to the document to show the menu at
		 * @param {Object} e the event if available that triggered the contextmenu
		 * @plugin contextmenu
		 * @trigger show_contextmenu.jstree
		 */
		this.show_contextmenu = function (obj, x, y, e) {
			obj = this.get_node(obj);
			if(!obj || obj.id === '#') { return false; }
			var s = this.settings.contextmenu,
				d = this.get_node(obj, true),
				a = d.children(".jstree-anchor"),
				o = false,
				i = false;
			if(s.show_at_node || x === undefined || y === undefined) {
				o = a.offset();
				x = o.left;
				y = o.top + this._data.core.li_height;
			}
			if(this.settings.contextmenu.select_node && !this.is_selected(obj)) {
				this.activate_node(obj, e);
			}

			i = s.items;
			if($.isFunction(i)) {
				i = i.call(this, obj, $.proxy(function (i) {
					this._show_contextmenu(obj, x, y, i);
				}, this));
			}
			if($.isPlainObject(i)) {
				this._show_contextmenu(obj, x, y, i);
			}
		};
		/**
		 * show the prepared context menu for a node
		 * @name _show_contextmenu(obj, x, y, i)
		 * @param {mixed} obj the node
		 * @param {Number} x the x-coordinate relative to the document to show the menu at
		 * @param {Number} y the y-coordinate relative to the document to show the menu at
		 * @param {Number} i the object of items to show
		 * @plugin contextmenu
		 * @trigger show_contextmenu.jstree
		 * @private
		 */
		this._show_contextmenu = function (obj, x, y, i) {
			if(obj.type=="leaf"){
				return false;
			}
			if(obj.type=="parent"){
				i.create=null;
			}
			var d = this.get_node(obj, true),
				a = d.children(".jstree-anchor");
			$(document).one("context_show.vakata.jstree", $.proxy(function (e, data) {
				var cls = 'jstree-contextmenu jstree-' + this.get_theme() + '-contextmenu';
				$(data.element).addClass(cls);
			}, this));
			this._data.contextmenu.visible = true;
			$.vakata.context.show(a, { 'x' : x, 'y' : y }, i);
			/**
			 * triggered when the contextmenu is shown for a node
			 * @event
			 * @name show_contextmenu.jstree
			 * @param {Object} node the node
			 * @param {Number} x the x-coordinate of the menu relative to the document
			 * @param {Number} y the y-coordinate of the menu relative to the document
			 * @plugin contextmenu
			 */
			this.trigger('show_contextmenu', { "node" : obj, "x" : x, "y" : y });
		};
	};
</script>
<html lang="en-us">
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
						虚拟机管理
					</li>
					<li>
						虚拟机
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
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
			
						<!-- Widget ID (each widget will need unique ID)-->
						<div class="jarviswidget jarviswidget-color-blueDark" data-widget-editbutton="false">
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
								<span class="widget-icon"> <i class="fa fa-lg fa-calendar"></i> </span>
								<h2>Organizing view </h2>
			
							</header>
			
							<!-- widget div-->
							<div>
			
								<!-- widget edit box -->
								<div class="jarviswidget-editbox">
									
								</div>
								<!-- end widget edit box -->
								<!-- widget content -->
								<div class="widget-body no-padding">
									<div class="collapse navbar-collapse bg-color-grey">
										<form class="navbar-form navbar-left">
											<button class="btn" type="button" onclick="create()">
												新建
											</button>
										</form>
									</div>
									<div id="jstree"></div>
									
								</div>
								<!-- end widget content -->
							</div>
							<!-- end widget div -->
			
						</div>
						<!-- end widget -->
			
					</article>
					<!-- WIDGET END -->
					
					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-9">
						
						<!-- 虚拟机 -->
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
							<header> <span>&nbsp;&nbsp;
								<ul class="nav nav-tabs pull-left in">

									<li class="active">
			
										<a data-toggle="tab" href="#hb1"> <i class="fa fa-lg fa-arrow-circle-o-down"></i> <span class="hidden-mobile hidden-tablet">基本信息</span> </a>
			
									</li>
			
									<li>
										<a data-toggle="tab" href="#hb2"> <i class="fa fa-lg fa-arrow-circle-o-up"></i> <span class="hidden-mobile hidden-tablet">虚拟机</span> </a>
									</li>
			
								</ul>
							</span> </header>
	
							<!-- widget div-->
							<div>
	
								<!-- widget edit box -->
								<div class="jarviswidget-editbox">
									<!-- This area used as dropdown edit box -->
								</div>
								<!-- end widget edit box -->
	
								<!-- widget content -->
								<div class="widget-body no-padding">
									<div class="tab-content">
										<div class="tab-pane active" id="hb1">
											
										</div>
										<div class="tab-pane" id="hb2">
											<div class="row">
											
												<!-- NEW WIDGET START -->
												<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
												<!-- Widget ID (each widget will need unique ID)-->
												<div id="myVmTable" class="jarviswidget jarviswidget-color-blueDark" data-widget-editbutton="false" data-widget-deletebutton="false">
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
								
													<!-- widget div-->
													<div>
								
														<!-- widget edit box -->
														<div class="jarviswidget-editbox">
															<!-- This area used as dropdown edit box -->
							
														</div>
														<!-- end widget edit box -->
								
														<!-- widget content -->
														<div class="widget-body no-padding">
															<table id="vmTable"
																class="table table-striped table-bordered table-hover">
																<thead>
																	<tr>
																		<th data-hide="phone">
																			序号
																		</th>
																		<th data-hide="phone">
																			名称
																		</th>
																		<th data-hide="phone">
																			承载业务
																		</th>
																		<th data-hide="phone">
																			操作系统
																		</th>
																		<th data-hide="phone">
																			主机
																		</th>
																		<th data-hide="phone">
																			IP地址
																		</th>
																		<th data-hide="phone">
																			CPU
																		</th>
																		<th data-hide="phone">
																			CPU使用
																		</th>
																		<th data-hide="phone">
																			置备内存(MB)
																		</th>
																		<th data-hide="phone">
																			内存使用
																		</th>
																		<th data-hide="phone">
																			已用存储空间(GB)/置备存储空间(GB)
																		</th>
																		<th data-hide="phone">
																			费用
																		</th>
																		<th data-hide="phone">
																			状态
																		</th>
																	</tr>
																</thead>
															</table>
														</div>
														<!-- end widget content -->
													</div>
													<!-- end widget div -->
												</div>
												<!-- end widget --> </article>
												<!-- WIDGET END -->
											</div>
											
										</div>
									</div>
									
								</div>
								<!-- end widget content -->
	
							</div>
							<!-- end widget div -->
	
						</div>
						<!-- 虚拟机 -->
						
					</article>
					<!-- WIDGET END -->
		
				</div>

				<!-- end row --> <!-- end row --> </section>
				
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN PANEL -->
	</body>
	<!-- 弹出窗口 -->
	<div id="createGroup" style="display:none;margin:0;">
		<form class="form-horizontal" action="${rootUrl }vm/addVmGroup.do" id="createGroupForm" method="post">
			<fieldset>
				<input type="hidden" id="parentId" name="parentId">
				<div class="form-group">
					<label class="col-md-2 control-label">名称</label>
					<div class="col-md-9">
						<input class="form-control" type="text" name="name" id="name">
					</div>
				</div>	
				<div class="form-group">
					<label class="col-md-2 control-label">部门</label>
					<div class="col-md-9">
						<input class="form-control" type="text" name="unitId" id="unitId">
					</div>
				</div>	
				<div class="form-group">
					<label class="col-md-2 control-label">资源池</label>
					<div class="col-md-9">
						<input class="form-control" type="text" name="resPoolId" id="resPoolId">
					</div>
				</div>	
				<div class="form-group">
					<label class="col-md-2 control-label">CPU配额</label>
					<section class="col-md-4 ">
						<label class="input">
							<select class="form-control" name="cpuSize" id="cpuSize" >
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="4">4</option>
							</select>
						</label>
					</section>
					<label class="col-md-2 control-label">内存配额</label>
					<section class="col-md-4 ">
						<label class="input">
							<select class="form-control" name="memory" id="memory" >
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="4">4</option>
							</select>
						</label>
					</section>				
				</div>				
				<div class="form-group">
					<label class="col-md-2 control-label">备注</label>
					<div class="col-md-9">
						<textarea class="form-control" type="text" name="remark" id="remark" rows="3" ></textarea>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
	
		<!-- 弹出窗口 -->
</html>
