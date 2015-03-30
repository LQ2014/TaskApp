function FlowingSupport(graph,base) {
    this.flowMap = {};
    this.graph = graph;
    this.base = base;
}
FlowingSupport.prototype = {
    flowMap: null,
    length: 0,
    gap: 40,
    graph: null,
    addFlowing: function (edgeOrLine, count, byPercent) {
        var flowList = this.flowMap[edgeOrLine.id];
        if(!flowList){
            flowList = this.flowMap[edgeOrLine.id] = [];
            this.length++;
        }
        count = count || 1;
        while(--count >= 0){
            var ui = new Q.ImageUI(this.base + "img/qunee/flow.png");
            ui.layoutByPath = true;
            ui.position = {x: 0, y: 0};
            ui.size = {width: 20};
            ui.renderColor = "#00FF00";
            flowList.push(ui);
            flowList.byPercent = byPercent;
            edgeOrLine.addUI(ui);
        }
    },
    removeFlowing: function(id){
        var flowList = this.flowMap[id];
        if(!flowList){
            return;
        }
        var edgeOrLine = this.graph.getElement(id);
        if(edgeOrLine){
            flowList.forEach(function(ui){
                edgeOrLine.removeUI(ui);
            })
        }
        this._doRemove(id);
    },
    _doRemove: function(id){
        delete this.flowMap[id];
        this.length--;
    },
    timer: null,
    perStep: 10,
    stop: function(){
        clearTimeout(this.timer);
    },
    start: function(){
        if(this.timer){
            clearTimeout(this.timer);
        }
        var offset = 0;
        var scope = this;
        scope.timer = setTimeout(function A() {
            if (!scope.length) {
                scope.timer = setTimeout(A, 2000);
                offset = 0;
                return;
            }
            offset += 1;
            for(var id in scope.flowMap){
                var ui = scope.graph.getUI(id);
                if(!ui){
                    scope._doRemove(id);
                    continue;
                }
                var lineLength = ui.length;
                if(!lineLength){
                    continue;
                }
                var flowList = scope.flowMap[id];
                if(flowList.byPercent){
                    //按百分比，0 - 1跑完整条线，线长度不同，速度也不同，跑完一圈的时间相同
                    var x = offset * 2;
                    var gap = 15;
                    scope.flowMap[id].forEach(function(ui){
                        ui.position = {x: (x % 100) / 100, y: 0};
                        x += gap;
                    });
                }else{
                    //按固定距离移动，速度相同，线条越长跑完一圈的时间越长
                    var x = offset * scope.perStep;
                    scope.flowMap[id].forEach(function(ui){
                        ui.position = {x: x % lineLength, y: 0};
                        x += scope.gap;
                    });
                }
                scope.graph.invalidateUI(ui);

                //dashed line
                var data = ui.data;
                if(data instanceof Q.Edge){
                    if(data.getStyle(Q.Styles.EDGE_LINE_DASH)){
                        data.setStyle(Q.Styles.EDGE_LINE_DASH_OFFSET, -offset);
                    }
                }else if(data instanceof Q.ShapeNode){
                    if(data.getStyle(Q.Styles.SHAPE_LINE_DASH)) {
                        data.setStyle(Q.Styles.SHAPE_LINE_DASH_OFFSET, -offset);
                    }
                }
            }
            scope.timer = setTimeout(A, 200);
        }, 200);
    }
}