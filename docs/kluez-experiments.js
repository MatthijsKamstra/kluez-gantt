(function ($global) { "use strict";
var Main = function() {
	console.log("src/Main.hx:14:","Main");
	kluez_DynamicStyle.setStyle();
	new kluez_CreateElement(window.document.getElementById("kluez-create-container"));
	new kluez_KlzDragElement(window.document.getElementById("kluez-drag-container"));
};
Main.__name__ = true;
Main.main = function() {
	var app = new Main();
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
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
StringTools.__name__ = true;
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
StringTools.hex = function(n,digits) {
	var s = "";
	var hexChars = "0123456789ABCDEF";
	while(true) {
		s = hexChars.charAt(n & 15) + s;
		n >>>= 4;
		if(!(n > 0)) {
			break;
		}
	}
	if(digits != null) {
		while(s.length < digits) s = "0" + s;
	}
	return s;
};
var haxe_ds_StringMap = function() {
	this.h = Object.create(null);
};
haxe_ds_StringMap.__name__ = true;
var const_Colors = function() { };
const_Colors.__name__ = true;
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.__name__ = true;
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
var hxColorToolkit_spaces_RGB = function(r,g,b) {
	if(b == null) {
		b = 0;
	}
	if(g == null) {
		g = 0;
	}
	if(r == null) {
		r = 0;
	}
	this.numOfChannels = 3;
	this.data = [];
	this.set_red(r);
	this.set_green(g);
	this.set_blue(b);
};
hxColorToolkit_spaces_RGB.__name__ = true;
hxColorToolkit_spaces_RGB.prototype = {
	getValue: function(channel) {
		return this.data[channel];
	}
	,setValue: function(channel,val) {
		this.data[channel] = Math.min(255,Math.max(val,0));
		return val;
	}
	,get_red: function() {
		return this.getValue(0);
	}
	,set_red: function(value) {
		return this.setValue(0,value);
	}
	,get_green: function() {
		return this.getValue(1);
	}
	,set_green: function(value) {
		return this.setValue(1,value);
	}
	,get_blue: function() {
		return this.getValue(2);
	}
	,set_blue: function(value) {
		return this.setValue(2,value);
	}
};
var hxColorToolkit_spaces_HSL = function(hue,saturation,lightness) {
	if(lightness == null) {
		lightness = 0;
	}
	if(saturation == null) {
		saturation = 0;
	}
	if(hue == null) {
		hue = 0;
	}
	this.numOfChannels = 3;
	this.data = [];
	this.set_hue(hue);
	this.set_saturation(saturation);
	this.set_lightness(lightness);
};
hxColorToolkit_spaces_HSL.__name__ = true;
hxColorToolkit_spaces_HSL.loop = function(index,length) {
	if(index < 0) {
		index = length + index % length;
	}
	if(index >= length) {
		index %= length;
	}
	return index;
};
hxColorToolkit_spaces_HSL.prototype = {
	getValue: function(channel) {
		return this.data[channel];
	}
	,get_hue: function() {
		return this.getValue(0);
	}
	,set_hue: function(val) {
		this.data[0] = hxColorToolkit_spaces_HSL.loop(val,360);
		return val;
	}
	,get_saturation: function() {
		return this.getValue(1);
	}
	,set_saturation: function(val) {
		this.data[1] = Math.min(100,Math.max(val,0));
		return val;
	}
	,get_lightness: function() {
		return this.getValue(2);
	}
	,set_lightness: function(val) {
		this.data[2] = Math.min(100,Math.max(val,0));
		return val;
	}
	,fromRGB: function(rgb) {
		var r = rgb.get_red();
		var g = rgb.get_green();
		var b = rgb.get_blue();
		r /= 255;
		g /= 255;
		b /= 255;
		var max = Math.max(r,Math.max(g,b));
		var min = Math.min(r,Math.min(g,b));
		var l = (max + min) / 2;
		var s = l;
		var h = s;
		if(max == min) {
			s = 0;
			h = s;
		} else {
			var d = max - min;
			s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
			h = max == r ? (g - b) / d + (g < b ? 6 : 0) : max == g ? (b - r) / d + 2 : (r - g) / d + 4;
			h /= 6;
		}
		this.set_hue(Math.round(h * 360));
		this.set_saturation(Math.round(s * 100));
		this.set_lightness(Math.round(l * 100));
		return this;
	}
	,setColor: function(color) {
		return this.fromRGB(new hxColorToolkit_spaces_RGB(color >> 16 & 255,color >> 8 & 255,color & 255));
	}
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g = 0;
			var _g1 = o.length;
			while(_g < _g1) {
				var i = _g++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( _g ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) {
			str += ", \n";
		}
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var kluez_CreateElement = function(el) {
	this.init(el);
};
kluez_CreateElement.__name__ = true;
kluez_CreateElement.prototype = {
	init: function(el) {
		var currentX = 0;
		var currentY = 0;
		var initialX = 0;
		var initialY = 0;
		var xOffset = 0;
		var yOffset = 0;
		var div = window.document.createElement("div");
		var onMouseMove = function(e) {
			if(e.type == "touchmove") {
				currentX = e.touches[0].clientX - initialX;
				currentY = e.touches[0].clientY - initialY;
			} else {
				currentX = e.clientX - initialX;
				currentY = e.clientY - initialY;
			}
			xOffset = currentX;
			yOffset = currentY;
			div.style.width = "" + xOffset + "px";
		};
		var onMouseUp = function(e) {
			initialX = currentX;
			initialY = currentY;
			div.className = "klz-el";
			div.style.height = "50px";
			div.innerText = "...";
			xOffset = 0;
			yOffset = 0;
			el.onmouseup = null;
			el.onmousemove = null;
			el.onmouseleave = null;
		};
		var onMouseDown = function(e) {
			if(e.type == "touchstart") {
				initialX = e.touches[0].clientX - xOffset;
				initialY = e.touches[0].clientY - yOffset;
			} else {
				initialX = e.clientX - xOffset;
				initialY = e.clientY - yOffset;
			}
			div = window.document.createElement("div");
			div.classList.add("klz-dotted");
			div.id = utils_UUID.uuid();
			div.style.left = "" + initialX + "px";
			div.style.top = "" + initialY + "px";
			div.style.height = "50px";
			div.style.position = "absolute";
			window.document.body.append(div);
			el.onmouseup = onMouseUp;
			el.onmousemove = onMouseMove;
			el.onmouseleave = onMouseUp;
		};
		el.ontouchstart = onMouseDown;
		el.onmousedown = onMouseDown;
	}
};
var kluez_DynamicStyle = function() { };
kluez_DynamicStyle.__name__ = true;
kluez_DynamicStyle.setStyle = function() {
	var xtraStyle = "";
	var str = "";
	var h = kluez_DynamicStyle.colorMap.h;
	var color_h = h;
	var color_keys = Object.keys(h);
	var color_length = color_keys.length;
	var color_current = 0;
	while(color_current < color_length) {
		var color = color_keys[color_current++];
		var hex = kluez_DynamicStyle.colorMap.h[color];
		var color1 = Std.parseInt(StringTools.replace(hex,"#","0x"));
		var hsl = new hxColorToolkit_spaces_HSL().setColor(color1);
		str += "\n\t\t\t--kluez-" + color + ": " + hex + ";\n\n\t\t\t--kluez-" + color + "-color: hsl(" + hsl.get_hue() + ", " + hsl.get_saturation() + "%, " + hsl.get_lightness() + "%);\n\n\t\t\t--kluez-" + color + "-color-lighten: hsl(" + hsl.get_hue() + ", " + hsl.get_saturation() + "%, " + (hsl.get_lightness() + 10) + "%);\n\n\t\t\t--kluez-" + color + "-color-darken: hsl(" + hsl.get_hue() + ", " + hsl.get_saturation() + "%, " + (hsl.get_lightness() - 10) + "%);\n\n\t\t\t";
		xtraStyle += "\n\t\t\t.klz-el-" + color + " {\n\t\t\t\tbackground-color: var(--kluez-" + color + "-color);\n\t\t\t\tborder-color: var(--kluez-" + color + "-color-darken);\n\t\t\t}\n\t\t\t";
	}
	var style2 = ":root { --kluez-blue: #3498db; }";
	var st = window.document.createElement("style");
	st.textContent = ":root { " + str + " }\n" + xtraStyle;
	window.document.head.append(st);
};
var kluez_El = function() { };
kluez_El.__name__ = true;
kluez_El.create = function(el,text,x,y,width) {
	var div = window.document.createElement("div");
	div.innerText = text;
	div.classList.add("klz-el");
	div.id = utils_UUID.uuid();
	div.style.left = "" + x + "px";
	div.style.top = "" + y + "px";
	div.style.width = "" + width + "px";
	div.style.height = "50px";
	div.style.position = "absolute";
	el.append(div);
	return div;
};
var kluez_KlzDragElement = function(element) {
	this.createElements(element);
};
kluez_KlzDragElement.__name__ = true;
kluez_KlzDragElement.prototype = {
	createElements: function(element) {
		var i = 0;
		var h = const_Colors.colorMap.h;
		var color_h = h;
		var color_keys = Object.keys(h);
		var color_length = color_keys.length;
		var color_current = 0;
		while(color_current < color_length) {
			var color = color_keys[color_current++];
			var hex = const_Colors.colorMap.h[color];
			var e = kluez_El.create(element,hex,utils_MathUtil.randomInteger(10,300),i * 60 + 10,utils_MathUtil.randomInteger(50,500));
			e.classList.add("klz-el-" + color,"draggable");
			++i;
			this.init(e);
		}
		element.style.height = "" + (60 * i + 10) + "px";
	}
	,init: function(el) {
		var currentX = 0;
		var currentY = 0;
		var initialX = 0;
		var initialY = 0;
		var xOffset = 0;
		var yOffset = 0;
		var setTranslate = function(el,xPos,yPos) {
			el.style.transform = "translate3d(" + (xPos == null ? "null" : "" + xPos) + "px, 0px, 0)";
		};
		var onMouseMove = function(e) {
			var el = e.target;
			if(e.type == "touchmove") {
				currentX = e.touches[0].clientX - initialX;
				currentY = e.touches[0].clientY - initialY;
			} else {
				currentX = e.clientX - initialX;
				currentY = e.clientY - initialY;
			}
			xOffset = currentX;
			yOffset = currentY;
			setTranslate(el,currentX,currentY);
		};
		var onMouseEnd = function(e) {
			var el = e.target;
			initialX = currentX;
			initialY = currentY;
			el.classList.remove("active");
			el.onmouseup = null;
			el.onmousemove = null;
			el.onmouseleave = null;
		};
		var onMouseDown = function(e) {
			var el = e.target;
			el.classList.add("active");
			if(e.type == "touchstart") {
				initialX = e.touches[0].clientX - xOffset;
				initialY = e.touches[0].clientY - yOffset;
			} else {
				initialX = e.clientX - xOffset;
				initialY = e.clientY - yOffset;
			}
			el.onmouseup = onMouseEnd;
			el.onmousemove = onMouseMove;
			el.onmouseleave = onMouseEnd;
		};
		el.ontouchstart = onMouseDown;
		el.onmousedown = onMouseDown;
	}
};
var utils_MathUtil = function() { };
utils_MathUtil.__name__ = true;
utils_MathUtil.randomInteger = function(min,max) {
	if(max == null) {
		max = min;
		min = 0;
	}
	return Math.floor(Math.random() * (max + 1 - min)) + min;
};
var utils_UUID = function() { };
utils_UUID.__name__ = true;
utils_UUID.uuid = function() {
	var uid_b = "";
	var a = 8;
	uid_b += Std.string(StringTools.hex(new Date().getTime() | 0,8));
	while(a++ < 36) uid_b += Std.string((a * 51 & 52) != 0 ? StringTools.hex((a ^ 15) != 0 ? 8 ^ (Math.random() * ((a ^ 20) != 0 ? 16 : 4) | 0) : 4) : "-");
	return uid_b.toLowerCase();
};
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = "Date";
js_Boot.__toStr = ({ }).toString;
const_Colors.colorMap = (function($this) {
	var $r;
	var _g = new haxe_ds_StringMap();
	_g.h["green"] = "#1abc9c";
	_g.h["blue"] = "#3498db";
	_g.h["purple"] = "#9b59b6";
	_g.h["yellow"] = "#f1c40f";
	_g.h["red"] = "#e74c3c";
	_g.h["gray"] = "#95a5a6";
	$r = _g;
	return $r;
}(this));
kluez_DynamicStyle.colorMap = (function($this) {
	var $r;
	var _g = new haxe_ds_StringMap();
	_g.h["gray"] = "#95a5a6";
	_g.h["green"] = "#1abc9c";
	_g.h["blue"] = "#3498db";
	_g.h["purple"] = "#9b59b6";
	_g.h["yellow"] = "#f1c40f";
	_g.h["red"] = "#e74c3c";
	$r = _g;
	return $r;
}(this));
Main.main();
})({});

//# sourceMappingURL=kluez-experiments.js.map