package kluez;

import haxe.Json;
import js.Browser.*;
import js.html.Element;
import utils.UUID;

class El {
	/**
	 * @example
	 *			var el = El.create(hex, MathUtil.randomInteger(10, 300), (i * 60) + 10, MathUtil.randomInteger(50, 500));
	 *			el.classList.add('klz-el-${color}', 'draggable');
	 *			document.body.append(e);
	 *
	 * @param text
	 * @param x
	 * @param y
	 * @param width
	 * @param height
	 */
	public static function create(text:String, x:Int, y:Int, width:Int, height:Int = 50, obj:Dynamic) {
		// div
		var div = document.createDivElement();
		div.innerHTML = '<span>$text</span><!-- ${Json.stringify(obj, '  ')} -->';
		div.classList.add('klz-el');
		div.id = UUID.uuid();
		div.style.left = '${x}px';
		div.style.top = '${y}px';
		div.style.width = '${width}px';
		div.style.height = '${height}px';
		div.style.position = 'absolute';
		return div;
	}
}
