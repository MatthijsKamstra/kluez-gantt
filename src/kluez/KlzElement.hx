package kluez;

import utils.UUID;
import js.html.DivElement;
import hxColorToolkit.spaces.HSL;
import js.Browser.*;

using hxColorToolkit.ColorToolkit;
using StringTools;

class KlzElement {
	public function new() {
		// Make the DIV element draggable:
		init(cast document.getElementById("canvas"));
	}

	function init(el:DivElement) {
		var currentX:Int = 0;
		var currentY:Int = 0;
		var initialX:Int = 0;
		var initialY:Int = 0;
		var xOffset:Int = 0;
		var yOffset:Int = 0;

		var div:DivElement = document.createDivElement();

		function onMouseMove(e) {
			// trace('onMouseMove');
			// trace(e);

			if (e.type == "touchmove") {
				currentX = e.touches[0].clientX - initialX;
				currentY = e.touches[0].clientY - initialY;
			} else {
				currentX = e.clientX - initialX;
				currentY = e.clientY - initialY;
			}

			xOffset = currentX;
			yOffset = currentY;

			div.style.width = '${xOffset}px';
			// div.style.height = '${yOffset}px';
		}

		function onMouseUp(e) {
			// trace('onMouseUp');

			initialX = currentX;
			initialY = currentY;

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
				initialX = e.touches[0].clientX - xOffset;
				initialY = e.touches[0].clientY - yOffset;
			} else {
				initialX = e.clientX - xOffset;
				initialY = e.clientY - yOffset;
			}

			// trace(initialX, initialY);

			// div
			div = document.createDivElement();
			// div.innerText = ('...');
			div.classList.add('klz-dotted');
			div.id = UUID.uuid();
			div.style.left = '${initialX}px';
			div.style.top = '${initialY}px';
			// div.style.width = '50px';
			div.style.height = '50px';
			div.style.position = 'absolute';
			document.body.append(div);
			// el.append(div);

			// mouse
			el.onmouseup = onMouseUp;
			el.onmousemove = onMouseMove;
			el.onmouseleave = onMouseUp;
		}

		el.ontouchstart = onMouseDown;
		el.onmousedown = onMouseDown;
	}
}
