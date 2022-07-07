package utils;

import js.html.audio.OscillatorNode;
import haxe.Json;
import haxe.Log;
import js.Browser.*;
import const.Gantt;

using StringTools;

// using DateTools;
class Convert {
	var IS_DEBUG = false;

	public function new() {
		// your code
	}

	function convertNoDate(str) {
		return 2;
	}

	/**
		var json = new Convert().gantt(const.Gantt.TEST_1);
		console.log(haxe.Json.stringify(json, '  '));
	**/
	public function gantt(str:String, isDebug = false) {
		var json = {};

		Reflect.setField(json, 'created_date', Date.now());
		Reflect.setField(json, 'updated_date', Date.now());
		Reflect.setField(json, 'start_date', null);
		Reflect.setField(json, 'end_date', null);
		Reflect.setField(json, 'sections', []);

		var text = str;
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
				if (isDebug)
					console.info('${_sectionTitle}');

				// Reflect.setField(ganttObj, 'title', sectionTitle);
			} else {
				// [task name]:[state],[id],[start_time],[end_time]
				var arrr = line.split(':');
				var _title = arrr[0].trim();
				var rest = arrr[1].trim();
				var restArr = rest.split(',');
				var oArr = [];

				// console.group(_title);
				if (isDebug)
					console.groupCollapsed(_title);
				// console.log(title);
				if (isDebug)
					console.log('- "$line"');
				if (isDebug)
					console.info('- "$_sectionTitle"');
				if (isDebug)
					console.info('- "$_title"');
				oArr.push(line.replace('\t', '').replace('  ', ' '));
				oArr.push(_title);
				for (j in 0...restArr.length) {
					var _restArr = restArr[j].trim();
					if (isDebug)
						console.log('- $_restArr');
					oArr.push(_restArr.trim());
				}

				Reflect.setField(ganttObj, '_original', oArr);
				Reflect.setField(ganttObj, 'section', _sectionTitle);
				Reflect.setField(ganttObj, 'title', _title);

				// START DATE
				Reflect.setField(ganttObj, 'after_id', "");
				Reflect.setField(ganttObj, 'start_date', DateTools.format(_previousEndDate, "%F"));
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
						if (isDebug)
							console.info('start_date (xx-xx-xx): ' + DateTools.format(date, "%F"));

						_previousStartDate = date;
						_startDate = date;
					}

					// START DATE // 5d
					if (_startDateStr.length == 2) {
						var nr:Int;
						var addTime = 0.0;
						if (_startDateStr.indexOf('h') != -1) {
							// hours
							nr = Std.parseInt(_startDateStr.replace('h', '').trim());
							addTime = DateTools.hours(nr);
						}
						if (_startDateStr.indexOf('d') != -1) {
							// days
							nr = Std.parseInt(_startDateStr.replace('d', '').trim());
							addTime = DateTools.days(nr);
						}
						if (_startDateStr.indexOf('w') != -1) {
							// weeks
							nr = Std.int(Std.parseInt(_startDateStr.replace('w', '').trim()) * 7);
							addTime = DateTools.days(nr);
						}
						nr = Std.parseInt(_startDateStr.replace('d', '').trim());
						addTime = DateTools.days(nr);
						var date = DateTools.delta(_previousStartDate, addTime);
						Reflect.setField(ganttObj, 'start_date', DateTools.format(date, "%F"));
						if (isDebug)
							console.info('start_date ($_startDateStr): ' + DateTools.format(date, "%F"));

						_previousStartDate = date;
						_startDate = date;
					}

					// START DATE // after
					if (_startDateStr.indexOf('after ') != -1) {
						var getID = _startDateStr.replace('after ', '');
						// console.log(_map.get(getID));
						var date = Date.fromString(_mapAfter.get(getID));
						Reflect.setField(ganttObj, 'start_date', _mapAfter.get(getID));
						Reflect.setField(ganttObj, 'after_id', '$getID');
						if (isDebug)
							console.info('start_date ($_startDateStr): ' + getID + ' - ' + _mapAfter.get(getID));

						_previousStartDate = date;
						_startDate = date;
					}

