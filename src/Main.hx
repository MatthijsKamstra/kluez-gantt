package;

import kluez.KlzElement;
import kluez.DynamicStyle;
import js.html.DivElement;
import js.Browser.*;

using hxColorToolkit.ColorToolkit;
using StringTools;

class Main {
	public function new() {
		trace('Main');
		DynamicStyle.setStyle();

		var temp = new KlzElement();

		// // Make the DIV element draggable:
		// initDrag(cast document.getElementById("resizeMe"));
	}

	function initDrag(el:DivElement) {
		var currentX:Int = 0;
		var currentY:Int = 0;
		var initialX:Int = 0;
		var initialY:Int = 0;
		var xOffset:Int = 0;
		var yOffset:Int = 0;

		function setTranslate(el, xPos, yPos) {
			el.style.transform = 'translate3d(${Std.string(xPos)}px, 0px, 0)';
			// el.style.transform = 'translate3d(${Std.string(xPos)}px, ${Std.string(yPos)}px, 0)';
		}

		function dragMove(e) {
			// trace('dragMove');
			// trace(e);

			e.preventDefault();

			var el = e.target;

			if (e.type == "touchmove") {
				currentX = e.touches[0].clientX - initialX;
				currentY = e.touches[0].clientY - initialY;
			} else {
				currentX = e.clientX - initialX;
				currentY = e.clientY - initialY;
			}

			xOffset = currentX;
			yOffset = currentY;

			setTranslate(el, currentX, currentY);
		}

		function dragEnd(e) {
			// trace('dragEnd');
			var el = e.target;

			initialX = currentX;
			initialY = currentY;

			el.onmouseup = null;
			el.onmousemove = null;
			el.onmouseleave = null;
		}

		function dragStart(e) {
			// trace('dragStart');
			// trace(e);

			var el:DivElement = e.target;

			if (e.type == "touchstart") {
				initialX = e.touches[0].clientX - xOffset;
				initialY = e.touches[0].clientY - yOffset;
			} else {
				initialX = e.clientX - xOffset;
				initialY = e.clientY - yOffset;
			}

			el.onmouseup = dragEnd;
			el.onmousemove = dragMove;
			el.onmouseleave = dragEnd;
		}

		el.ontouchstart = dragStart;
		el.onmousedown = dragStart;
	}

	static public function main() {
		var app = new Main();
	}
}
