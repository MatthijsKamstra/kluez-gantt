(function ($global) { "use strict";
var Main = function() {
	console.log("src/Main.hx:15:","Hello 'Example JS Gitlab'");
	this.makeResizableDiv(".resizable");
};
Main.main = function() {
	var app = new Main();
};
Main.prototype = {
	makeResizableDiv: function(div) {
		var element = window.document.querySelector(div);
		var resizers = window.document.querySelectorAll(div + " .resizer");
		var minimum_size = 20;
		var original_width = 0;
		var original_height = 0;
		var original_x = 0;
		var original_y = 0;
		var original_mouse_x = 0;
		var original_mouse_y = 0;
		var _g = 0;
		var _g1 = resizers.length;
		while(_g < _g1) {
			var i = _g++;
			var currentResizer = [resizers[i]];
			var resize = [(function(currentResizer) {
				return function(e) {
					if(currentResizer[0].classList.contains("bottom-right")) {
						var width = original_width + (e.pageX - original_mouse_x);
						var height = original_height + (e.pageY - original_mouse_y);
						if(width > minimum_size) {
							element.style.width = width + "px";
						}
						if(height > minimum_size) {
							element.style.height = height + "px";
						}
					} else if(currentResizer[0].classList.contains("bottom-left")) {
						var height = original_height + (e.pageY - original_mouse_y);
						var width = original_width - (e.pageX - original_mouse_x);
						if(height > minimum_size) {
							element.style.height = height + "px";
						}
						if(width > minimum_size) {
							element.style.width = width + "px";
							element.style.left = original_x + (e.pageX - original_mouse_x) + "px";
						}
					} else if(currentResizer[0].classList.contains("top-right")) {
						var width = original_width + (e.pageX - original_mouse_x);
						var height = original_height - (e.pageY - original_mouse_y);
						if(width > minimum_size) {
							element.style.width = width + "px";
						}
						if(height > minimum_size) {
							element.style.height = height + "px";
							element.style.top = original_y + (e.pageY - original_mouse_y) + "px";
						}
					} else {
						var width = original_width - (e.pageX - original_mouse_x);
						var height = original_height - (e.pageY - original_mouse_y);
						if(width > minimum_size) {
							element.style.width = width + "px";
							element.style.left = original_x + (e.pageX - original_mouse_x) + "px";
						}
						if(height > minimum_size) {
							element.style.height = height + "px";
							element.style.top = original_y + (e.pageY - original_mouse_y) + "px";
						}
					}
				};
			})(currentResizer)];
			var stopResize = [(function(resize) {
				return function() {
					window.removeEventListener("mousemove",resize[0]);
				};
			})(resize)];
			currentResizer[0].addEventListener("mousedown",(function(stopResize,resize) {
				return function(e) {
					e.preventDefault();
					original_width = Std.parseInt(StringTools.replace(window.getComputedStyle(element,null).getPropertyValue("width"),"px",""));
					original_height = Std.parseInt(StringTools.replace(window.getComputedStyle(element,null).getPropertyValue("height"),"px",""));
					original_x = element.getBoundingClientRect().left | 0;
					original_y = element.getBoundingClientRect().top | 0;
					original_mouse_x = e.pageX;
					original_mouse_y = e.pageY;
					window.addEventListener("mousemove",resize[0]);
					window.addEventListener("mouseup",stopResize[0]);
				};
			})(stopResize,resize));
		}
	}
};
var Std = function() { };
Std.parseInt = function(x) {
	if(x != null) {
		var _g = 0;
		var _g1 = x.length;
		while(_g < _g1) {
			var i = _g++;
			var c = x.charCodeAt(i);
			if(c <= 8 || c >= 14 && c != 32 && c != 45) {
				var nc = x.charCodeAt(i + 1);
				var v = parseInt(x,nc == 120 || nc == 88 ? 16 : 10);
				if(isNaN(v)) {
					return null;
				} else {
					return v;
				}
			}
		}
	}
	return null;
};
var StringTools = function() { };
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
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