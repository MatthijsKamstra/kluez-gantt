package;

import js.Browser.*;
import js.Browser;
import js.html.*;

// import js.html.window.*;
using StringTools;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	public function new() {
		trace("Hello 'Example JS Gitlab'");
		makeResizableDiv('.resizable');
	}

	/*Make resizable div by Hung Nguyen*/
	function makeResizableDiv(div) {
		var element = document.querySelector(div);
		var resizers = document.querySelectorAll(div + ' .resizer');
		var minimum_size = 20;
		var original_width = 0;
		var original_height = 0;
		var original_x = 0;
		var original_y = 0;
		var original_mouse_x = 0;
		var original_mouse_y = 0;
		for (i in 0...resizers.length) {
			var currentResizer:DivElement = cast resizers[i];
			function resize(e) {
				if (currentResizer.classList.contains('bottom-right')) {
					var width = original_width + (e.pageX - original_mouse_x);
					var height = original_height + (e.pageY - original_mouse_y);
					if (width > minimum_size) {
						element.style.width = width + 'px';
					}
					if (height > minimum_size) {
						element.style.height = height + 'px';
					}
				} else if (currentResizer.classList.contains('bottom-left')) {
					var height = original_height + (e.pageY - original_mouse_y);
					var width = original_width - (e.pageX - original_mouse_x);
					if (height > minimum_size) {
						element.style.height = height + 'px';
					}
					if (width > minimum_size) {
						element.style.width = width + 'px';
						element.style.left = original_x + (e.pageX - original_mouse_x) + 'px';
					}
				} else if (currentResizer.classList.contains('top-right')) {
					var width = original_width + (e.pageX - original_mouse_x);
					var height = original_height - (e.pageY - original_mouse_y);
					if (width > minimum_size) {
						element.style.width = width + 'px';
					}
					if (height > minimum_size) {
						element.style.height = height + 'px';
						element.style.top = original_y + (e.pageY - original_mouse_y) + 'px';
					}
				} else {
					var width = original_width - (e.pageX - original_mouse_x);
					var height = original_height - (e.pageY - original_mouse_y);
					if (width > minimum_size) {
						element.style.width = width + 'px';
						element.style.left = original_x + (e.pageX - original_mouse_x) + 'px';
					}
					if (height > minimum_size) {
						element.style.height = height + 'px';
						element.style.top = original_y + (e.pageY - original_mouse_y) + 'px';
					}
				}
			}

			function stopResize() {
				window.removeEventListener('mousemove', resize);
			}

			currentResizer.addEventListener('mousedown', function(e) {
				e.preventDefault();
				original_width = Std.parseInt(window.getComputedStyle(element, null).getPropertyValue('width').replace('px', ''));
				original_height = Std.parseInt(window.getComputedStyle(element, null).getPropertyValue('height').replace('px', ''));
				original_x = Std.int(element.getBoundingClientRect().left);
				original_y = Std.int(element.getBoundingClientRect().top);
				original_mouse_x = e.pageX;
				original_mouse_y = e.pageY;
				window.addEventListener('mousemove', resize);
				window.addEventListener('mouseup', stopResize);
			});
		}
	}

	static public function main() {
		var app = new Main();
	}
}
