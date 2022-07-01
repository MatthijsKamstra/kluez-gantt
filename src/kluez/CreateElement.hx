package kluez;

import js.html.Element;
import utils.UUID;
import js.html.DivElement;
import hxColorToolkit.spaces.HSL;
import js.Browser.*;

using hxColorToolkit.ColorToolkit;
using StringTools;

class CreateElement {
	public function new(el:Element) {
		// Make the DIV element draggable:
		init(cast el);
	}

	function init(el:DivElement) {
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
				xCurrent = e.touches[0].clientX - xInitial;
				yCurrent = e.touches[0].clientY - yInitial;
			} else {
				xCurrent = e.clientX - xInitial;
				yCurrent = e.clientY - yInitial;
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

			el.onmouseup = null;
			el.onmousemove = null;
			el.onmouseleave = null;
		}

		function onMouseDown(e) {
			// trace('onMouseDown');
			// trace(e);

			if (e.type == "touchstart") {
				xInitial = e.touches[0].clientX - xOffset;
				yInitial = e.touches[0].clientY - yOffset;
			} else {
				xInitial = e.clientX - xOffset;
				yInitial = e.clientY - yOffset;
			}

			// trace(xInitial, yInitial);

			// div
			div = document.createDivElement();
			// div.innerText = ('...');
			div.classList.add('klz-dotted');
			div.id = UUID.uuid();
			div.style.left = '${xInitial}px';
			div.style.top = '${yInitial}px';
			// div.style.width = '50px';
			div.style.height = '50px';
			div.style.position = 'absolute';
			document.body.append(div);
			// el.append(div);

			// mouse
			el.onmouseup = onMouseEnd;
			el.onmousemove = onMouseMove;
			el.onmouseleave = onMouseEnd;
		}

		el.ontouchstart = onMouseDown;
		el.onmousedown = onMouseDown;
	}
}
