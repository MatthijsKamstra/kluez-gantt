package;

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

		createTable(100, 1000);
	}

	public function createTable(xTotal, yTotal) {
		var table0 = cast document.getElementById('container-gantt-kluez').getElementsByClassName('pattern')[0];

		var colGroup = '';
		var row = '';

		for (y in 0...yTotal) {
			colGroup = '<colgroup>';
			row += '<tr>';
			// your code
			for (x in 0...xTotal) {
				colGroup += '<col>';
				row += '<td><span class="table-cell"></span></td>';
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
