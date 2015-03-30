netSilverMonitoring = function(base){	
	var graph = new Q.Graph("canvas");
	graph.originAtCenter = false;
	graph.editable  = false;
	graph.enableDoubleClickToOverview  = false;
	graph.enableWheelZoom  = false;
	graph.scale = '0.9';
	graph.enableTooltip = true;
	
	function createServer(name,x,y,image){
		var server =  graph.createNode(name || '',x || 0,y || 0);
		server.image = image || base+'img/qunee/server-001.png';
		server.size ={width:35};
		server.movable = false;
		return server;
	}
	var beginX = 80;
	var beginY = 100;
	var web1 = createServer('分行ABS服务器',beginX+93,beginY);	
	web1.tooltip = '主机名称：分行ABS服务器<br/>IP地址：192.168.18.102<br/>cpu使用率：4%<br/>内存利用率：74.2%';
	var group1 = createGroup('#F6FDE5','#DCDFBE');
	group1.setStyle(Q.Styles.GROUP_BACKGROUND_COLOR, '#FFC41E');
	group1.setStyle(Q.Styles.GROUP_STROKE,null);
	group1.padding = new Q.Insets(5, 50, 5, 50);
	group1.addChild(web1);	
	
	var web2 = createServer('分行票据影像服务器',beginX+510,beginY);	
	web2.tooltip = '主机名称：分行票据影像服务器<br/>IP地址：202.17.18.144<br/>cpu使用率：17.2%<br/>内存利用率：64.2%';
	var group2 = createGroup('#F6FDE5','#DCDFBE');
	group2.setStyle(Q.Styles.GROUP_BACKGROUND_COLOR, '#91CEEE');
	group2.setStyle(Q.Styles.GROUP_STROKE,null);
	group2.padding = new Q.Insets(5, 50, 5, 50);
	group2.addChild(web2);
	

	
	function createAppServer(name,x,y,image){
		var node = graph.createNode(name || '', x || 0,y || 0);
		node.image = image || base + 'img/qunee/app-server.png';
		node.size={width:35}
		return node;
	}
	
	
	function createGroup(color1,color2){
		var group = graph.createGroup();
		var gradient = new Q.Gradient(Q.Consts.GRADIENT_TYPE_LINEAR, [color1||'#FFF', color2||'#FFF'], null, Math.PI/2);	
		group.setStyle(Q.Styles.GROUP_BACKGROUND_GRADIENT, gradient);
		group.setStyle(Q.Styles.GROUP_STROKE, 2);
		group.setStyle(Q.Styles.GROUP_STROKE_STYLE, "#6EA6A0");
		return group;
	}
	var server1 = createAppServer('应用服务器A',beginX+51,beginY+160);
	server1.tooltip = '主机名称：应用服务器A<br/>IP地址：2.1.16.104<br/>cpu使用率：6.5%<br/>内存利用率：33.7%';
	var server2 = createAppServer('应用服务器B',beginX+51+80,beginY+160);
	server2.tooltip = '主机名称：应用服务器B<br/>IP地址：2.1.16.130<br/>cpu使用率：14.8%<br/>内存利用率：23.4%';
	
	var group20 = createGroup('#FBE5A9','#F78E00');	
	group20.addChild(server1);
	group20.addChild(server2);
	
	var server3 = createAppServer('内容管理服务器A',beginX+51+80+320,beginY+160);
	var server4 = createAppServer('内容管理服务器B',beginX+51+80+320+120,beginY+160);
	server3.tooltip = '主机名称：内容管理服务器A<br/>IP地址：102.11.10.24<br/>cpu使用率：6.6%<br/>内存利用率：45.7%';
	server4.tooltip = '主机名称：内容管理服务器B<br/>IP地址：102.11.10.20<br/>cpu使用率：23.8%<br/>内存利用率：81.2%';
	
	var group21 = createGroup('#5AAB26','#5AAB26');	
	group21.addChild(server3);
	group21.addChild(server4);
	
	var server5 = createAppServer('内容管理服务器A',beginX+51+80+120,beginY+160+160);
	var server6 = createAppServer('内容管理服务器B',beginX+51+80+120+220,beginY+160+160);
	server5.tooltip = '主机名称：内容管理服务器A<br/>IP地址：142.11.10.24<br/>cpu使用率：6.8%<br/>内存利用率：78.4%';
	server6.tooltip = '主机名称：内容管理服务器B<br/>IP地址：142.11.10.20<br/>cpu使用率：17.6%<br/>内存利用率：63.2%';
	
	var group22 = createGroup('#0B689C','#ABE1E7');	
	group22.addChild(server5);
	var group23 = createGroup('#91DC49','#5DBF2C');	
	group23.addChild(server6);
	
	var server7 = createServer('交换中心',beginX+100,beginY+160+160+160);
	var server8 = createServer('密管平台',beginX+100+240,beginY+160+160+160);
	var server9 = createServer('财务主机AS400',beginX+100+240+240,beginY+160+160+160);
	
	server7.tooltip = '主机名称：交换中心<br/>IP地址：188.14.1.119<br/>cpu使用率：14.8%<br/>内存利用率：73.8%';
	server8.tooltip = '主机名称：密管平台<br/>IP地址：188.14.1.123<br/>cpu使用率：24.1%<br/>内存利用率：54.1%';
	server9.tooltip = '主机名称：财务主机AS400<br/>IP地址：188.14.1.224<br/>cpu使用率：18.9%<br/>内存利用率：64.3%';
	var group30 = createGroup('#EFF5E5','#DADEBA');	
	group30.addChild(server7);
	group30.addChild(server8);
	group30.addChild(server9);	
	
	
	
	var edge1 = graph.createEdge('',group1,group20);
	edge1.setStyle(Q.Styles.ARROW_TO,null);
	
	var edge2 = graph.createEdge('',group2,group21);
	edge2.setStyle(Q.Styles.ARROW_TO,null);
	
	var edge3 = graph.createEdge('',group20,group21);
	edge3.setStyle(Q.Styles.ARROW_TO,null);
	
	var edge4 = graph.createEdge('',group20,group22);
	edge4.setStyle(Q.Styles.ARROW_TO,null);
	edge4.addPathSegement([beginX+51+43,beginY+160+80+20]);
	edge4.addPathSegement([beginX+51+80+120,beginY+160+80+20]);
	
	var edge5 = graph.createEdge('',group20,group23);
	edge5.setStyle(Q.Styles.ARROW_TO,null);
	edge5.addPathSegement([beginX+51+43,beginY+160+80]);
	edge5.addPathSegement([beginX+51+80+120+220,beginY+160+80]);
	
	var edge6 = graph.createEdge('',group20,group30);
	edge6.setStyle(Q.Styles.ARROW_TO,null);
	edge6.addPathSegement([beginX+96, beginY+160+160+90]);
	edge6.addPathSegement([beginX+100+240+10, beginY+160+160+90]);
	edge6.setStyle(Q.Styles.EDGE_COLOR, '#F00');
	
	var flowingSupport = new FlowingSupport(graph,base);
	flowingSupport.addFlowing(edge1, 1);
	flowingSupport.addFlowing(edge2, 1);
	flowingSupport.addFlowing(edge3, 1);
	flowingSupport.addFlowing(edge4, 1);
	flowingSupport.addFlowing(edge5, 1);
	graph.callLater(function(){
	    flowingSupport.start();
	})
	function destroy(){
	    flowingSupport.stop();
	}
	/*右键菜单*/
	var menu = new PopupMenu();
	menu.getMenuItems = function(graph, data, evt){
		var items = [];  						
		if (data) {	
			items.push({
				text: '查看性能信息', action: function (evt, item) {
					$("#dialog-confirm").dialog("open");
				}
			});			
			
			items.push({
				text: '查看事件信息', action: function (evt, item) {
					$("#dialog-confirm").dialog("open");
				}
			});
			items.push({
				text: '查看配置信息', action: function (evt, item) {
					$("#dialog-confirm").dialog("open");
				}
			});
			items.push(PopupMenu.Separator);			
		}
		items.push({
			text: '刷新页面', action: function (evt, item) {
				window.reload(true);
			}
		});
		return items;
	}
	menu.initPopMenu(graph);
	
	 $("#dialog-confirm").dialog(
	     {
	    	 modal: true,   
	    	 autoOpen: false
	     }
	 );
	 var items = [server1,server7];
	 var blinking1 = new Blinking({
		items : items,
		color : '#F00',
		time : 1000
	});
	
	blinking1.startBlinking();
	
};
