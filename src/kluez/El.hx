package kluez;

import js.html.Element;
import utils.UUID;
import js.Browser.*;

class El {
	public static function create(el:Element, text:String, x:Int, y:Int, width:Int) {
		// div
		var div = document.createDivElement();
		div.innerText = text;
		div.classList.add('klz-el');
		div.id = UUID.uuid();
		div.style.left = '${x}px';
		div.style.top = '${y}px';
		div.style.width = '${width}px';
		div.style.height = '50px';
		div.style.position = 'absolute';
		el.append(div);
		return div;
	}
}
