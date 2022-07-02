package;

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

		// create container setup
		new CreateElement(document.getElementById("kluez-create-container"));

		// create container setup
		// // Make the DIV element draggable:
		new DragElement(document.getElementById("kluez-drag-container"));

		// create container setup
		// // Make the DIV element draggable:
		new ResizeElement(document.getElementById("kluez-resize-container"));
	}

	static public function main() {
		var app = new Main();
	}
}
