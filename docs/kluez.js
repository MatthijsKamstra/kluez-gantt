(function ($global) { "use strict";
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var DateTools = function() { };
DateTools.__name__ = true;
DateTools.__format_get = function(d,e) {
	switch(e) {
	case "%":
		return "%";
	case "A":
		return DateTools.DAY_NAMES[d.getDay()];
	case "B":
		return DateTools.MONTH_NAMES[d.getMonth()];
	case "C":
		return StringTools.lpad(Std.string(d.getFullYear() / 100 | 0),"0",2);
	case "D":
		return DateTools.__format(d,"%m/%d/%y");
	case "F":
		return DateTools.__format(d,"%Y-%m-%d");
	case "I":case "l":
		var hour = d.getHours() % 12;
		return StringTools.lpad(Std.string(hour == 0 ? 12 : hour),e == "I" ? "0" : " ",2);
	case "M":
		return StringTools.lpad(Std.string(d.getMinutes()),"0",2);
	case "R":
		return DateTools.__format(d,"%H:%M");
	case "S":
		return StringTools.lpad(Std.string(d.getSeconds()),"0",2);
	case "T":
		return DateTools.__format(d,"%H:%M:%S");
	case "Y":
		return Std.string(d.getFullYear());
	case "a":
		return DateTools.DAY_SHORT_NAMES[d.getDay()];
	case "b":case "h":
		return DateTools.MONTH_SHORT_NAMES[d.getMonth()];
	case "d":
		return StringTools.lpad(Std.string(d.getDate()),"0",2);
	case "e":
		return Std.string(d.getDate());
	case "H":case "k":
		return StringTools.lpad(Std.string(d.getHours()),e == "H" ? "0" : " ",2);
	case "m":
		return StringTools.lpad(Std.string(d.getMonth() + 1),"0",2);
	case "n":
		return "\n";
	case "p":
		if(d.getHours() > 11) {
			return "PM";
		} else {
			return "AM";
		}
		break;
	case "r":
		return DateTools.__format(d,"%I:%M:%S %p");
	case "s":
		return Std.string(d.getTime() / 1000 | 0);
	case "t":
		return "\t";
	case "u":
		var t = d.getDay();
		if(t == 0) {
			return "7";
		} else if(t == null) {
			return "null";
		} else {
			return "" + t;
		}
		break;
	case "w":
		return Std.string(d.getDay());
	case "y":
		return StringTools.lpad(Std.string(d.getFullYear() % 100),"0",2);
	default:
		throw new haxe_exceptions_NotImplementedException("Date.format %" + e + "- not implemented yet.",null,{ fileName : "DateTools.hx", lineNumber : 101, className : "DateTools", methodName : "__format_get"});
	}
};
DateTools.__format = function(d,f) {
	var r_b = "";
	var p = 0;
	while(true) {
		var np = f.indexOf("%",p);
		if(np < 0) {
			break;
		}
		var len = np - p;
		r_b += len == null ? HxOverrides.substr(f,p,null) : HxOverrides.substr(f,p,len);
		r_b += Std.string(DateTools.__format_get(d,HxOverrides.substr(f,np + 1,1)));
		p = np + 2;
	}
	var len = f.length - p;
	r_b += len == null ? HxOverrides.substr(f,p,null) : HxOverrides.substr(f,p,len);
	return r_b;
};
DateTools.format = function(d,f) {
	return DateTools.__format(d,f);
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.strDate = function(s) {
	switch(s.length) {
	case 8:
		var k = s.split(":");
		var d = new Date();
		d["setTime"](0);
		d["setUTCHours"](k[0]);
		d["setUTCMinutes"](k[1]);
		d["setUTCSeconds"](k[2]);
		return d;
	case 10:
		var k = s.split("-");
		return new Date(k[0],k[1] - 1,k[2],0,0,0);
	case 19:
		var k = s.split(" ");
		var y = k[0].split("-");
		var t = k[1].split(":");
		return new Date(y[0],y[1] - 1,y[2],t[0],t[1],t[2]);
	default:
		throw haxe_Exception.thrown("Invalid date format : " + s);
	}
};
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) {
		return undefined;
	}
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(len == null) {
		len = s.length;
	} else if(len < 0) {
		if(pos == 0) {
			len = s.length + len;
		} else {
			return "";
		}
	}
	return s.substr(pos,len);
};
HxOverrides.now = function() {
	return Date.now();
};
var MainKluez = function() {
	haxe_Log.trace("MainKluez",{ fileName : "src/MainKluez.hx", lineNumber : 27, className : "MainKluez", methodName : "new"});
	kluez_DynamicStyle.setStyle();
	var wSize = 60;
	var hSize = 60;
	var pSize = 10;
	var json = new utils_Convert().gantt(const_Gantt.TEST_2);
	var obj = utils_DateUtil.convert(HxOverrides.strDate(json.start_date),HxOverrides.strDate(json.end_date));
	$global.console.log(json);
	$global.console.log(JSON.stringify(json,null,"  "));
	this.createDate(json,wSize,hSize);
	var container = window.document.getElementById("container-gantt-kluez").getElementsByClassName("gantt")[0];
	haxe_Log.trace(container,{ fileName : "src/MainKluez.hx", lineNumber : 42, className : "MainKluez", methodName : "new"});
	var _g = 0;
	var _g1 = json.sections.length;
	while(_g < _g1) {
		var i = _g++;
		var section = json.sections[i];
		haxe_Log.trace(section.title,{ fileName : "src/MainKluez.hx", lineNumber : 50, className : "MainKluez", methodName : "new"});
		var title = section.title;
		var startObj = utils_DateUtil.convert(HxOverrides.strDate(json.start_date),HxOverrides.strDate(section.start_date));
		var xpos = startObj.days * wSize;
		var ypos = i * hSize + Math.round(pSize / 2);
		var w = section.total.days * wSize;
		var h = hSize - pSize;
		var el = kluez_El.create(title,xpos,ypos,w,h,section);
		el.classList.add(const_ClassNames.DRAGGABLE,const_ClassNames.RESIZEABLE);
		container.append(el);
		var combiEl = new kluez_CombiElement(el);
		combiEl.grid = hSize;
		combiEl.padding = pSize;
		combiEl.isSnapToGrid = true;
		combiEl.init();
	}
	var xTotal = obj.days;
	var yTotal = json.sections.length + 1;
	haxe_Log.trace(xTotal,{ fileName : "src/MainKluez.hx", lineNumber : 73, className : "MainKluez", methodName : "new"});
	haxe_Log.trace(yTotal,{ fileName : "src/MainKluez.hx", lineNumber : 74, className : "MainKluez", methodName : "new"});
	this.createTable(xTotal,yTotal,wSize,hSize);
};
MainKluez.__name__ = true;
MainKluez.main = function() {
	var app = new MainKluez();
};
MainKluez.prototype = {
	createDate: function(json,wSize,hSize) {
		var obj = utils_DateUtil.convert(HxOverrides.strDate(json.start_date),HxOverrides.strDate(json.end_date));
		var sdate = HxOverrides.strDate(json.start_date);
		var container = window.document.getElementById("container-date");
		haxe_Log.trace(container,{ fileName : "src/MainKluez.hx", lineNumber : 85, className : "MainKluez", methodName : "createDate"});
		var _xTotal = Math.round(obj.days * 1.5);
		var _yTotal = Math.round(3);
		var row = "";
		var dateRow = "";
		var dayRow = "";
		var weekRow = "";
		var monthRow = "";
		var i = 0;
		var dayArr = ["zo","ma","di","wo","do","vr","za"];
		var jan1 = new Date(sdate.getFullYear(),0,1,0,0,0);
		haxe_Log.trace(jan1,{ fileName : "src/MainKluez.hx", lineNumber : 100, className : "MainKluez", methodName : "createDate", customParams : [jan1.getDay(),dayArr[jan1.getDay()]]});
		dayRow += "<div class=\"klz-row klz-row-day\" style=\"width: " + wSize * _xTotal + "px\">";
		dateRow += "<div class=\"klz-row klz-row-date\" style=\"width: " + wSize * _xTotal + "px\">";
		var _g = 0;
		var _g1 = _xTotal;
		while(_g < _g1) {
			var x = _g++;
			var date = new Date(sdate.getTime() + x * 24.0 * 60.0 * 60.0 * 1000.0);
			if(date.getDay() != 0 && date.getDay() != 6) {
				dayRow += "<div class=\"klz-item klz-day klz-day-" + dayArr[date.getDay()] + "\">" + dayArr[date.getDay()] + "<!-- x:" + x + " --></div>";
				dateRow += "<div class=\"klz-item klz-date klz-day-" + dayArr[date.getDay()] + "\">" + date.getDate() + "<!-- x:" + x + " --></div>";
			}
		}
		dayRow += "</div>";
		dateRow += "</div>";
		var t = "<div class=\"container-kluez-table\">" + dayRow + dateRow + "</div>";
		var frag = window.document.createRange().createContextualFragment(t);
		container.appendChild(frag);
	}
	,createTable: function(xTotal,yTotal,wSize,hSize) {
		var container = window.document.getElementById("container-gantt-kluez").getElementsByClassName("pattern")[0];
		var row = "";
		var _xTotal = Math.round(xTotal * 1.5);
		var _yTotal = Math.round(yTotal);
		var _g = 0;
		var _g1 = _yTotal;
		while(_g < _g1) {
			var y = _g++;
			row += "<div class=\"klz-row\" style=\"width: " + wSize * _xTotal + "px\">";
			var _g2 = 0;
			var _g3 = _xTotal;
			while(_g2 < _g3) {
				var x = _g2++;
				row += "<div class=\"klz-item\"><!-- x:" + x + ", y:" + y + " --></div>";
			}
			row += "</div>";
		}
		var t = "<div class=\"container-kluez-table\">" + row + "</div>";
		var frag = window.document.createRange().createContextualFragment(t);
		container.appendChild(frag);
	}
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.getProperty = function(o,field) {
	var tmp;
	if(o == null) {
		return null;
	} else {
		var tmp1;
		if(o.__properties__) {
			tmp = o.__properties__["get_" + field];
			tmp1 = tmp;
		} else {
			tmp1 = false;
		}
		if(tmp1) {
			return o[tmp]();
		} else {
			return o[field];
		}
	}
};
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
StringTools.startsWith = function(s,start) {
	if(s.length >= start.length) {
		return s.lastIndexOf(start,0) == 0;
	} else {
		return false;
	}
};
StringTools.isSpace = function(s,pos) {
	var c = HxOverrides.cca(s,pos);
	if(!(c > 8 && c < 14)) {
		return c == 32;
	} else {
		return true;
	}
};
StringTools.ltrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,r)) ++r;
	if(r > 0) {
		return HxOverrides.substr(s,r,l - r);
	} else {
		return s;
	}
};
StringTools.rtrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,l - r - 1)) ++r;
	if(r > 0) {
		return HxOverrides.substr(s,0,l - r);
	} else {
		return s;
	}
};
StringTools.trim = function(s) {
	return StringTools.ltrim(StringTools.rtrim(s));
};
StringTools.lpad = function(s,c,l) {
	if(c.length <= 0) {
		return s;
	}
	var buf_b = "";
	l -= s.length;
	while(buf_b.length < l) buf_b += c == null ? "null" : "" + c;
	buf_b += s == null ? "null" : "" + s;
	return buf_b;
};
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
var const_ClassNames = function() { };
const_ClassNames.__name__ = true;
var const_Gantt = function() { };
const_Gantt.__name__ = true;
var haxe_Exception = function(message,previous,native) {
	Error.call(this,message);
	this.message = message;
	this.__previousException = previous;
	this.__nativeException = native != null ? native : this;
};
haxe_Exception.__name__ = true;
haxe_Exception.thrown = function(value) {
	if(((value) instanceof haxe_Exception)) {
		return value.get_native();
	} else if(((value) instanceof Error)) {
		return value;
	} else {
		var e = new haxe_ValueException(value);
		return e;
	}
};
haxe_Exception.__super__ = Error;
haxe_Exception.prototype = $extend(Error.prototype,{
	toString: function() {
		return this.get_message();
	}
	,get_message: function() {
		return this.message;
	}
	,get_native: function() {
		return this.__nativeException;
	}
	,__properties__: {get_native:"get_native",get_message:"get_message"}
});
var haxe_Log = function() { };
haxe_Log.__name__ = true;
haxe_Log.formatOutput = function(v,infos) {
	var str = Std.string(v);
	if(infos == null) {
		return str;
	}
	var pstr = infos.fileName + ":" + infos.lineNumber;
	if(infos.customParams != null) {
		var _g = 0;
		var _g1 = infos.customParams;
		while(_g < _g1.length) {
			var v = _g1[_g];
			++_g;
			str += ", " + Std.string(v);
		}
	}
	return pstr + ": " + str;
};
haxe_Log.trace = function(v,infos) {
	var str = haxe_Log.formatOutput(v,infos);
	if(typeof(console) != "undefined" && console.log != null) {
		console.log(str);
	}
};
var haxe_ValueException = function(value,previous,native) {
	haxe_Exception.call(this,String(value),previous,native);
	this.value = value;
};
haxe_ValueException.__name__ = true;
haxe_ValueException.__super__ = haxe_Exception;
haxe_ValueException.prototype = $extend(haxe_Exception.prototype,{
});
var haxe_ds_StringMap = function() {
	this.h = Object.create(null);
};
haxe_ds_StringMap.__name__ = true;
var haxe_exceptions_PosException = function(message,previous,pos) {
	haxe_Exception.call(this,message,previous);
	if(pos == null) {
		this.posInfos = { fileName : "(unknown)", lineNumber : 0, className : "(unknown)", methodName : "(unknown)"};
	} else {
		this.posInfos = pos;
	}
};
haxe_exceptions_PosException.__name__ = true;
haxe_exceptions_PosException.__super__ = haxe_Exception;
haxe_exceptions_PosException.prototype = $extend(haxe_Exception.prototype,{
	toString: function() {
		return "" + haxe_Exception.prototype.toString.call(this) + " in " + this.posInfos.className + "." + this.posInfos.methodName + " at " + this.posInfos.fileName + ":" + this.posInfos.lineNumber;
	}
});
var haxe_exceptions_NotImplementedException = function(message,previous,pos) {
	if(message == null) {
		message = "Not implemented";
	}
	haxe_exceptions_PosException.call(this,message,previous,pos);
};
haxe_exceptions_NotImplementedException.__name__ = true;
haxe_exceptions_NotImplementedException.__super__ = haxe_exceptions_PosException;
haxe_exceptions_NotImplementedException.prototype = $extend(haxe_exceptions_PosException.prototype,{
});
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
	,__properties__: {set_blue:"set_blue",get_blue:"get_blue",set_green:"set_green",get_green:"get_green",set_red:"set_red",get_red:"get_red"}
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
	,__properties__: {set_lightness:"set_lightness",get_lightness:"get_lightness",set_saturation:"set_saturation",get_saturation:"get_saturation",set_hue:"set_hue",get_hue:"get_hue"}
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
var kluez_CombiElement = function(el) {
	this.isSnapToGrid = false;
	this.grid = 1;
	this.el = el;
};
kluez_CombiElement.__name__ = true;
kluez_CombiElement.prototype = {
	init: function() {
		var _gthis = this;
		var xCurrent = 0;
		var yCurrent = 0;
		var xInitial = 0;
		var yInitial = 0;
		var xOffset = 0;
		var yOffset = 0;
		var xOriginal = 0;
		var yOriginal = 0;
		var wOriginal = 0;
		var hOriginal = 0;
		var xMouseOriginal = 0;
		var yMouseOriginal = 0;
		var isDrag = true;
		if(this.el.classList.contains(const_ClassNames.RESIZEABLE)) {
			var resizeEl = window.document.createElement("div");
			resizeEl.classList.add("resizer-r");
			this.el.appendChild(resizeEl);
			resizeEl.onmouseover = function() {
				isDrag = false;
				return isDrag;
			};
			resizeEl.onmouseout = function() {
				isDrag = true;
				return isDrag;
			};
		}
		var onMouseMove = function(e) {
			if(e.type == "touchmove") {
				xCurrent = e.touches[0].clientX - xInitial;
				yCurrent = e.touches[0].clientY - yInitial;
			} else {
				xCurrent = e.clientX - xInitial;
				yCurrent = e.clientY - yInitial;
			}
			xOffset = xCurrent;
			yOffset = yCurrent;
			if(isDrag) {
				if(_gthis.isSnapToGrid) {
					var gridValue = Math.round((xOriginal + xCurrent) / _gthis.grid) * _gthis.grid;
					_gthis.el.style.left = "" + gridValue + "px";
				} else {
					_gthis.el.style.left = "" + (xOriginal + xCurrent) + "px";
				}
			} else {
				var width = wOriginal + (e.pageX - xMouseOriginal);
				if(_gthis.isSnapToGrid) {
					var gridValue = Math.round(width / _gthis.grid) * _gthis.grid;
					_gthis.el.style.width = "" + gridValue + "px";
				} else {
					_gthis.el.style.width = "" + width + "px";
				}
			}
		};
		var onMouseEnd = function(e) {
			_gthis.el.classList.remove("active");
			xCurrent = 0;
			yCurrent = 0;
			xInitial = 0;
			yInitial = 0;
			xOffset = 0;
			yOffset = 0;
			xOriginal = 0;
			_gthis.el.onmouseup = null;
			_gthis.el.onmousemove = null;
			_gthis.el.onmouseleave = null;
		};
		var onMouseDown = function(e) {
			_gthis.el.classList.add("active");
			if(e.type == "touchstart") {
				xInitial = e.touches[0].clientX - xOffset;
				yInitial = e.touches[0].clientY - yOffset;
			} else {
				xInitial = e.clientX - xOffset;
				yInitial = e.clientY - yOffset;
			}
			wOriginal = Std.parseInt(StringTools.replace(window.getComputedStyle(_gthis.el,null).getPropertyValue("width"),"px",""));
			hOriginal = Std.parseInt(StringTools.replace(window.getComputedStyle(_gthis.el,null).getPropertyValue("height"),"px",""));
			xOriginal = _gthis.el.getBoundingClientRect().left | 0;
			yOriginal = _gthis.el.getBoundingClientRect().top | 0;
			xMouseOriginal = e.pageX;
			yMouseOriginal = e.pageY;
			_gthis.el.onmouseup = onMouseEnd;
			_gthis.el.onmousemove = onMouseMove;
			_gthis.el.onmouseleave = onMouseEnd;
		};
		this.el.ontouchstart = onMouseDown;
		this.el.onmousedown = onMouseDown;
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
kluez_El.create = function(text,x,y,width,height,obj) {
	if(height == null) {
		height = 50;
	}
	var div = window.document.createElement("div");
	div.innerHTML = "<span>" + text + "</span><!-- " + JSON.stringify(obj,null,"  ") + " -->";
	div.classList.add("klz-el");
	div.id = utils_UUID.uuid();
	div.style.left = "" + x + "px";
	div.style.top = "" + y + "px";
	div.style.width = "" + width + "px";
	div.style.height = "" + height + "px";
	div.style.position = "absolute";
	return div;
};
var utils_Convert = function() {
};
utils_Convert.__name__ = true;
utils_Convert.prototype = {
	gantt: function(str,isDebug) {
		if(isDebug == null) {
			isDebug = true;
		}
		var json = { };
		json["created_date"] = new Date();
		json["updated_date"] = new Date();
		json["title"] = "Test";
		json["excludes"] = "weekends";
		json["dateFormat"] = "YYYY-MM-DD";
		json["start_date"] = null;
		json["end_date"] = null;
		json["total"] = { };
		json["sections"] = [];
		var text = str;
		var lines = text.split("\n");
		var _sectionArr = [];
		var _mapBefore_h = Object.create(null);
		var _mapAfter_h = Object.create(null);
		var _sectionTitle = "";
		var _startDateStr = "";
		var _endDateStr = "";
		var _state = "";
		var _id = "";
		var _startDate = new Date();
		var _endDate = new Date();
		var _previousStartDate = new Date();
		var _previousEndDate = new Date();
		var _g = 0;
		var _g1 = lines.length;
		while(_g < _g1) {
			var i = _g++;
			var ganttObj = { };
			var line = StringTools.trim(lines[i]);
			if(line == "") {
				continue;
			}
			if(StringTools.startsWith(StringTools.trim(line),"%%")) {
				continue;
			}
			if(line.indexOf("section") != -1) {
				_sectionTitle = StringTools.trim(StringTools.trim(line).substring("section".length));
				var isDebug1 = isDebug;
			} else {
				var arrr = line.split(":");
				var _title = StringTools.trim(arrr[0]);
				var rest = StringTools.trim(arrr[1]);
				var restArr = rest.split(",");
				var oArr = [];
				if(isDebug) {
					if(isDebug) {
						if(isDebug) {
							if(isDebug) {
								oArr.push(StringTools.replace(StringTools.replace(line,"\t",""),"  "," "));
							}
						}
					}
				}
				oArr.push(_title);
				var _g2 = 0;
				var _g3 = restArr.length;
				while(_g2 < _g3) {
					var j = _g2++;
					var _restArr = StringTools.trim(restArr[j]);
					if(isDebug) {
						oArr.push(StringTools.trim(_restArr));
					}
				}
				ganttObj["_original"] = oArr;
				ganttObj["section"] = _sectionTitle;
				ganttObj["title"] = _title;
				ganttObj["after_id"] = "";
				ganttObj["start_date"] = DateTools.format(_previousEndDate,"%F");
				if(restArr.length >= 2) {
					_startDateStr = StringTools.trim(restArr[restArr.length - 2]);
					if(_startDateStr.split("-").length == 3) {
						var date = HxOverrides.strDate(_startDateStr);
						ganttObj["start_date"] = DateTools.format(date,"%F");
						if(isDebug) {
							_previousStartDate = date;
						}
						_startDate = date;
					}
					if(_startDateStr.length == 2) {
						var nr;
						var addTime = 0.0;
						if(_startDateStr.indexOf("h") != -1) {
							nr = Std.parseInt(StringTools.trim(StringTools.replace(_startDateStr,"h","")));
							addTime = nr * 60.0 * 60.0 * 1000.0;
						}
						if(_startDateStr.indexOf("d") != -1) {
							nr = Std.parseInt(StringTools.trim(StringTools.replace(_startDateStr,"d","")));
							addTime = nr * 24.0 * 60.0 * 60.0 * 1000.0;
						}
						if(_startDateStr.indexOf("w") != -1) {
							nr = Std.parseInt(StringTools.trim(StringTools.replace(_startDateStr,"w",""))) * 7 | 0;
							addTime = nr * 24.0 * 60.0 * 60.0 * 1000.0;
						}
						nr = Std.parseInt(StringTools.trim(StringTools.replace(_startDateStr,"d","")));
						addTime = nr * 24.0 * 60.0 * 60.0 * 1000.0;
						var date1 = new Date(_previousStartDate.getTime() + addTime);
						ganttObj["start_date"] = DateTools.format(date1,"%F");
						if(isDebug) {
							_previousStartDate = date1;
						}
						_startDate = date1;
					}
					if(_startDateStr.indexOf("after ") != -1) {
						var getID = StringTools.replace(_startDateStr,"after ","");
						var date2 = HxOverrides.strDate(_mapAfter_h[getID]);
						ganttObj["start_date"] = _mapAfter_h[getID];
						ganttObj["after_id"] = "" + getID;
						if(isDebug) {
							_previousStartDate = date2;
						}
						_startDate = date2;
					}
					if(Reflect.getProperty(json,"start_date") == null) {
						json["start_date"] = DateTools.format(_startDate,"%F");
					}
				}
				var _endDateStr = StringTools.trim(restArr[restArr.length - 1]);
				ganttObj["end_date"] = "";
				if(_endDateStr.indexOf("-") != -1 && _endDateStr.split("-").length == 3) {
					var date3 = HxOverrides.strDate(_endDateStr);
					ganttObj["end_date"] = DateTools.format(date3,"%F");
					if(isDebug) {
						_previousEndDate = date3;
					}
					_endDate = date3;
				}
				if(_endDateStr.indexOf("d") != -1 || _endDateStr.indexOf("w") != -1 || _endDateStr.indexOf("h") != -1) {
					var nr1 = Std.parseInt(StringTools.trim(StringTools.replace(_endDateStr,"d","")));
					var isDebug2 = isDebug;
					var date4 = new Date(_startDate.getTime() + nr1 * 24.0 * 60.0 * 60.0 * 1000.0);
					ganttObj["end_date"] = DateTools.format(date4,"%F");
					var isDebug3 = isDebug;
					_previousEndDate = date4;
					_endDate = date4;
				}
				if(_endDateStr.indexOf("after ") != -1) {
					var getID1 = StringTools.replace(_endDateStr,"after ","");
					var date5 = HxOverrides.strDate(_mapAfter_h[getID1]);
					ganttObj["end_date"] = _mapAfter_h[getID1];
					if(isDebug) {
						_previousEndDate = date5;
					}
					_endDate = date5;
				}
				json["end_date"] = DateTools.format(_endDate,"%F");
				ganttObj["id"] = "";
				if(restArr.length >= 3) {
					var _id = StringTools.trim(restArr[restArr.length - 3]);
					if(isDebug) {
						ganttObj["id"] = _id;
					}
					_mapAfter_h[_id] = DateTools.format(_previousEndDate,"%F");
					_mapBefore_h[_id] = DateTools.format(_previousStartDate,"%F");
				}
				if(isDebug) {
					haxe_Log.trace("start: " + Std.string(_startDate),{ fileName : "src/utils/Convert.hx", lineNumber : 248, className : "utils.Convert", methodName : "gantt"});
				}
				if(isDebug) {
					haxe_Log.trace("end: " + Std.string(_endDate),{ fileName : "src/utils/Convert.hx", lineNumber : 250, className : "utils.Convert", methodName : "gantt"});
				}
				var milliseconds = _endDate.getTime() - _startDate.getTime();
				var seconds = Math.floor(milliseconds / 1000);
				var minutes = Math.floor(seconds / 60);
				var hours = Math.floor(minutes / 60);
				var days = Math.floor(hours / 24);
				var weeks = Math.floor(days / 7);
				var years = Math.floor(weeks / 52);
				var months = Math.floor(years / 12);
				ganttObj["state"] = "";
				if(restArr.length >= 4) {
					var _state = StringTools.trim(restArr[restArr.length - 4]);
					if(isDebug) {
						ganttObj["state"] = _state;
					}
				}
				var dayArr = ["zo","ma","di","wo","do","vr","za"];
				var monthArr = ["jan","feb","mrt","apr","mei","jun","jul","aug","sep","okt","nov","dec"];
				ganttObj["date"] = { "start" : { "date" : _startDate, "day" : _startDate.getDay(), "month" : _startDate.getMonth(), "year" : _startDate.getFullYear(), "day_str" : dayArr[_startDate.getDay()], "month_str" : monthArr[_startDate.getMonth()]}, "end" : { "date" : _endDate, "day" : _endDate.getDay(), "month" : _endDate.getMonth(), "year" : _endDate.getFullYear(), "day_str" : dayArr[_endDate.getDay()], "month_str" : monthArr[_endDate.getMonth()]}};
				ganttObj["total"] = { years : years, months : months, weeks : weeks, days : days, hours : hours, minutes : minutes, seconds : seconds, milliseconds : milliseconds};
				_sectionArr.push(ganttObj);
			}
		}
		var tempStart = Reflect.getProperty(json,"start_date");
		var tempEnd = Reflect.getProperty(json,"end_date");
		json["total"] = utils_DateUtil.convert(HxOverrides.strDate(tempStart),HxOverrides.strDate(tempEnd));
		json["sections"] = _sectionArr;
		var isDebug1 = isDebug;
		return json;
	}
};
var utils_DateUtil = function() { };
utils_DateUtil.__name__ = true;
utils_DateUtil.convert = function(startDate,endDate) {
	var milliseconds = Math.round(endDate.getTime() - startDate.getTime());
	var seconds = Math.floor(milliseconds / 1000);
	var minutes = Math.floor(seconds / 60);
	var hours = Math.floor(minutes / 60);
	var days = Math.floor(hours / 24);
	var weeks = Math.floor(days / 7);
	var years = Math.floor(weeks / 52);
	var months = Math.floor(years / 12);
	return { years : years, months : months, weeks : weeks, days : days, hours : hours, minutes : minutes, seconds : seconds, milliseconds : milliseconds};
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
if(typeof(performance) != "undefined" ? typeof(performance.now) == "function" : false) {
	HxOverrides.now = performance.now.bind(performance);
}
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = "Date";
js_Boot.__toStr = ({ }).toString;
DateTools.DAY_SHORT_NAMES = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
DateTools.DAY_NAMES = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
DateTools.MONTH_SHORT_NAMES = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
DateTools.MONTH_NAMES = ["January","February","March","April","May","June","July","August","September","October","November","December"];
const_ClassNames.DRAGGABLE = "draggable";
const_ClassNames.RESIZEABLE = "resizeable";
const_Gantt.TEST_2 = "\n  section Duidelijk 5 day vs 7 days\n     Maandag tot vrijdag            :2022-07-11,2022-07-15\n     Maandag + 5 dagen            :2022-07-11, 5d\n     Maandag + 7 dagen            :2022-07-11, 7d\n     Vrijdag tot dinsdag         :2022-07-15,2022-07-19\n     Vrijdag + 5        :2022-07-15,5d\n     Vrijdag + 10        :2022-07-15,10d\n\n";
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
MainKluez.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=kluez.js.map