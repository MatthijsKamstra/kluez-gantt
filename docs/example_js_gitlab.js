(function ($global) { "use strict";
var Main = function() {
	console.log("src/Main.hx:11:","Main");
	this.initDrag(window.document.getElementById("resizeMe"));
};
Main.main = function() {
	var app = new Main();
};
Main.prototype = {
	initDrag: function(el) {
		var active = false;
		var currentX = 0;
		var currentY = 0;
		var initialX = 0;
		var initialY = 0;
		var xOffset = 0;
		var yOffset = 0;
		var dragStart = function(e) {
			console.log("src/Main.hx:27:","dragstart");
			console.log("src/Main.hx:28:",e);
			if(e.type == "touchstart") {
				initialX = e.touches[0].clientX - xOffset;
				initialY = e.touches[0].clientY - yOffset;
			} else {
				initialX = e.clientX - xOffset;
				initialY = e.clientY - yOffset;
			}
			if(e.target == el) {
				active = true;
				console.log("src/Main.hx:40:",active);
			}
		};
		var dragEnd = function(e) {
			console.log("src/Main.hx:45:","dragend");
			initialX = currentX;
			initialY = currentY;
			active = false;
		};
		var setTranslate = function(xPos,yPos,el) {
			el.style.transform = "translate3d(" + (xPos == null ? "null" : "" + xPos) + "px, 0px, 0)";
		};
		var drag = function(e) {
			if(active) {
				e.preventDefault();
				if(e.type == "touchmove") {
					currentX = e.touches[0].clientX - initialX;
					currentY = e.touches[0].clientY - initialY;
				} else {
					currentX = e.clientX - initialX;
					currentY = e.clientY - initialY;
				}
				xOffset = currentX;
				yOffset = currentY;
				setTranslate(currentX,currentY,e.target);
			}
		};
		el.addEventListener("touchstart",dragStart,false);
		el.addEventListener("touchend",dragEnd,false);
		el.addEventListener("touchmove",drag,false);
		el.addEventListener("mousedown",dragStart,false);
		el.addEventListener("mouseup",dragEnd,false);
		el.addEventListener("mousemove",drag,false);
	}
};
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
Main.main();
})({});

//# sourceMappingURL=example_js_gitlab.js.map