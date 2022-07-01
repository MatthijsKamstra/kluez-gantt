package;

import kluez.KlzDragElement;
import kluez.KlzElement;
import kluez.DynamicStyle;
import js.html.DivElement;
import js.Browser.*;

using hxColorToolkit.ColorToolkit;
using StringTools;

class Main {
	public function new() {
		trace('Main');
		DynamicStyle.setStyle();

		// create container setup
		new KlzElement(document.getElementById("kluez-create-container"));

		// create container setup
		// // Make the DIV element draggable:
		new KlzDragElement(document.getElementById("kluez-drag-container"));
	}

	static public function main() {
		var app = new Main();
	}
}
