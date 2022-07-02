package kluez;

import js.html.Element;
import utils.UUID;
import js.html.DivElement;
import hxColorToolkit.spaces.HSL;
import js.Browser.*;

using hxColorToolkit.ColorToolkit;
using StringTools;

class CreateElement {
	public function new(container:Element) {
		// Make the DIV element draggable:
		init(cast container);
	}

	function init(container:DivElement) {
		var xCurrent:Int = 0;
		var yCurrent:Int = 0;
		var xInitial:Int = 0;
		var yInitial:Int = 0;
		var xOffset:Int = 0;
		var yOffset:Int = 0;

		var div:DivElement = document.createDivElement();

		function onMouseMove(e) {
			// trace('onMouseMove');
			// trace(e);

			if (e.type == "touchmove") {
				xCurrent = e.touches[0].pageX - xInitial;
				yCurrent = e.touches[0].pageY - yInitial;
			} else {
				xCurrent = e.pageX - xInitial;
				yCurrent = e.pageY - yInitial;
			}

			xOffset = xCurrent;
			yOffset = yCurrent;

			div.style.width = '${xOffset}px';
			// div.style.height = '${yOffset}px';
		}

		function onMouseEnd(e) {
			// trace('onMouseEnd');

			xInitial = xCurrent;
			yInitial = yCurrent;

			div.className = 'klz-el';
			div.style.height = '50px';
			div.innerText = '...';

			xOffset = 0;
			yOffset = 0;

			container.onmouseup = null;
			container.onmousemove = null;
			container.onmouseleave = null;
		}

		function onMouseDown(e) {
			// trace('onMouseDown');
			// trace(e);

			if (e.type == "touchstart") {
				xInitial = e.touches[0].pageX - xOffset;
				yInitial = e.touches[0].pageY - yOffset;
			} else {
				xInitial = e.pageX - xOffset;
				yInitial = e.pageY - yOffset;
			}

			// trace(xInitial, yInitial);

			// div
			div = El.create('...', xInitial, yInitial, 10);
			div.classList.add('klz-dotted');
			document.body.append(div);

			// mouse
			container.onmouseup = onMouseEnd;
			container.onmousemove = onMouseMove;
			container.onmouseleave = onMouseEnd;
		}

		container.ontouchstart = onMouseDown;
		container.onmousedown = onMouseDown;
	}
}
