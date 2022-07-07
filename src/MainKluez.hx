package;

import haxe.Log;
import utils.DateUtil;
import model.AST.GanttObj;
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

class MainKluez {
	public function new() {
		trace('MainKluez');
		DynamicStyle.setStyle();

		var wSize = 60; // 16 32 64
		var hSize = 60;
		var pSize = 10;

		var json:GanttObj = cast new Convert().gantt(const.Gantt.TEST_1);
		var obj = (DateUtil.convert(Date.fromString(json.start_date), Date.fromString(json.end_date)));
		console.log(haxe.Json.stringify(json, '  '));

		var container = document.getElementById('container-gantt-kluez').getElementsByClassName('gantt')[0];
		trace(container);

		// setupCombi(cast container, wSize, hSize, pSize);

		// var i = 0;
		////////////////
		for (i in 0...json.sections.length) {
			var section = json.sections[i];
			trace(section.title);

			var title = section.title;
			var startObj = (DateUtil.convert(Date.fromString(json.start_date), Date.fromString(section.start_date)));

			var xpos = (startObj.days * wSize);
			var ypos = (i * (hSize)) + Math.round(pSize / 2);
			var w = section.total.days * wSize;
			var h = hSize - pSize;
			var el = El.create(title, xpos, ypos, w, h);
			el.classList.add(ClassNames.DRAGGABLE, ClassNames.RESIZEABLE);
			container.append(el);

			var combiEl = new CombiElement(el);
			combiEl.grid = hSize;
			combiEl.padding = pSize;
			combiEl.isSnapToGrid = true;
			combiEl.init();
		}

		var xTotal = obj.days;
		var yTotal = (json.sections.length + 1);

		trace(xTotal);
		trace(yTotal);

		createTable(xTotal, yTotal, wSize, hSize);
	}

	public function setupCombi(container:Element, wSize, hSize, pSize) {
		var i = 0;

		var gridH = hSize - pSize;
		var gridP = pSize;

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
		// container.style.height = '${((gridH + gridP) * i) + Math.round(gridP / 2)}px';
	}

	/**

	**/
	public function createTable(xTotal, yTotal, wSize:Int, hSize:Int) {
		var table0 = cast document.getElementById('container-gantt-kluez').getElementsByClassName('pattern')[0];

		var colGroup = '';
		var row = '';

		for (y in 0...yTotal) {
			colGroup = '<colgroup>';
			row += '<tr style="height:${hSize}px;">';
			// your code
			for (x in 0...Math.round(xTotal * 1.5)) {
				colGroup += '<col>';
				row += '<td><span class="table-cell" style="width:${wSize}px;"></span></td>';
			}
			colGroup += '<colgroup>';
			row += '</tr>';
		}
		var t = '<table class="table-kluez">\n${colGroup}\n${row}</table>';

		var frag = document.createRange().createContextualFragment(t);
		table0.appendChild(frag);
	}

	static public function main() {
		var app = new MainKluez();
	}
}
