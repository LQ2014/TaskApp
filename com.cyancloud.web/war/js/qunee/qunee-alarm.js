if(!Q.Element.prototype.initAlarmBalloon){
    Q.Element.prototype.initAlarmBalloon = function(){
        var alarmUI = new Q.LabelUI();
        alarmUI.position = Q.Position.CENTER_TOP;
        alarmUI.anchorPosition = Q.Position.LEFT_BOTTOM;
        alarmUI.border = 1;
        alarmUI.backgroundGradient = Q.Gradient.LINEAR_GRADIENT_VERTICAL;
        alarmUI.padding = new Q.Insets(2, 5);
        alarmUI.showPointer = true;
        alarmUI.offsetY = -10;
        alarmUI.offsetX = -10;
        alarmUI.rotatable = false;
        this._alarmBalloon = alarmUI;
    }
    Q.Element.prototype._checkAlarmBalloon = function(){
        if(!this.alarmLabel || !this.alarmColor){
            if(this._alarmBalloon){
                this.removeUI(this._alarmBalloon);
            }
            return;
        }
        if(!this._alarmBalloon){
            this.initAlarmBalloon();
        }
        this._alarmBalloon.data = this.alarmLabel;
        this._alarmBalloon.backgroundColor = this.alarmColor;
        if(this.addUI(this._alarmBalloon) === false){
            this.invalidate();
        }
    }
    Object.defineProperties(Q.Element.prototype, {
        alarmLabel: {
            get: function(){
                return this._alarmLabel;
            },
            set: function(label){
                if(this._alarmLabel == label){
                    return;
                }
                this._alarmLabel = label;
                this._checkAlarmBalloon();
            }
        },
        alarmColor: {
            get: function(){
                return this._alarmColor;
            },
            set: function(color){
                if(this._alarmColor == color){
                    return;
                }
                this._alarmColor = color;
                this.setStyle(Q.Styles.RENDER_COLOR, color);
                this._checkAlarmBalloon();
            }
        }
    })
}
Alarm = function(config){
	config = config || this;
	$.extend(this,config);
	return this;
}
Alarm.prototype = {
	time : null,
	items : null,
	color : '#F00',
	timer : null,
	randomColor : function(element){
		var colors = [this.color,'#FFF'];
		var flag = element.flag;		
		if(flag == undefined){
			flag = 0;
		}else{			
			flag = (flag == 1 ? 0 : 1);
		}		
		element.flag = flag;
		return colors[flag];
	},
	start : function(){				
		for(var i=0;i<this.items.length;i++){
			this.alarm(this.items[i]);
		}
	},
	
	alarm : function(element){
		_this = this;
		this.timer = setTimeout(function A(){
			//element.alarmLabel = " ? ";
			element.alarmColor = _this.randomColor(element);				
			_this.timer = setTimeout(A, _this.time);
		}, this.time);
	}
		
}