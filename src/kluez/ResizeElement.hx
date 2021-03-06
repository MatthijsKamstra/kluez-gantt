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

class ResizeElement {
	public function new(container:Element) {
		var arr = container.getElementsByClassName('resizeable');
		for (i in 0...arr.length) {
			var _arr = arr[i];
			// trace(_arr);
			init(cast _arr);
		}
	}

	function init(el:DivElement) {
		var xCurrent:Int = 0;
		var yCurrent:Int = 0;
		var xInitial:Int = 0;
		var yInitial:Int = 0;
		var xOffset:Int = 0;
		var yOffset:Int = 0;
		//
		var xOriginal:Int = 0;
		var yOriginal:Int = 0;
		var wOriginal:Int = 0;
		var hOriginal:Int = 0;
		var xMouseOriginal:Int = 0;
		var yMouseOriginal:Int = 0;

		// function setTranslate(el, xPos, yPos) {
		// 	el.style.transform = 'translate3d(${Std.string(xPos)}px, 0px, 0)';
		// 	// el.style.transform = 'translate3d(${Std.string(xPos)}px, ${Std.string(yPos)}px, 0)';
		// }

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

			// trace(xOffset);

			var width = wOriginal + (e.pageX - xMouseOriginal);
			// trace(width);

			el.style.width = '${width}px';

			// setTranslate(el, xCurrent, yCurrent);
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

			wOriginal = Std.parseInt(window.getComputedStyle(el, null).getPropertyValue('width').replace('px', ''));
			hOriginal = Std.parseInt(window.getComputedStyle(el, null).getPropertyValue('height').replace('px', ''));
			xOriginal = Std.int(el.getBoundingClientRect().left);
			yOriginal = Std.int(el.getBoundingClientRect().top);
			xMouseOriginal = e.pageX;
			yMouseOriginal = e.pageY;

			// trace('w:$wOriginal, h:$hOriginal, x:$xOriginal, y:$yOriginal, xm:$xMouseOriginal, ym:$yMouseOriginal');

			el.onmouseup = onMouseEnd;
			el.onmousemove = onMouseMove;
			el.onmouseleave = onMouseEnd;
		}

		el.ontouchstart = onMouseDown;
		el.onmousedown = onMouseDown;
	}
}
