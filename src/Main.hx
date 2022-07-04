package;

import utils.Convert;
import kluez.CombiElement;
import const.ClassNames;
import utils.MathUtil;
import kluez.El;
import const.Colors;
import js.html.Element;
import kluez.ResizeElement;
import kluez.DragElement;
import kluez.CreateElement;
import kluez.DynamicStyle;
import js.html.DivElement;
import js.Browser.*;

using hxColorToolkit.ColorToolkit;
using StringTools;

class Main {
	public function new() {
		console.info('Kluez');
		DynamicStyle.setStyle();

		var json = new Convert().gantt(const.Gantt.TEST_1);
		console.log(haxe.Json.stringify(json, '  '));

		// create container setup
		new CreateElement(document.getElementById("kluez-create-container"));

		// create container setup
		// // Make the DIV element draggable:
		new ResizeElement(document.getElementById("kluez-resize-container"));

		// setup resize container with elements
		setupResize(document.getElementById("kluez-drag-container"));

		// setup combi container with elements
		setupCombi(document.getElementById('kluez-combi-container'));
	}

	/**
	 *
	 */
	function setupResize(container:Element) {
		var i = 0;
		for (color in Colors.colorMap.keys()) {
			var hex = Colors.colorMap[color];
			var el = El.create('resize-$hex', MathUtil.randomInteger(10, 300), (i * 60) + 10, MathUtil.randomInteger(50, 500));
			el.classList.add('klz-el-${color}', 'draggable');
			container.append(el);
			i++;
			DragElement.init(cast el);
		}
		container.style.height = '${(60 * i) + 10}px';
	}

	function setupCombi(container:Element) {
		var i = 0;
		for (color in Colors.colorMap.keys()) {
			var hex = Colors.colorMap[color];
			var el = El.create('combi-$hex', MathUtil.randomInteger(10, 300), (i * 60) + 10, MathUtil.randomInteger(50, 500));
			el.classList.add('klz-el-${color}', ClassNames.DRAGGABLE, ClassNames.RESIZEABLE);
			container.append(el);
			i++;
			CombiElement.init(el);
		}
		container.style.height = '${(60 * i) + 10}px';
	}

	static public function main() {
		var app = new Main();
	}
}
