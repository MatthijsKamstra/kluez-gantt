package kluez;

import hxColorToolkit.spaces.HSL;
import js.Browser.*;

using hxColorToolkit.ColorToolkit;
using StringTools;

class DynamicStyle {
	public static var colorMap = [
		//
		'gray' => '#95a5a6',
		'green' => '#1abc9c',
		'blue' => '#3498db',
		'purple' => '#9b59b6',
		'yellow' => '#f1c40f',
		'red' => '#e74c3c',
	];

	public function new() {
		// your code
	}

	public static function setStyle() {
		// trace('#9b59b6');
		// trace(0x9b59b6);
		// trace(Std.parseInt('#9b59b6'));
		// trace(Std.parseInt('#9b59b6'.replace('#', '0x')));
		// trace(Std.parseInt('0x9b59b6'));
		// // trace(StringTools.hex('#9b59b6'));
		// trace(StringTools.hex(0x9b59b6));
		// trace(StringTools.hex(Std.parseInt('#9b59b6'.replace('#', '0x'))));

		// var hsl = 0x9b59b6.toHSL();
		// trace(hsl);

		var xtraStyle = '';
		var str = '';
		for (color in colorMap.keys()) {
			var hex = colorMap[color];
			var hsl:HSL = Std.parseInt(hex.replace('#', '0x')).toHSL();

			// trace(hsl);

			// trace('$color is $hex');
			str += '
			--kluez-${color}: ${hex};\n
			--kluez-${color}-color: hsl(${hsl.hue}, ${hsl.saturation}%, ${hsl.lightness}%);\n
			--kluez-${color}-color-lighten: hsl(${hsl.hue}, ${hsl.saturation}%, ${hsl.lightness + 10}%);\n
			--kluez-${color}-color-darken: hsl(${hsl.hue}, ${hsl.saturation}%, ${hsl.lightness - 10}%);\n
			';
			xtraStyle += '
			.klz-el-${color} {
				background-color: var(--kluez-${color}-color);
				border-color: var(--kluez-${color}-color-darken);
			}
			';
		}

		var style2 = ':root { --kluez-blue: #3498db; }';

		var st = document.createStyleElement();
		// st.textContent = (style2);
		st.textContent = ':root { ${str} }\n${xtraStyle}';

		document.head.append(st);
	}
}
