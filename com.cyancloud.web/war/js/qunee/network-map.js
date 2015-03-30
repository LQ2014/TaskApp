NetWorkMap = function(base){		
	var graph = new Q.MapChart(canvas);
	graph.originAtCenter = false;
	var strokeColor = "#888";
	graph.minScale = 0.5;
	graph.maxScale = 4;
	var url = base + "js/qunee/china-zh.json";	
	var colors = ["#D5E7C4", "#CDE6FF", "#EFDEE6", "#FFF8CC"];
	var index = 0;
	graph.loadJSONByURL(url, function(element, type, info){
		Q.log(info)
	    element.info = info;
	    element.movable = false;
	    element.type = type;
	    element.outputProperties = "type,info".split(",");
	    if(type == "path"){
	        element.setStyle(Q.Styles.SHAPE_FILL_COLOR, colors[index++ % colors.length]);
//	        element.setStyle(Q.Styles.SHAPE_FILL_GRADIENT, Q.Gradient.LINEAR_GRADIENT_VERTICAL);
	        element.setStyle(Q.Styles.SHAPE_STROKE_STYLE, strokeColor);
	        element.setStyle(Q.Styles.SHAPE_STROKE, 0.5);
	        element.setStyle(Q.Styles.LABEL_ANCHOR_POSITION, Q.Position.CENTER_MIDDLE);
	        element.setStyle(Q.Styles.LABEL_POSITION, Q.Position.CENTER_MIDDLE);
	        element.zIndex = -1;
	        return;
	    }
	    if(type == "point"){
	        element.setStyle(Q.Styles.SHAPE_FILL_COLOR, "#DDD");
	        element.setStyle(Q.Styles.SHAPE_STROKE_STYLE, "#EE0000");
	        element.zIndex = 10;
	        return;
	    }
	    if(type == "label"){
	        if(info.class == 'tc'){
	            element.visible = false;
	        }
	        element.setStyle(Q.Styles.LABEL_COLOR, "#AAA");
	    }
	}, function(){	
		var beijing = graph.createNode("北京", 455, 198.6);
	    beijing.image = Q.Graphs.server;
	    beijing.size={width:20}
	    beijing.set('type','server');
	    var shanghai = graph.createNode("上海", 525, 315);
	    shanghai.image = Q.Graphs.server;
	    shanghai.size={width:20}
	    shanghai.set('type','server');
	    var changsha = graph.createNode("长沙", 421, 366);
	    changsha.image = Q.Graphs.server;
	    changsha.size={width:20}
	    changsha.set('type','server');
	    var edge = graph.createEdge(beijing, shanghai);
	    var edge = graph.createEdge("北京 > 上海", beijing, shanghai);
	    edge.setStyle(Q.Styles.EDGE_COLOR, "#2898E0");
	    edge.setStyle(Q.Styles.LABEL_BACKGROUND_COLOR, "rgba(255,255,255,0.7)");
	    edge = graph.createEdge("上海 > 长沙", shanghai, changsha);
	    edge.setStyle(Q.Styles.EDGE_COLOR, "#2898E0");
	    edge.setStyle(Q.Styles.LABEL_BACKGROUND_COLOR, "rgba(255,255,255,0.7)");
		graph.addCustomInteraction({
			ondblclick: function(evt, graph){
				var element = graph.getElementByMouseEvent(evt);
				if(element && element.get('type')=='server'){
					window.location = base + 'network/secondNetwork.do';
				}				
			}
		});
			
		graph.zoomToOverview();
	
	});	
};
