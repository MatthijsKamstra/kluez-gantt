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
	 * @param text		the text in this element
	 * @param x			x-position (css left)
	 * @param y			y-position (css right)
	 * @param width		width of the element (css width)
	 * @param height	height of the element (css height) default 50
	 * @param obj		for easier debugging?
	 */
	public static function create(text:String, x:Int, y:Int, width:Int, height:Int = 50, obj:Dynamic = null) {
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
