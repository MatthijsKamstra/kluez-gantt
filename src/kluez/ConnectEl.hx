package kluez;

import js.html.DivElement;
import js.html.Document;
import js.html.Element;
import js.Browser.*;

class ConnectEl {
	public static var COUNTER = 0;

	public function new(el1:Element, el2:Element) {
		var div1:DivElement = cast el1;
		var div2:DivElement = cast el2;

		var svg = '<svg data-id="gen" id="svg_${COUNTER}" style="position: absolute;top: 0;left: 0;"><line id="line_${COUNTER}" stroke="black" /></svg>';
		var frag = document.createRange().createContextualFragment(svg);
		var line = div2.parentElement.appendChild(cast frag);

		var line = document.getElementById('line_${COUNTER}');

		var x1 = div1.offsetLeft + (div1.offsetWidth / 2);
		var y1 = div1.offsetTop + (div1.offsetHeight / 2);
		var x2 = div2.offsetLeft + (div2.offsetWidth / 2);
		var y2 = div2.offsetTop + (div2.offsetHeight / 2);

		trace(div1);
		trace('div1.offsetLeft: ' + div1.offsetLeft);
		trace('div1.offsetTop: ' + div1.offsetTop);
		trace('x1: ' + x1);
		trace('y1: ' + y1);
		trace(div2);
		trace('div2.offsetLeft: ' + div2.offsetLeft);
		trace('div2.offsetTop: ' + div2.offsetTop);
		trace('x2: ' + x2);
		trace('y2: ' + y2);

		line.setAttribute("x1", '$x1');
		line.setAttribute("y1", '$y1');
		line.setAttribute("x2", '$x2');
		line.setAttribute("y2", '$y2');

		COUNTER++;
	}
}
