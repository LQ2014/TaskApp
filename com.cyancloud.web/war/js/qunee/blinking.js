Blinking = function(config){
	config = config || this;
	$.extend(this,config);
}
/*
Blinking = function(items,color,time){
	this.items = items || [];
	this.color = color || '#F00';
	this.time = time || 1000;
}*/
Blinking.prototype = {
	items : null,
	color : null,
	time : null,
	blinkingTimer : null,	
	blinking : function(element,color){		
		var blinking = element._blinking;
		if(blinking === undefined){
			blinking = false;
		}else{
			blinking = !blinking;
		}		
		element._blinking = blinking;		
		element.setStyle(Q.Styles.RENDER_COLOR, blinking ? color : null);
	},
	resetBlinking : function(element){
		if(element._blinking === false){
			element.setStyle(Q.Styles.RENDER_COLOR, null);
		}
	},
	stopBlinking : function(elements){
		 if(this.blinkingTimer){
			clearTimeout(this.blinkingTimer);
			this.blinkingTimer = null;
			for(var n = 0;n < elements.length;n++){
				this.resetBlinking(elements[n]);
			}
		}
	},
	startBlinking : function(){		
		if(this.blinkingTimer){
			return;
		}
		var _this = this;
		this.blinkingTimer = setTimeout(function A() {
			for(var n =0;n<_this.items.length;n++){
				_this.blinking(_this.items[n],_this.color);
			}			
			
			_this.blinkingTimer = setTimeout(A, _this.time);
		}, this.time);
	},
	
	destroy : function(){
		if(this.blinkingTimer) {
			clearTimeout(this.blinkingTimer);
		}
	},	
	removeItem : function(elem){
		for(var n = 0; n < this.items.length; n++){
			if(elem && this.items[n].id == elem.id){
				this.items.splice(n,1);
				break;
			}
		}
		
	},
	addItem : function(elem){
		this.items.push(elem);
	}

}