function showDivAt(div, x, y){
    var body = document.documentElement;
    var bounds = new Q.Rect(window.pageXOffset, window.pageYOffset, body.clientWidth - 2, body.clientHeight - 2);
    var width = div.offsetWidth;
    var height = div.offsetHeight;

    if (x + width > bounds.x + bounds.width) {
        x = bounds.x + bounds.width - width;
    }
    if (y + height > bounds.y + bounds.height) {
        y = bounds.y + bounds.height - height;
    }
    if (x < bounds.x) {
        x = bounds.x;
    }
    if (y < bounds.y) {
        y = bounds.y;
    }
    div.style.left = x + 'px';
    div.style.top = y + 'px';
}
function isDescendant(parent, child) {
    var node = child.parentNode;
    while (node != null) {
        if (node == parent) {
            return true;
        }
        node = node.parentNode;
    }
    return false;
}
var PopupMenu = function(items){
    this.items = items || [];
}
var menuClassName = 'dropdown-menu';
PopupMenu.Separator = 'divider';

PopupMenu.prototype = {
    dom : null,
    _invalidateFlag: true,
    add : function(item){
        this.items.push(item);
        this._invalidateFlag = true;
    },
    addSeparator : function() {
        this.add(PopupMenu.Separator);
    },
    showAt: function(x, y){			    	
        if(!this.items || !this.items.length){
            return false;
        }
        if(this._invalidateFlag){
            this.render();
        }
       
        this.dom.style.display = "block";
        document.body.appendChild(this.dom);
        showDivAt(this.dom, x, y);
    },
    hide : function(){
        if(this.dom && this.dom.parentNode){
            this.dom.parentNode.removeChild(this.dom);
        }
    },

    render : function(){
        this._invalidateFlag = false;
        if(!this.dom){
            this.dom = document.createElement('ul');
            this.dom.setAttribute("role", "menu");
            this.dom.className = menuClassName;
            var startEventName = Q.isTouchSupport ? "touchstart" : "mousedown";
            if(!this.stopEditWhenClickOnWindow){
                var _this = this;
                this.stopEditWhenClickOnWindow = function(evt){
                    if(isDescendant(_this.html, evt.target)){
                        _this.hide();
                    }
                }
            }
            window.addEventListener("mousedown", this.stopEditWhenClickOnWindow, true);
            this.dom.addEventListener(startEventName, function(evt){
                Q.stopEvent(evt);
            }, false);
        }else{
            this.dom.innerHTML = "";
        }
        for (var i = 0,l = this.items.length; i < l; i++) {
            var item = this.renderItem(this.items[i]);
            this.dom.appendChild(item);
        }
    },
    html2Escape: function(sHtml) {
        return sHtml.replace(/[<>&"]/g,function(c){return {'<':'&lt;','>':'&gt;','&':'&amp;','"':'&quot;'}[c];});
    },
    renderItem : function(menuItem, zIndex){
        var dom = document.createElement('li');
        dom.setAttribute("role", "presentation");
        if(menuItem == PopupMenu.Separator){
            dom.className = PopupMenu.Separator;
            dom.innerHTML = " ";
            return dom;
        }
        if(Q.isString(menuItem)){
            dom.innerHTML = '<a role="menuitem" tabindex="-1" href="#">' + this.html2Escape(menuItem) + '</a>';
            return dom;
        }
        if(menuItem.selected){
            dom.style.backgroundPosition = '3px 5px';
            dom.style.backgroundRepeat = 'no-repeat';
            dom.style.backgroundImage = "url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAPklEQVQ4y2P4//8/AyWYYdQA7AYAAZuamlo7ED+H4naQGNEGQDX/R8PtpBjwHIsBz+lqAGVeoDgQR1MiaRgAnxW7Q0QEK0cAAAAASUVORK5CYII=')";
        }
        var a = document.createElement("a");
        a.setAttribute("role", "menuitem");
        a.setAttribute("tabindex", "-1");
        a.setAttribute("href", "javascript:void(0)");
        dom.appendChild(a);

        var text = menuItem.text || menuItem.name;
        if(text){
            a.innerHTML = this.html2Escape(text);
        }
        var className = menuItem.className;
        if(className){
            dom.className = className;
        }
        var call = menuItem.action;
        var self = this;

        var onclick = function(evt){
            if (call) {
                call.call(menuItem.scope, evt, menuItem);
            }
            if(!Q.isIOS){
                evt.target.focus();
            }
            setTimeout(function(){
                self.hide();
            }, 100);
        };
        if(Q.isTouchSupport){
	// dom.ontouchstart = onclick;
            a.ontouchstart = onclick;
        }else{
            dom.onclick = onclick;
        }
        return dom;
    },
    
    getMenuItems: function(graph, data, evt){
        return [];
    },
	
	initPopMenu : function(graph){
		var _this = this;
	   function showMenu(evt, graph){
			var xy = getPageXY(evt);
			var x = xy.x, y = xy.y;
			var data = graph.getElementByMouseEvent(evt);
			
			var items = _this.getMenuItems(graph, graph.getElement(evt), evt);
			_this.items = items;
			_this.showAt(x, y);
		  
		   
		}
		if(Q.isTouchSupport){
			graph.addCustomInteraction({
				onlongpress: function (evt, graph) {
					showMenu(evt, graph)
				},
				onstart: function (evt) {
					_this.hide();
				}
			});
		}else{
			graph.html.oncontextmenu = function(evt){
				Q.stopEvent(evt);
				showMenu(evt, graph);
			}
			graph.addCustomInteraction({
				onstart: function (evt) {
					_this.hide();
				}
			});
		}
		
	}				

}
Object.defineProperties(PopupMenu.prototype, {
    items: {
        get:function(){
            return this._items;
        },
        set: function(v){
            this._items = v;
            this._invalidateFlag = true;
        }
    }
});

function getPageXY(evt){
    if (evt.touches && evt.touches.length) {
        evt = evt.touches[0];
    }
    return {x: evt.pageX, y: evt.pageY};
}
