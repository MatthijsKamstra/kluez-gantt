(function ($global) { "use strict";
var MainKluez = function() {
	console.log("src/MainKluez.hx:5:","MainKluez");
};
MainKluez.main = function() {
	var app = new MainKluez();
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