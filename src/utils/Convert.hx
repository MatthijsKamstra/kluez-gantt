package utils;

import js.Browser.*;
import const.Gantt;

using StringTools;

class Convert {
	public function new() {
		// your code
	}

	public static function gantt() {
		var text = Gantt.TEST0;
		// trace("text: " + text);
		var lines = text.split('\n');
		// trace(lines.length);

		for (i in 0...lines.length) {
			var line = lines[i];
			if (line == '')
				continue;
			if (line.indexOf('section') != -1) {
				var sectionTitle = line.trim().substring('section'.length).trim();
				console.info('${sectionTitle}');
			} else {
				var tt = line.split(':');
				var title = tt[0].trim();
				var rest = tt[1].trim();
				var restArr = rest.split(',');
				console.groupCollapsed(title);
				// console.log(title);
				for (j in 0...restArr.length) {
					var _restArr = restArr[j].trim();
					console.log(_restArr);
				}
				var _startDateStr = restArr[restArr.length - 2].trim();
				var _endDateStr = restArr[restArr.length - 1].trim();
				try {
					console.warn(Date.fromString(_endDateStr));
				} catch (err) {
					// console.log(err);
					console.warn(_endDateStr);
				}
				console.info('start date: ${_startDateStr}');
				console.info('end date: ${_endDateStr}');
				console.groupEnd();
			}
		}
	}
}
