drawSds = function(base){
	var sdsJson = {
		Host : [
			{name:'cendb1',id:'cendb001',image:''},
			{name:'cendb2',id:'cendb002',image:''}
		],
		Switch : [
			{name:'IBM_M48_1',id:'ibmm48001',image:''},
			{name:'IBM_M48_2',id:'ibmm48002',image:''}
		],
		subsystem : [		
			{name:'Storage',id:'storage001',image:''}
		],
		edge : [
			{id : '',name:'',sourceId:'cendb001',targetId:'ibmm48001'},
			{id : '',name:'',sourceId:'cendb001',targetId:'ibmm48002'},
			{id : '',name:'',sourceId:'cendb002',targetId:'ibmm48001'},
			{id : '',name:'',sourceId:'cendb002',targetId:'ibmm48002'},
			{id : '',name:'',sourceId:'ibmm48001',targetId:'storage001'},
			{id : '',name:'',sourceId:'ibmm48002',targetId:'storage001'}
		]
	};
	var graph = new Q.Graph("canvas");
	graph.enableTooltip = true;
	
	
	
	translateToQuneeElements(sdsJson);
				
	function translateToQuneeElements(json){
		if(json.Host){
			Q.forEach(json.Host, toQuneeHost);
		}
		if(json.Switch){
			Q.forEach(json.Switch, toQuneeSwitch);
		}
		if(json.subsystem){
			Q.forEach(json.subsystem, toQuneeSubsysterm);
		}
		
		if(json.edge){
			Q.forEach(json.edge, toQuneeEdge);
		}
		
		graph.moveToCenter();
	}
	function toQuneeHost(data){					
		var node = graph.createNode(data.name);
		node.image = Q.Graphs.server;
		if(data.image && $.trim(data.image)!=''){
			node.image = data.image;
		}
		node.set('id', data.id);
		node.set('type', 'host');		
		node.size = {
			width : 30
		};	
		if(data.tooltip){
			node.tooltip = data.tooltip;
		}							
		return node;
	}
	function toQuneeSwitch(data){
		var node = graph.createNode(data.name);
		node.image = Q.Graphs.exchanger;
		if(data.image && $.trim(data.image)!=''){
			node.image = data.image;
		}
		node.set('id', data.id);
		node.set('type', 'switch');		
		node.size = {
			width : 40
		};
		if(data.tooltip){
			node.tooltip = data.tooltip;
		}	
		return node;
	}
	
	function toQuneeSubsysterm(data){
		var node = graph.createNode(data.name);
		node.image = base + 'img/qunee/ds8000.jpg';	
		//alert(base + 'img/qunee/ds8000.jpg')
		if(data.image && $.trim(data.image)!=''){
			node.image = data.image;
		}					
		node.set('id', data.id);
		node.set('type', 'subsysterm');		
		node.size = {
			width : 30
		};
		if(data.tooltip){
			node.tooltip = data.tooltip;
		}					
		return node;
	}
	
	
	function toQuneeEdge(data){
	
		var from = getElementById(data.sourceId);
		var to = getElementById(data.targetId);
		var edge = graph.createEdge(data.value, from, to);
		edge.set('type', 'edge');	
		edge.setStyle(Q.Styles.ARROW_TO, false);
		
		return edge;
	}
	
	function getElementById(id){
		var element = undefined;
		graph.forEach(function(elem,index){
			if(elem && elem.get('id')==id){
				element = elem;
				return false;
			}
		},graph);
		return element;
	}
	
	//graph.zoomToOverview();
		//自动布局算法，layer是图元所在层
		graph.graphModel.forEachByTopoBreadthFirstSearch(function(v, from, layer, index, sum){
			if(v._layer === undefined || layer > v._layer){
				v._layer = layer;
				return;
			}
		});

		var layers = {};
		graph.forEach(function(element){
			if(element._layer !== undefined){
				var nodes = layers[element._layer];
				if(!nodes){
					nodes = layers[element._layer] = [];
				}
				nodes.push(element);
			}
		})

		var xGap = 240, yGap = 140;
		var layer = 0;
		while(true){
			var nodes = layers[layer];
			if(!nodes){
				break;
			}
			var width = (nodes.length - 1) * xGap;
			var x = -width / 2;
			var y = layer * yGap;
			nodes.forEach(function(node, i){
				node.setLocation(x + i * xGap, y);
			})
			layer++;
		}
		//END自动布局算法
		
		var defaultStyles = {};
		defaultStyles[Q.Styles.SELECTION_SHADOW_BLUR] = 6;
		defaultStyles[Q.Styles.EDGE_WIDTH] = 0.8;
		defaultStyles[Q.Styles.LABEL_FONT_SIZE] = 9;
		defaultStyles[Q.Styles.LABEL_PADDING] = new Q.Insets(1, 2);
		defaultStyles[Q.Styles.LABEL_BACKGROUND_COLOR] = Q.toColor(0xDDFFFFFF);
		defaultStyles[Q.Styles.LABEL_POINTER_WIDTH] = 4;
		defaultStyles[Q.Styles.LABEL_RADIUS] = 4;
		defaultStyles[Q.Styles.LABEL_OFFSET_X] = 0;
		defaultStyles[Q.Styles.LABEL_OFFSET_Y] = 6;
		defaultStyles[Q.Styles.LABEL_BORDER] = 0.5;
		defaultStyles[Q.Styles.EDGE_CORNER_RADIUS] = 6;
		graph.styles = defaultStyles;
		graph.scale = 1.2;
	
}
