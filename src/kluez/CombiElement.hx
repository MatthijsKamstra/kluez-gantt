package kluez;

import const.ClassNames;
import js.Browser.*;
import js.html.Element;

using StringTools;
using hxColorToolkit.ColorToolkit;

class CombiElement {
	public var el:Element;
	public var grid:Int = 1;
	public var padding:Int;
	public var isSnapToGrid:Bool = false;

	public function new(el:Element) {
		this.el = el;
	}

	public function init() {
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
		//
		var isDrag = true; // or isResize

		if (el.classList.contains(ClassNames.RESIZEABLE)) {
			// TODO: needs to check if its already done
			var resizeEl = document.createDivElement();
			resizeEl.classList.add('resizer-r');
			el.appendChild(resizeEl);
			resizeEl.onmouseover = () -> {
				isDrag = false;
			};
			resizeEl.onmouseout = () -> {
				isDrag = true;
			};
		}

		// function setTranslate(el, xPos, yPos) {
		// 	el.style.transform = 'translate3d(${Std.string(xPos)}px, 0px, 0)';
		// 	// el.style.transform = 'translate3d(${Std.string(xPos)}px, ${Std.string(yPos)}px, 0)';
		// }

		function onMouseMove(e) {
			// trace('onMouseMove');
			// trace(e);

			// var el = e.target;

			if (e.type == "touchmove") {
				xCurrent = e.touches[0].clientX - xInitial;
				yCurrent = e.touches[0].clientY - yInitial;
			} else {
				xCurrent = e.clientX - xInitial;
				yCurrent = e.clientY - yInitial;
			}

			xOffset = xCurrent;
			yOffset = yCurrent;

			if (isDrag) {
				if (isSnapToGrid) {
					var gridValue = Math.round((xOriginal + xCurrent) / grid) * grid;
					el.style.left = '${gridValue}px';
				} else {
					el.style.left = '${(xOriginal + xCurrent)}px';
				}
			} else {
				var width = wOriginal + (e.pageX - xMouseOriginal);
				if (isSnapToGrid) {
					var gridValue = Math.round((width) / grid) * grid;
					el.style.width = '${gridValue}px';
				} else {
					el.style.width = '${width}px';
				}
			}
		}

		function onMouseEnd(e) {
			// trace('onMouseEnd');
			// var el = e.target;

			// xInitial = xCurrent;
			// yInitial = yCurrent;

			el.classList.remove('active');

			xCurrent = 0;
			yCurrent = 0;
			xInitial = 0;
			yInitial = 0;
			xOffset = 0;
			yOffset = 0;
			xOriginal = 0;

			el.onmouseup = null;
			el.onmousemove = null;
			el.onmouseleave = null;
		}

		function onMouseDown(e) {
			// trace('onMouseDown');
			// trace(e);

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
