package kluez;

import utils.MathUtil;
import const.Colors;
import js.html.Element;
import utils.UUID;
import js.html.DivElement;
import hxColorToolkit.spaces.HSL;
import js.Browser.*;

using hxColorToolkit.ColorToolkit;
using StringTools;

class DragElement {
	public function new(element:Element) {
		createElements(element);
	}

	function createElements(element) {
		var i = 0;
		for (color in Colors.colorMap.keys()) {
			var hex = Colors.colorMap[color];
			var e = El.create(element, hex, MathUtil.randomInteger(10, 300), (i * 60) + 10, MathUtil.randomInteger(50, 500));
			e.classList.add('klz-el-${color}', 'draggable');
			i++;
			init(cast e);
		}
		element.style.height = '${(60 * i) + 10}px';
	}

	function init(el:DivElement) {
		var xCurrent:Int = 0;
		var yCurrent:Int = 0;
		var xInitial:Int = 0;
		var yInitial:Int = 0;
		var xOffset:Int = 0;
		var yOffset:Int = 0;

		function setTranslate(el, xPos, yPos) {
			el.style.transform = 'translate3d(${Std.string(xPos)}px, 0px, 0)';
			// el.style.transform = 'translate3d(${Std.string(xPos)}px, ${Std.string(yPos)}px, 0)';
		}

		function onMouseMove(e) {
			// trace('onMouseMove');
			// trace(e);

			// e.preventDefault();

			var el = e.target;

			if (e.type == "touchmove") {
				xCurrent = e.touches[0].clientX - xInitial;
				yCurrent = e.touches[0].clientY - yInitial;
			} else {
				xCurrent = e.clientX - xInitial;
				yCurrent = e.clientY - yInitial;
			}

			xOffset = xCurrent;
			yOffset = yCurrent;

			setTranslate(el, xCurrent, yCurrent);
		}

		function onMouseEnd(e) {
			// trace('onMouseEnd');
			var el = e.target;

			xInitial = xCurrent;
			yInitial = yCurrent;

			el.classList.remove('active');

			// xOffset = 0;
			// yOffset = 0;

			el.onmouseup = null;
			el.onmousemove = null;
			el.onmouseleave = null;
		}

		function onMouseDown(e) {
			// trace('onMouseDown');
			// trace(e);

			var el:DivElement = e.target;
			el.classList.add('active');

			if (e.type == "touchstart") {
				xInitial = e.touches[0].clientX - xOffset;
				yInitial = e.touches[0].clientY - yOffset;
			} else {
				xInitial = e.clientX - xOffset;
				yInitial = e.clientY - yOffset;
			}

			el.onmouseup = onMouseEnd;
			el.onmousemove = onMouseMove;
			el.onmouseleave = onMouseEnd;
		}

		el.ontouchstart = onMouseDown;
		el.onmousedown = onMouseDown;
	}
}