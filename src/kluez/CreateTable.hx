package kluez;

import js.html.DOMParser;
import js.html.SupportedType;
import js.html.DivElement;
import js.html.Element;
import js.Browser.*;

class CreateTable {
	var table0:DivElement;
	var table1:DivElement;
	var table2:DivElement;

	public function new(container:DivElement) {
		table0 = cast container.getElementsByClassName('table-0')[0];
		table1 = cast container.getElementsByClassName('table-1')[0];
		table2 = cast container.getElementsByClassName('table-2')[0];

		trace(table0);
		trace(table1);
		trace(table2);

		var t = '<table class="table-test">\n';

		for (y in 0...10) {
			t += '<tr>';
			// your code
			for (x in 0...10) {
				t += '<td></td>';
			}
			t += '</tr>';
		}
		t += '</table>';

		var frag = document.createRange().createContextualFragment(t);
		table2.appendChild(frag);
	}
}
