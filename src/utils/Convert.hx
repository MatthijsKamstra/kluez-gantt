package utils;

import js.html.audio.OscillatorNode;
import haxe.Json;
import haxe.Log;
import js.Browser.*;
import const.Gantt;

using StringTools;

// using DateTools;
class Convert {
	public function new() {
		// your code
	}

	function convertNoDate(str) {
		return 2;
	}

	public function gantt() {
		var json = {};

		Reflect.setField(json, 'created_date', Date.now());
		Reflect.setField(json, 'updated_date', Date.now());
		Reflect.setField(json, 'section', []);

		var text = Gantt.TEST_0;
		var lines = text.split('\n');

		var _sectionArr = [];
		var _mapBefore = new Map();
		var _mapAfter = new Map();

		var _sectionTitle = '';
		var _startDateStr = '';
		var _endDateStr = '';
		var _state = '';
		var _id = '';

		var _startDate:Date = Date.now();
		var _endDate:Date = Date.now();
		var _previousStartDate:Date = Date.now();
		var _previousEndDate:Date = Date.now();

		for (i in 0...lines.length) {
			var ganttObj = {};

			var line = lines[i].trim();

			if (line == '') // empty line: ignore
				continue;

			if (line.trim().startsWith('%%')) // gantt comment: ignore
				continue;

			if (line.indexOf('section') != -1) {
				_sectionTitle = line.trim().substring('section'.length).trim();
				console.info('${_sectionTitle}');

				// Reflect.setField(ganttObj, 'title', sectionTitle);
			} else {
				var arrr = line.split(':');
				var _title = arrr[0].trim();
				var rest = arrr[1].trim();
				var restArr = rest.split(',');
				var oArr = [];

				console.group(_title);
				// console.log(title);
				console.log('- "$line"');
				console.info('- "$_sectionTitle"');
				console.info('- "$_title"');
				oArr.push(line.replace('\t', '').replace('  ', ' '));
				for (j in 0...restArr.length) {
					var _restArr = restArr[j].trim();
					console.log('- $_restArr');
					oArr.push(_restArr.trim());
				}

				Reflect.setField(ganttObj, '_original', oArr);
				Reflect.setField(ganttObj, 'section', _sectionTitle);
				Reflect.setField(ganttObj, 'title', _title);

				// START DATE
				Reflect.setField(ganttObj, 'start_date', '');
				if (restArr.length >= 2) {
					_startDateStr = restArr[restArr.length - 2].trim();
					// Reflect.setField(ganttObj, '__start_date', _startDateStr);
					// console.log(_startDateStr.split('-').length);
					// console.info('start date: ${_startDateStr}');

					// lets figure this value out
					// START DATE // 2014-01-06
					if (_startDateStr.split('-').length == 3) {
						// console.log('// date');
						var date = Date.fromString(_startDateStr);
						Reflect.setField(ganttObj, 'start_date', DateTools.format(date, "%F"));
						console.info('start_date (xx-xx-xx): ' + DateTools.format(date, "%F"));

						_previousStartDate = date;
					}

					// START DATE // 5d
					if (_startDateStr.length == 2) {
						var nr = Std.parseInt(_startDateStr.replace('d', '').trim());
						// console.log('days: ' + nr);
						var date = DateTools.delta(_previousStartDate, DateTools.days(nr));
						Reflect.setField(ganttObj, 'start_date', DateTools.format(date, "%F"));
						console.info('start_date ($_startDateStr): ' + DateTools.format(date, "%F"));

						_previousStartDate = date;
					}

					// START DATE // after
					if (_startDateStr.indexOf('after ') != -1) {
						var getID = _startDateStr.replace('after ', '');
						// console.log(_map.get(getID));
						console.info('start_date ($_startDateStr): ' + getID + ' - ' + _mapAfter.get(getID));
						Reflect.setField(ganttObj, 'start_date', _mapAfter.get(getID));
					}
				}

				// END DATE
				var _endDateStr = restArr[restArr.length - 1].trim();
				Reflect.setField(ganttObj, 'end_date', '');
				// lets figure this value out
				// END DATE // 2014-01-06
				if (_endDateStr.split('-').length == 3) {
					// console.log('// date');
					var date = Date.fromString(_endDateStr);
					Reflect.setField(ganttObj, 'end_date', DateTools.format(date, "%F"));
					console.info('end_date (xx-xx-xx): ' + DateTools.format(date, "%F"));

					_previousEndDate = date;
				}

				// END DATE // 5d
				if (_endDateStr.length == 2) {
					var nr = Std.parseInt(_endDateStr.replace('d', '').trim());
					// console.log('days: ' + nr);
					var date = DateTools.delta(_previousEndDate, DateTools.days(nr));
					Reflect.setField(ganttObj, 'end_date', DateTools.format(date, "%F"));
					console.info('end_date ($_endDateStr): ' + DateTools.format(date, "%F"));

					_previousEndDate = date;
				}

				// END DATE // after
				if (_endDateStr.indexOf('after ') != -1) {
					var getID = _endDateStr.replace('after ', '');
					// console.log(_map.get(getID));
					console.info('end_date ($_endDateStr): ' + getID + ' - ' + _mapAfter.get(getID));
					Reflect.setField(ganttObj, 'end_date', _mapAfter.get(getID));
				}

				// ID
				Reflect.setField(ganttObj, 'id', '');
				if (restArr.length >= 3) {
					var _id = restArr[restArr.length - 3].trim();
					console.info('id: ${_id}');
					Reflect.setField(ganttObj, 'id', _id);
					_mapAfter.set(_id, DateTools.format(_previousEndDate, "%F"));
					_mapBefore.set(_id, DateTools.format(_previousStartDate, "%F"));
				}

				// STATE
				Reflect.setField(ganttObj, 'state', '');
				if (restArr.length >= 4) {
					var _state = restArr[restArr.length - 4].trim();
					console.info('state: ${_state}');
					Reflect.setField(ganttObj, 'state', _state);
				}
				console.groupEnd();

				_sectionArr.push(ganttObj);
			}
		}
		console.log('map after: ' + Json.stringify(_mapAfter));
		// console.log('map before: ' + Json.stringify(_mapBefore));
		Reflect.setField(json, 'section', _sectionArr);
		// console.log(json);
		console.log(Json.stringify(json, '  '));
	}
}
