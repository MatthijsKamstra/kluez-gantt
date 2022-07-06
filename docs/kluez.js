(function ($global) { "use strict";
var MainKluez = function() {
	console.log("src/MainKluez.hx:24:","MainKluez");
	this.createTable(100,1000);
};
MainKluez.main = function() {
	var app = new MainKluez();
};
MainKluez.prototype = {
	createTable: function(xTotal,yTotal) {
		var table0 = window.document.getElementById("container-gantt-kluez").getElementsByClassName("pattern")[0];
		var colGroup = "";
		var row = "";
		var _g = 0;
		var _g1 = yTotal;
		while(_g < _g1) {
			var y = _g++;
			colGroup = "<colgroup>";
			row += "<tr>";
			var _g2 = 0;
			var _g3 = xTotal;
			while(_g2 < _g3) {
				var x = _g2++;
				colGroup += "<col>";
				row += "<td><span class=\"table-cell\"></span></td>";
			}
			colGroup += "<colgroup>";
			row += "</tr>";
		}
		var t = "<table class=\"table-kluez\">\n" + colGroup + "\n" + row + "</table>";
		var frag = window.document.createRange().createContextualFragment(t);
		table0.appendChild(frag);
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
MainKluez.main();
})({});

//# sourceMappingURL=kluez.js.map