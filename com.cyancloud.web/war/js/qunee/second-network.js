secondNetwork = function(base){		
	var graph = new Q.Graph(canvas);	
	graph.moveToCenter(0.5);
	graph.styles = {};
	graph.styles[Q.Styles.LABEL_FONT_SIZE] = 18;

	function createNode(image, x, y, name, group){
	    var node = graph.createNode(name, x, y);
	    if(image){
	        if(Q.isString(image)){
	            image = base + "img/qunee/" + image;
	        }
	        node.image = image;
	    }
	    if(group){
	        group.addChild(node);
	    }
	    return node;
	}

	function createText(name, x, y, fontSize, color, parent){
	    var text = graph.createText(name, x, y);
	    text.setStyle(Q.Styles.LABEL_ANCHOR_POSITION, Q.Position.CENTER_MIDDLE);
	    text.setStyle(Q.Styles.LABEL_POSITION, Q.Position.CENTER_MIDDLE);
	    text.setStyle(Q.Styles.LABEL_FONT_SIZE, fontSize);
	    text.setStyle(Q.Styles.LABEL_COLOR, color);
	    text.setStyle(Q.Styles.LABEL_BACKGROUND_COLOR, null);
	    if(parent){
	        parent.addChild(text);
	    }
	    return text;
	}

	function createGroup(padding){
	    var group = graph.createGroup();
	    group.groupImage = Q.Graphs.cloud;
	    group.padding = padding || 30;
	    return group;
	}

	function createEdge(a, b, color, dashed, name){
	    var edge = graph.createEdge(name, a, b);
	    if(dashed){
	        edge.setStyle(Q.Styles.EDGE_LINE_DASH, [8, 5]);
	    }
	    edge.setStyle(Q.Styles.EDGE_WIDTH, 3);
	    edge.setStyle(Q.Styles.EDGE_COLOR, color);
	    edge.setStyle(Q.Styles.ARROW_TO, false);
	    return edge;
	}

	var VPNFlexEdgeUI = function(edge, graph){
	    Q.doSuperConstructor(this, VPNFlexEdgeUI, arguments);
	}
	VPNFlexEdgeUI.prototype = {
	    drawEdge: function(path, fromUI, toUI, edgeType, fromBounds, toBounds){
	        var from = fromBounds.center;
	        path.curveTo(from.x, from.y, internet.x, internet.y);
	    }
	}

	Q.extend(VPNFlexEdgeUI, Q.EdgeUI);

	//createText("公共事业服务\n中心网络拓扑图", 859, 100, 40, "#F00");	
	
	var group = createGroup(50);
	var a = createNode("server.png", 388, 219, "存储", group);
	a.tooltip ='阵列名称：BYVNX53_FCN00140300032<br/>厂商：EMC<br/>型号：Rack Mounted VNX5300<br/>IP地址：10.96.23.230,10.96.23.231<br/>';
	var b = createNode("exchange2.png", 313, 289, "光纤交换机", group);
	b.tooltip = '交换机名称:IBM_2498_B80_27<br/>IP地址:10.96.2.27<br/>型号:Brocade 5300<br/>端口数量:80<br/>';
	var edge1 = createEdge(a, b, "#F00");
	var c = createNode("server.png", 153, 355, null, group);
	c.tooltip = '主机名称:PEKAX573<br/>IP地址:10.96.14.73<br/>OS类型:AIX<br/>厂商:IBM<br/>';
	var edge2 = createEdge(b, c, "#F00", true);
	c = createNode("server.png", 193, 371, null, group);
	c.tooltip = '主机名称:PEKAX509<br/>IP地址:10.96.36.30<br/>OS类型:AIX<br/>厂商:IBM<br/>';
	var edge3 = createEdge(b, c, "#F00", true);
	var c1 = c = createNode("server.png", 231, 387, null, group);
	c.tooltip = '主机名称:PEKAX508<br/>IP地址:10.96.14.61<br/>OS类型:AIX<br/>厂商:IBM<br/>';
	var edge4 = createEdge(b, c, "#F00", true);
	c = createNode("server.png", 271, 405, null, group);
	c.tooltip = '主机名称:PEKAX562<br/>IP地址:10.96.14.62<br/>OS类型:AIX<br/>厂商:IBM<br/>';
	var edge5 = createEdge(b, c, "#F00", true);

	var d = createNode("exchange.png", 367, 415, "交换机", group);
	d.tooltip = '交换机名称:T2_BL_73<br/>IP地址:10.96.34.130<br/>型号:Brocade 5300<br/>端口数量:160<br/>';
	
	var edge6 = createEdge(c, d, "#45E");
	var e = createNode("firewall.png", 487, 413, "IPS", group);
	
	var edge7 = createEdge(d, e, "#45E");
	var f = createNode("exchange2.png", 615, 445, "核心交换机", group);
	var edge8 = createEdge(e, f, "#45E");
	var g = createNode("firewall.png", 761, 443, "防火墙", group);
	var edge9 = createEdge(f, g, "#45E");
	var h = createNode("router.png", 903, 437, "路由器", group);
	var edge10 = createEdge(g, h, "#45E");
	var i = createNode("pc.png", 351, 511, "内网PC", group);
	var i2 = createNode("pc.png", 351, 611, "内网PC", group);
	var j = createNode("exchange.png", 499, 517, null, group);
	var j2 = createNode("exchange.png", 499, 607, null, group);
	var k = createNode("exchange2.png", 613, 583, null, group);
	var l = createNode("firewall.png", 759, 567, null, group);
	var m = createNode("router.png", 905, 567, null, group);

	//createText("公共事业服务中心\n中心局域网", 609, 271, 30, "#F00", group);

	var edge11 = createEdge(i, j, "#45E");
	var edge12 = createEdge(i, j, "#45E");
	var edge13 = createEdge(i, j, "#45E");
	var edge14 = createEdge(i2, j2, "#45E");
	var edge15 = createEdge(i2, j2, "#45E");
	var edge16 = createEdge(i2, j2, "#45E");

	var edge17 = createEdge(e, k, "#45E", true);
	var edge18 = createEdge(j, f, "#45E");
	var edge19 = createEdge(j, k, "#45E", true);
	var edge20 = createEdge(j2, f, "#45E");
	var edge21 = createEdge(j2, k, "#45E", true);

	var edge22 = createEdge(f, k, "#45E");
	var edge23 = createEdge(k, f, "#45E");
	var edge24 = createEdge(k, l, "#45E");
	var edge25 = createEdge(l, m, "#45E");
	var edge26 = createEdge(f, l, "#45E", true);
	var edge27 = createEdge(k, g, "#45E", true);
	var edge28 = createEdge(g, m, "#45E", true);
	var edge29 = createEdge(l, h, "#45E", true);

	var internet = createNode(Q.Graphs.cloud, 1155, 495, "Internet");
	internet.setStyle(Q.Styles.LABEL_ANCHOR_POSITION, Q.Position.CENTER_MIDDLE);
	internet.setStyle(Q.Styles.LABEL_POSITION, Q.Position.CENTER_MIDDLE);
	internet.setStyle(Q.Styles.LABEL_FONT_SIZE, 24);
	internet.setStyle(Q.Styles.LABEL_FONT_STYLE, "bold");
	internet.size = {width: 200};

	var edge30 = createEdge(h, internet);edge30.edgeType = Q.Consts.EDGE_TYPE_ZIGZAG;
	
	var edge31 = createEdge(m, internet);edge31.edgeType = Q.Consts.EDGE_TYPE_ZIGZAG;

	var flowingSupport = new FlowingSupport(graph,base);
	
	var n = createSubGroup(1139, 0, '#52ADE6');
	var o = createSubGroup(1339, 199);
	var p = createSubGroup(1450, 421);
	var q = createSubGroup(1300, 600);
	var r = createSubGroup(1080, 771);

	var edge32 = createEdge(internet, n);edge32.edgeType = Q.Consts.EDGE_TYPE_ZIGZAG;
	var edge33 = createEdge(internet, o);edge33.edgeType = Q.Consts.EDGE_TYPE_ZIGZAG;
	var edge34 = createEdge(internet, p);edge34.edgeType = Q.Consts.EDGE_TYPE_ZIGZAG;
	var edge35 = createEdge(internet, q);edge35.edgeType = Q.Consts.EDGE_TYPE_ZIGZAG;
	var edge36 = createEdge(internet, r);edge36.edgeType = Q.Consts.EDGE_TYPE_ZIGZAG;

	var edge37 = createEdge(h, n, "#F80", true, "VPN");edge37.uiClass = VPNFlexEdgeUI;
	var edge38 = createEdge(h, o, "#F80", true);edge38.uiClass = VPNFlexEdgeUI;
	var edge39 = createEdge(h, p, "#F80", true);edge39.uiClass = VPNFlexEdgeUI;
	var edge40 = createEdge(m, q, "#F80", true);edge40.uiClass = VPNFlexEdgeUI;
	var edge41 = createEdge(m, r, "#F80", true);edge41.uiClass = VPNFlexEdgeUI;

	
	
	function createSubGroup(x, y, renderColor){
	    var group = createGroup();
	    group.name = "分支机构";
	    if(renderColor){
	        group.setStyle(Q.Styles.RENDER_COLOR, renderColor);
	    }
	    var a = createNode("router.png", 49 + x, 100 + y, "路由器", group);
	    var b = createNode("exchange.png", 191 + x, 100 + y, "交换机", group);
	    createNode("pc.png", 313 + x, 100 + y, "内网PC", group);
	    flowingSupport.addFlowing(createEdge(a, b, "#45E"),1);
	    return a;
	}
	
	function addUI(obj,text){
		var alarmUI = new Q.LabelUI(text||'');
		alarmUI.position = Q.Position.CENTER_TOP;
		alarmUI.anchorPosition = Q.Position.LEFT_BOTTOM;
		alarmUI.border = 1;
		alarmUI.backgroundGradient = Q.Gradient.LINEAR_GRADIENT_VERTICAL;
		alarmUI.padding = new Q.Insets(2, 5);
		alarmUI.showPointer = true;
		alarmUI.offsetY = -10;
		alarmUI.offsetX = -10;
		alarmUI.rotatable = false;
		obj.addUI(alarmUI);
		return alarmUI;
	}
		
	for(var n=1;n<32;n++){
		if(n==4){
			continue;
		}
		flowingSupport.addFlowing(eval('edge'+n), 1);
	}
	
	for(var n=32;n<37;n++){
		flowingSupport.addFlowing(eval('edge'+n), 1);
	}
	
	
	graph.callLater(function(){
	    flowingSupport.start();
	})
	function destroy(){
	    flowingSupport.stop();
	}
	c1.alarmLabel = ' ！ ';
	 /*告警开始*/
	 var alarm = new Alarm({
		 time : 1000,
		 items : [c1],
		 color : '#F00'
	 }).start();
	
		/*右键菜单*/
		var menu = new PopupMenu();
		menu.getMenuItems = function(graph, data, evt){
			var items = [];  						
			items.push({
				text: '返回', action: function (evt, item) {
					window.location = base + 'network/index.do';
				}
			});
			//items.push(PopupMenu.Separator);	
			items.push({
				text: '刷新页面', action: function (evt, item) {
					window.reload(true)
				}
			});
			return items;
		}
		menu.initPopMenu(graph);
	
};
