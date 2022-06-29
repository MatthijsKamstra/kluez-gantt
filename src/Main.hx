package;

import haxe.Log;
import js.html.DivElement;
import js.html.MouseEvent;
import js.html.Event;
import js.Browser.*;

class Main {
	public function new() {
		trace('Main');
		// Make the DIV element draggable:
		// dragElement(cast document.getElementById("resizeMe"));
		initDrag(cast document.getElementById("resizeMe"));
	}

	function initDrag(el:DivElement) {
		var active = false;
		var currentX:Int = 0;
		var currentY:Int = 0;
		var initialX:Int = 0;
		var initialY:Int = 0;
		var xOffset:Int = 0;
		var yOffset:Int = 0;

		function dragStart(e) {
			trace('dragstart');
			trace(e);

			if (e.type == "touchstart") {
				initialX = e.touches[0].clientX - xOffset;
				initialY = e.touches[0].clientY - yOffset;
			} else {
				initialX = e.clientX - xOffset;
				initialY = e.clientY - yOffset;
			}

			if (e.target == el) {
				active = true;
				trace(active);
			}
		}

		function dragEnd(e) {
			trace('dragend');
			initialX = currentX;
			initialY = currentY;

			active = false;
		}

		function setTranslate(xPos, yPos, el) {
			el.style.transform = 'translate3d(${Std.string(xPos)}px, 0px, 0)';
			// el.style.transform = 'translate3d(${Std.string(xPos)}px, ${Std.string(yPos)}px, 0)';
		}

		function drag(e) {
			if (active) {
				e.preventDefault();

				if (e.type == "touchmove") {
					currentX = e.touches[0].clientX - initialX;
					currentY = e.touches[0].clientY - initialY;
				} else {
					currentX = e.clientX - initialX;
					currentY = e.clientY - initialY;
				}

				xOffset = currentX;
				yOffset = currentY;

				setTranslate(currentX, currentY, e.target);
			}
		}

		el.addEventListener("touchstart", dragStart, false);
		el.addEventListener("touchend", dragEnd, false);
		el.addEventListener("touchmove", drag, false);

		el.addEventListener("mousedown", dragStart, false);
		el.addEventListener("mouseup", dragEnd, false);
		el.addEventListener("mousemove", drag, false);
	}

	function dragElement(elmnt:DivElement) {
		var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;

		function elementDrag(e:MouseEvent) {
			// e = e || window.event;
			e.preventDefault();
			// calculate the new cursor position:
			pos1 = pos3 - e.clientX;
			pos2 = pos4 - e.clientY;
			pos3 = e.clientX;
			pos4 = e.clientY;
			// set the element's new position:
			elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
			elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
		}

		function closeDragElement() {
			// stop moving when mouse button is released:
			document.onmouseup = null;
			document.onmousemove = null;
		}

		function dragMouseDown(e:MouseEvent) {
			// e = e || window.event;
			e.preventDefault();
			// get the mouse cursor position at startup:
			pos3 = e.clientX;
			pos4 = e.clientY;
			document.onmouseup = closeDragElement;
			// call a function whenever the cursor moves:
			document.onmousemove = elementDrag;
		}

		// if (document.getElementById(elmnt.id + "header")) {
		// 	// if present, the header is where you move the DIV from:
		// 	document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
		// } else {
		// 	// otherwise, move the DIV from anywhere inside the DIV:
		// 	elmnt.onmousedown = dragMouseDown;
		// }
		elmnt.onmousedown = dragMouseDown;
	}

	static public function main() {
		var app = new Main();
	}
}
