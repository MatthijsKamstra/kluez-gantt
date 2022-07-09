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

		var json:GanttObj = cast new Convert().gantt(const.Gantt.TEST_2);
		var obj = (DateUtil.convert(Date.fromString(json.start_date), Date.fromString(json.end_date)));
		console.log(json);
		console.log(haxe.Json.stringify(json, '  '));

		createDate(json, wSize, hSize);

		var container = document.getElementById('container-gantt-kluez').getElementsByClassName('gantt')[0];
		trace(container);

		// setupCombi(cast container, wSize, hSize, pSize);

		// var i = 0;
		// //////////////
		for (i in 0...json.sections.length) {
			var section = json.sections[i];
			trace(section.title);

			var title = section.title;
			var startObj = (DateUtil.convert(Date.fromString(json.start_date), Date.fromString(section.start_date)));

			var xpos = (startObj.days * wSize);
			var ypos = (i * (hSize)) + Math.round(pSize / 2);
			var w = section.total.days * wSize;
			var h = hSize - pSize;
			var el = El.create(title, xpos, ypos, w, h, section);
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

	function createDate(json:GanttObj, wSize:Int, hSize:Int) {
		var obj = (DateUtil.convert(Date.fromString(json.start_date), Date.fromString(json.end_date)));

		var sdate:Date = Date.fromString(json.start_date);

		var container = document.getElementById('container-date');
		trace(container);

		var _xTotal = Math.round(obj.days * 1.5);
		var _yTotal = Math.round(3);

		var row = '';
		var dateRow = '';
		var dayRow = '';
		var weekRow = '';
		var monthRow = '';

		var i = 0;
		var dayArr = ['zo', 'ma', 'di', 'wo', 'do', 'vr', 'za'];

		var jan1 = new Date(sdate.getFullYear(), 0, 1, 0, 0, 0);
		trace(jan1, jan1.getDay(), dayArr[jan1.getDay()]);

		dayRow += '<div class="klz-row klz-row-day" style="width: ${wSize * _xTotal}px">';
		dateRow += '<div class="klz-row klz-row-date" style="width: ${wSize * _xTotal}px">';
		for (x in 0..._xTotal) {
			var date = Date.fromTime(sdate.getTime() + DateTools.days(1 * x));
			if (date.getDay() != 0 && date.getDay() != 6) {
				dayRow += '<div class="klz-item klz-day klz-day-${dayArr[date.getDay()]}">${dayArr[date.getDay()]}<!-- x:${x} --></div>';
				dateRow += '<div class="klz-item klz-date klz-day-${dayArr[date.getDay()]}">${date.getDate()}<!-- x:${x} --></div>';
			}
			// trace(dayArr[date.getDay()]);
		}
		dayRow += '</div>';
		dateRow += '</div>';

		var t = '<div class="container-kluez-table">${dayRow}${dateRow}</div>';

		var frag = document.createRange().createContextualFragment(t);
		container.appendChild(frag);
	}

	/**

	**/
	public function createTable(xTotal, yTotal, wSize:Int, hSize:Int) {
		var container = cast document.getElementById('container-gantt-kluez').getElementsByClassName('pattern')[0];

		var row = '';
		var _xTotal = Math.round(xTotal * 1.5);
		var _yTotal = Math.round(yTotal * 1);

		for (y in 0..._yTotal) {
			row += '<div class="klz-row" style="width: ${wSize * _xTotal}px">';

			for (x in 0..._xTotal) {
				row += '<div class="klz-item"><!-- x:${x}, y:${y} --></div>';
			}
			row += '</div>';
		}
		var t = '<div class="container-kluez-table">${row}</div>';

		var frag = document.createRange().createContextualFragment(t);
		container.appendChild(frag);
	}

	static public function main() {
		var app = new MainKluez();
	}
}
