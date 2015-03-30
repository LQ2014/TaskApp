drawFabricSwitch = function(base){
	var fabricJson = {
		Host : [
			{name:'TELEBIZDB2',id:'cendb001',image:'',points:[{id:'portcendb001',name:''}]},
			{name:'LNVESW08',id:'cendb002',image:'',points:[{id:'portcendb002',name:''}]},
			{name:'TELEBIZDB1',id:'cendb001',image:'',points:[{id:'portcendb003',name:''}]},
			{name:'DR_MASTER1',id:'cendb001',image:'',points:[{id:'portcendb004',name:''}]},
			{name:'LNVMBL08',id:'cendb001',image:'',points:[{id:'portcendb005',name:''}]}
		],
		Switch : [
			{name:'IBM_M48_1',id:'ibmm48001',image:'',
				points:[
				        {id:'portibmm48001',name:''}
				]}
		],
		subsystem : [		
			{name:'Storage',id:'storage001',image:'',
				points:[
			            {id:'portstorage001',name:'1',color:'#FFF'},{id:'portstorage002',name:'2',color:'#FFF'},{id:'portstorage003',name:'3',color:'#FFF'},
			            {id:'portstorage004',name:'4',color:'#FFF'},{id:'portstorage005',name:'5',color:'#FFF'},{id:'portstorage006',name:'6',color:'#FFF'},
			            {id:'portstorage007',name:'7',color:'#FFF'},{id:'portstorage008',name:'8',color:'#FFF'},{id:'portstorage009',name:'9',color:'#FFF'},
			            {id:'portstorage0010',name:'10',color:'#FFF'},
			            {id:'portstorage0011',name:'11',color:'#FFF'},{id:'portstorage0012',name:'12',color:'#FFF'},{id:'portstorage0013',name:'13',color:'#FFF'},
			            {id:'portstorage0014',name:'14',color:'#FFF'},{id:'portstorage0015',name:'15',color:'#FFF'},{id:'portstorage0016',name:'16',color:'#FFF'}
			            ]},
			{name:'Storage',id:'storage001',image:'',points:[{id:'portstorage101',name:'1',color:'#FFF'},{id:'portstorage102',name:'2',color:'#FFF'},{id:'portstorage103',name:'3',color:'#FFF'}]},
			{name:'Storage',id:'storage001',image:'',points:[{id:'portstorage201',name:'1',color:'#FFF'},{id:'portstorage202',name:'2',color:'#FFF'}]}
		],
		edge : [
			{id : '',name:'',from:'portcendb001',to:'switchportup01'},
			{id : '',name:'',from:'portcendb002',to:'switchportup02'},
			{id : '',name:'',from:'portcendb003',to:'switchportup03'},
			{id : '',name:'',from:'portcendb004',to:'switchportup04'},
			{id : '',name:'',from:'portcendb005',to:'switchportup05'},
			{id : '',name:'',from:'switchportdown01',to:'portstorage001'},
			{id : '',name:'',from:'switchportdown02',to:'portstorage002'},
			{id : '',name:'',from:'switchportdown03',to:'portstorage003'},
			{id : '',name:'',from:'switchportdown04',to:'portstorage004'},
			{id : '',name:'',from:'switchportdown05',to:'portstorage005'},
			{id : '',name:'',from:'switchportdown06',to:'portstorage006'},
			{id : '',name:'',from:'switchportdown07',to:'portstorage007'},
			{id : '',name:'',from:'switchportdown08',to:'portstorage008'},
			{id : '',name:'',from:'switchportdown09',to:'portstorage009'},
			{id : '',name:'',from:'switchportdown010',to:'portstorage0010'},
			{id : '',name:'',from:'switchportdown011',to:'portstorage0011'},
			{id : '',name:'',from:'switchportdown012',to:'portstorage0012'},
			{id : '',name:'',from:'switchportdown013',to:'portstorage0013'},
			{id : '',name:'',from:'switchportdown014',to:'portstorage0014'},
			{id : '',name:'',from:'switchportdown015',to:'portstorage0015'},
			{id : '',name:'',from:'switchportdown016',to:'portstorage0016'},
			{id : '',name:'',from:'switchportdown019',to:'portstorage101'},
			{id : '',name:'',from:'switchportdown020',to:'portstorage102'},
			{id : '',name:'',from:'switchportdown021',to:'portstorage103'},
			{id : '',name:'',from:'switchportdown022',to:'portstorage201'},
			{id : '',name:'',from:'switchportdown023',to:'portstorage202'}			
		]
	};
	var graph = new Q.Graph("canvas");
	graph.originAtCenter = false;
	graph.editable  = false;
	graph.enableDoubleClickToOverview  = false;
	graph.enableWheelZoom  = false;
	graph.scale = '0.9';
	
	
	
	translateToQuneeElements(fabricJson);
		
	
	function translateToQuneeElements(json){
		var host = null;
		if(json.Host){
			for(var i=0;i<json.Host.length;i++){
				var data = json.Host[i];
				host = toQuneeHost(data,i);
			}						
		}					
		
		if(json.Switch){
			for(var i = 0;i<json.Switch.length;i++){
				var data = json.Switch[i];
				toQuneeSwitch(data,i);
			}						
		}
		var length =0;
		if(json.subsystem){						
			for(var i=0;i<json.subsystem.length;i++){
				var data = json.subsystem[i];
				host = toQuneeSubsysterm(data,i,length);
				length = length + data.points.length;
			}	
		}					
		if(json.edge){
			Q.forEach(json.edge, toQuneeEdge);
		}			
	}
	
	function createLamp(point,x,y,color){					
		var lamp = graph.createNode(point.name || '',x || 0,y || 0);
		lamp.anchorPosition = Q.Position.CENTER_MIDDLE;		
		lamp.set('id',point.id);
		lamp.image = base + 'img/qunee/port.png';
		lamp.movable = false;	
		lamp.set('type','port');
		lamp.size = {width : 8};
		lamp.setStyle(Q.Styles.LABEL_FONT_SIZE, 8);
		lamp.setStyle(Q.Styles.LABEL_PADDING, 2);
		if(color){			
			lamp.setStyle(Q.Styles.LABEL_COLOR, color);
		}
		return lamp;
	}
	
	function createHost(name,x,y,children,panel_num,ports){
		var node = graph.createGroup(name || '');					
		if(!children){
			return false;
		}
		var deta_v = 40;
		var deta_h = 50;
		var power_x = x + ports * deta_h +10;
		var power_y =y + deta_v * panel_num - deta_v-10;					
		for(var n = 0;n < panel_num; n++){
			lx = x;
			ly = y + n * deta_v;
			for(var i = 0; i < ports; i++){
				var point = children[n* ports + i];				
				lx = lx + deta_h;											
				var lamp = createLamp(point,lx,ly);														
				node.addChild(lamp);							
			}					
		}		
		node.padding = new Q.Insets(25,12,8,12);
		node.minSize = {width: 5, height: 0};
		node.setStyle(Q.Styles.GROUP_BACKGROUND_COLOR, '#0068A5');
		node.setStyle(Q.Styles.GROUP_BACKGROUND_GRADIENT, Q.Gradient.LINEAR_GRADIENT_HORIZONTAL);
		node.setStyle(Q.Styles.GROUP_STROKE, 2);
		node.setStyle(Q.Styles.GROUP_STROKE_STYLE, "#41444B");
		node.setStyle(Q.Styles.LABEL_OFFSET_Y, -10);
		node.setStyle(Q.Styles.LABEL_POSITION, Q.Position.CENTER_TOP);
		node.setStyle(Q.Styles.LABEL_ANCHOR_POSITION, Q.Position.CENTER_BOTTOM);
		return node;
	}
	
	function toQuneeHost(data,i){					 			
		var node = createHost(data.name,midpoint.x+i*150,midpoint.y-180,data.points,1,1);					
		//node.movable = false;					
		node.set('id', data.id);
		node.set('type', 'host');						
		return node;
	}
	
	function createSwitch(name,x,y,children,panel_num,ports){
		var node = graph.createGroup(name || '',x,y);	
		node.set('type', 'switch');	
		node.setStyle(Q.Styles.GROUP_STROKE, 6);
		node.setStyle(Q.Styles.GROUP_STROKE_STYLE, "#828FA2");		
		//node.setStyle(Q.Styles.GROUP_BACKGROUND_GRADIENT, Q.Gradient.GRADIENT_TYPE_LINEAR);
		node.setStyle(Q.Styles.GROUP_BACKGROUND_COLOR, '#474B54');
		//node.image = base + 'img/qunee/switch2.png';
		node.minSize = {width: 5, height: 0};
		if(!children){
			return false;
		}
		var deta_v = 25;
		var deta_h = 20;
		var power_x = x + ports * deta_h +10;
		var power_y =y + deta_v * panel_num - deta_v-10;					
		for(var n = 0;n < 2; n++){
			lx = x+4;
			ly = y + n * deta_v;
			if(n==0){
				for(var i = 1; i < 6; i++){															
					var lamp = createLamp({id:'switchportup0'+i,name:''+i},lx,ly,'#FFF');	
					lx = lx + deta_h+80;	
					node.addChild(lamp);							
				}
			}else if(n==1){
				for(var i = 1; i < 24; i++){															
					var lamp = createLamp({id:'switchportdown0'+i,name:''+i},lx,ly,'#FFF');	
					lx = lx + deta_h;	
					node.addChild(lamp);							
				}
			}
								
		}	
		node.minSize = {width: 5, height: 0};
		node.setStyle(Q.Styles.LABEL_OFFSET_Y, -10);
		node.setStyle(Q.Styles.LABEL_POSITION, Q.Position.CENTER_TOP);
		node.setStyle(Q.Styles.LABEL_ANCHOR_POSITION, Q.Position.CENTER_BOTTOM);
		return node;
	}
	
	function toQuneeSwitch(data,i){	
		var node = createSwitch('',midpoint.x+200,midpoint.y,data.points,1,23);					
		return node;
	}
	
	function createSubsysterm(name,x,y,children){
		var node = graph.createGroup(name || '',x,y);	
		node.set('type', 'subsysterm');	
		if(!children){
			return false;
		}					
		var deta_h = 30;					
		lx = x;					
		for(var i = 0; i < children.length; i++){
			var point = children[i];	
			lx = lx + (i == 0 ? 0 : deta_h);											
			var lamp = createLamp(point,lx,y,'#FFF');														
			node.addChild(lamp);							
		}
		node.padding = new Q.Insets(25,12,25,12);
		node.minSize = {width: 5, height: 0};
		node.setStyle(Q.Styles.GROUP_BACKGROUND_COLOR, '#41454A');		
		node.setStyle(Q.Styles.GROUP_STROKE, 3);
		node.setStyle(Q.Styles.GROUP_STROKE_STYLE, "#828FA2");
		node.setStyle(Q.Styles.LABEL_OFFSET_Y, -10);
		node.setStyle(Q.Styles.LABEL_POSITION, Q.Position.CENTER_TOP);
		node.setStyle(Q.Styles.LABEL_ANCHOR_POSITION, Q.Position.CENTER_BOTTOM);
		return node;
	}
	
	function toQuneeSubsysterm(data,i,length){					
		var node = createSubsysterm(data.name,midpoint.x+40+ length * 30 + i * 160,midpoint.y + 190,data.points);
		node.set('id', data.id);
		node.set('type', 'subsysterm');		
		return node;
	}
	
	
	function toQuneeEdge(data){		
		var from = getElementById(data.from);		
		var to = getElementById(data.to);		
		var edge = graph.createEdge(data.name||'', from, to);	
		edge.setStyle(Q.Styles.ARROW_TO, false);	
		edge.setStyle(Q.Styles. EDGE_COLOR,'#88eecc');	
		edge.set('type','edge');
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
	
}
