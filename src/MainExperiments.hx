package;

import kluez.ConnectEl;
import kluez.KlzGrid;
import kluez.CreateTable;
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

class MainExperiments {
	public function new() {
		console.info('Kluez');
		DynamicStyle.setStyle();

		var json = new Convert().gantt(const.Gantt.TEST_1);
		// console.log(haxe.Json.stringify(json, '  '));

		// create container setup
		new CreateElement(document.getElementById("kluez-create-container"));

		// create container setup
		// // Make the DIV element draggable:
		new ResizeElement(document.getElementById("kluez-resize-container"));

		// setup resize container with elements
		setupResize(document.getElementById("kluez-drag-container"));

		// setup combi container with elements
		setupCombi(document.getElementById('kluez-combi-container'));

		// setup combi container with elements
		new CreateTable(cast document.getElementById('kluez-table-container'));
		setupCombi(document.getElementById('overstufff'));

		// new KlzGrid(cast document.getElementById('kluez-grid-container'));

		// kluez-connect-container
		var aa = cast document.getElementById('aa');
		var bb = cast document.getElementById('bb');
		var cc = cast document.getElementById('cc');
		new ConnectEl(aa, bb);
		new ConnectEl(bb, cc);
	}

	/**
	 *
	 */
	function setupResize(container:Element) {
		var i = 0;

		var gridH = 64; // 16 32 64
		var gridP = 8;

		for (color in Colors.colorMap.keys()) {
			var hex = Colors.colorMap[color];
			var el = El.create('resize-$hex', MathUtil.randomInteger(10, 300), (i * (gridH + gridP)) + Math.round(gridP / 2), MathUtil.randomInteger(50, 500),
				gridH);
			el.classList.add('klz-el-${color}', 'draggable');
			container.append(el);
			i++;
			// DragElement.init(cast el);
			var dragEl = new DragElement(el);
			dragEl.grid = gridH;
			dragEl.padding = gridP;
			dragEl.isSnapToGrid = true;
			dragEl.init();
		}
		container.style.height = '${((gridH + gridP) * i) + Math.round(gridP / 2)}px';
	}

	function setupCombi(container:Element) {
		var i = 0;

		var gridH = 50; // 16 32 64
		var gridP = 10;

		for (color in Colors.colorMap.keys()) {
			var hex = Colors.colorMap[color];
			var el = El.create('combi-$hex', MathUtil.randomInteger(10, 300), (i * (gridH + gridP)) + Math.round(gridP / 2), MathUtil.randomInteger(50, 500),
				gridH);
			el.classList.add('klz-el-${color}', ClassNames.DRAGGABLE, ClassNames.RESIZEABLE);
			container.append(el);
			i++;
			var combiEl = new CombiElement(el);
			combiEl.grid = gridH;
			combiEl.padding = gridP;
			combiEl.isSnapToGrid = true;
			combiEl.init();
		}
		container.style.height = '${((gridH + gridP) * i) + Math.round(gridP / 2)}px';
	}

	static public function main() {
		var app = new MainExperiments();
	}
}