					// make sure to set this value only once!
					if (Reflect.getProperty(json, 'start_date') == null)
						Reflect.setField(json, 'start_date', DateTools.format(_startDate, "%F"));
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
					if (isDebug)
						console.info('end_date (xx-xx-xx): ' + DateTools.format(date, "%F"));

					_previousEndDate = date;
					_endDate = date;
				}

				// END DATE // 5d
				if (_endDateStr.length == 2) {
					var nr = Std.parseInt(_endDateStr.replace('d', '').trim());
					if (isDebug)
						console.log('days: ' + nr);
					var date = DateTools.delta(_startDate, DateTools.days(nr));
					Reflect.setField(ganttObj, 'end_date', DateTools.format(date, "%F"));
					if (isDebug)
						console.info('end_date ($_endDateStr): ' + DateTools.format(date, "%F"));

					_previousEndDate = date;
					_endDate = date;
				}

				// END DATE // after
				if (_endDateStr.indexOf('after ') != -1) {
					var getID = _endDateStr.replace('after ', '');
					//	if (isDebug) console.log(_map.get(getID));
					var date = Date.fromString(_mapAfter.get(getID));
					Reflect.setField(ganttObj, 'end_date', _mapAfter.get(getID));
					if (isDebug)
						console.info('end_date ($_endDateStr): ' + getID + ' - ' + _mapAfter.get(getID));

					_previousEndDate = date;
					_endDate = date;
				}

				// TODO make sure that the current end_date is later then this one
				Reflect.setField(json, 'end_date', DateTools.format(_endDate, "%F"));
				// if (Reflect.getProperty(json, 'end_date') != null) {
				// 	trace(Reflect.getProperty(json, 'end_date'));
				// 	var oldDate = Date.fromString(Reflect.getProperty(json, 'end_date'));
				// 	if (oldDate.getTime() < _endDate.getTime())
				// 		Reflect.setField(json, 'end_date', DateTools.format(_endDate, "%F"));
				// }

				// ID
				Reflect.setField(ganttObj, 'id', '');
				if (restArr.length >= 3) {
					var _id = restArr[restArr.length - 3].trim();
					if (isDebug)
						console.info('id: ${_id}');
					Reflect.setField(ganttObj, 'id', _id);
					_mapAfter.set(_id, DateTools.format(_previousEndDate, "%F"));
					_mapBefore.set(_id, DateTools.format(_previousStartDate, "%F"));
				}

				// trace(_startDate.getTime());
				// trace(_endDate.getTime());

				if (isDebug)
					trace('start: ' + _startDate);
				if (isDebug)
					trace('end: ' + _endDate);

				var milliseconds = (_endDate.getTime() - _startDate.getTime());
				var seconds = Math.floor(milliseconds / 1000);
				var minutes = Math.floor(seconds / 60);
				var hours = Math.floor(minutes / 60);
				var days = Math.floor(hours / 24);
				var weeks = Math.floor(days / 7);
				var years = Math.floor(weeks / 52);
				var months = Math.floor(years / 12);

				// trace('milliseconds: ' + milliseconds);
				// trace('seconds: ' + seconds);
				// trace('minutes: ' + minutes);
				// trace('hours: ' + hours);
				// trace('days: ' + days);
				// trace('weeks: ' + weeks);
				// trace('months: ' + months);
				// trace('years: ' + years);

				// STATE
				Reflect.setField(ganttObj, 'state', '');
				if (restArr.length >= 4) {
					var _state = restArr[restArr.length - 4].trim();
					if (isDebug)
						console.info('state: ${_state}');
					Reflect.setField(ganttObj, 'state', _state);
				}
				console.groupEnd();

				Reflect.setField(ganttObj, 'total', {
					years: years,
					months: months,
					weeks: weeks,
					days: days,
					hours: hours,
					minutes: minutes,
					seconds: seconds,
					milliseconds: milliseconds,
				});

				_sectionArr.push(ganttObj);
			}
		}
		Reflect.setField(json, 'sections', _sectionArr);
		if (isDebug) {
			console.log('map after: ' + Json.stringify(_mapAfter));
			// console.log('map before: ' + Json.stringify(_mapBefore));
			// console.log(json);
			// console.log(Json.stringify(json, '  '));
		}

		return json;
	}
}
