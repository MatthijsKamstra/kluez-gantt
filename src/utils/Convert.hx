package utils;

import model.AST.GanttObj;
import haxe.Json;
// import js.Browser.*;
import const.Gantt;

using StringTools;

import log.Logger.*;

// using DateTools;
class Convert {
	var IS_DEBUG = false;

	// dutch sortnames for days of the week and months
	var dayArr = ['zo', 'ma', 'di', 'wo', 'do', 'vr', 'za'];
	var monthArr = [
		'jan', 'feb', 'mrt', 'apr', 'mei', 'jun', 'jul', 'aug', 'sep', 'okt', 'nov', 'dec'
	];

	public function new() {
		// your code
	}

	/**
	 * convert `5d`, `5h`, `5w` to a timestmap
	 *
	 * @example		convertNoDate('8h'); //
	 *
	 * @param str	a time indication string (example  `5d`, `5h`, `5w` )
	 *
	 * @return Float	Converts a number to a timestamp.
	 */
	function convertNoDate(str:String):Float {
		var nr:Int;
		var timestamp = 0.0;
		if (str.indexOf('h') != -1) {
			// hours
			nr = Std.parseInt(str.replace('h', '').trim());
			timestamp = DateTools.hours(nr);
		}
		if (str.indexOf('d') != -1) {
			// days
			nr = Std.parseInt(str.replace('d', '').trim());
			timestamp = DateTools.days(nr);
		}
		if (str.indexOf('w') != -1) {
			// weeks
			nr = Std.int(Std.parseInt(str.replace('w', '').trim()) * 7);
			timestamp = DateTools.days(nr);
		}
		// nr = Std.parseInt(str.replace('d', '').trim());
		// timestamp = DateTools.days(nr);
		// var date = DateTools.delta(_previousStartDate, addTime);

		return timestamp;
	}

	/**
		var json = new Convert().gantt(const.Gantt.TEST_1);
		// console.log(haxe.Json.stringify(json, '  '));
	**/
	public function gantt(str:String, isDebug = false):GanttObj {
		// // setup(); // replace default Haxe trace();
		// log("this is a log message");
		// warn("this is a warn message");
		// info("this is a info message");

		if (isDebug) {
			warn("GANTT convert");
		}

		var json = {};

		Reflect.setField(json, 'created_date', Date.now());
		Reflect.setField(json, 'updated_date', Date.now());
		Reflect.setField(json, 'title', 'Test');
		Reflect.setField(json, 'excludes', 'weekends');
		Reflect.setField(json, 'dateFormat', 'YYYY-MM-DD');
		Reflect.setField(json, 'start_date', null);
		Reflect.setField(json, 'end_date', null);
		Reflect.setField(json, 'total', {});
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

		// read all lines
		for (i in 0...lines.length) {
			var ganttObj = {};

			var line = lines[i].trim();

			if (line == '') // empty line: ignore
				continue;

			if (line.trim().startsWith('%%')) // gantt comment: ignore
				continue;

			if (line.indexOf('section') != -1) {
				_sectionTitle = line.trim().substring('section'.length).trim();
				if (isDebug) {
					info('${_sectionTitle}');
				}

				// Reflect.setField(ganttObj, 'title', sectionTitle);
			} else {
				// [task name]:[state],[id],[start_time],[end_time]
				var arrr = line.split(':');
				var _title = arrr[0].trim();
				var rest = arrr[1].trim();
				var restArr = rest.split(',');
				var oArr = [];

				if (isDebug) {
					// // console.group(_title);
					// console.groupCollapsed(_title);
					// // console.log(title);

					log('- line: "$line"');
					info('- sectionTitle: "$_sectionTitle"');
					info('- title: "$_title"');
				}
				oArr.push(line.replace('\t', '').replace('  ', ' '));

				oArr.push(_title);
				for (j in 0...restArr.length) {
					var _restArr = restArr[j].trim();
					if (isDebug) {
						log('------ restline info: $_restArr');
					}
					oArr.push(_restArr.trim());
				}

				Reflect.setField(ganttObj, '_original', oArr);

				Reflect.setField(ganttObj, 'section', _sectionTitle);
				Reflect.setField(ganttObj, 'title', _title);

				// START DATE
				Reflect.setField(ganttObj, 'after_id', "");
				Reflect.setField(ganttObj, 'start_date', DateTools.format(_previousEndDate, "%F"));

				// START DATE
				// if split (,) line >= then 2 items
				if (restArr.length >= 2) {
					if (isDebug) {
						warn('line >= then 2 items');
					}
					_startDateStr = restArr[restArr.length - 2].trim();
					// Reflect.setField(ganttObj, '__start_date', _startDateStr);
					// // console.log(_startDateStr.split('-').length);
					// // console.info('start date: ${_startDateStr}');

					// lets figure this value out
					// START DATE // 2014-01-06
					if (_startDateStr.split('-').length == 3) {
						if (isDebug) {
							log('// START date (xxxx-xx-xx)');
						}
						var date = Date.fromString(_startDateStr);
						Reflect.setField(ganttObj, 'start_date', DateTools.format(date, "%F"));
						if (isDebug) {
							info('start_date (xx-xx-xx): ' + DateTools.format(date, "%F"));
							info('start_date (xx-xx-xx): ' + date);
						}

						_previousStartDate = date;
						_startDate = date;
					}

					// START DATE // 5d
					if (_startDateStr.length == 2) {
						if (isDebug) {
							log('// START date (5d)');
						}
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
						if (isDebug) {
							info('start_date ($_startDateStr): ' + DateTools.format(date, "%F"));
						}

						_previousStartDate = date;
						_startDate = date;
					}

					// START DATE // after
					if (_startDateStr.indexOf('after ') != -1) {
						if (isDebug)
							log('// start date (after)');
						var getID = _startDateStr.replace('after ', '');
						// // console.log(_map.get(getID));
						var date = Date.fromString(_mapAfter.get(getID));
						Reflect.setField(ganttObj, 'start_date', _mapAfter.get(getID));
						Reflect.setField(ganttObj, 'after_id', '$getID');
						if (isDebug) {
							info('start_date ($_startDateStr): ' + getID + ' - ' + _mapAfter.get(getID));
						}

						_previousStartDate = date;
						_startDate = date;
					}

					// make sure to set this value only once!
					if (Reflect.getProperty(json, 'start_date') == null) {
						Reflect.setField(json, 'start_date', DateTools.format(_startDate, "%F"));
					}
				}
				// end if loop (line >= then 2 items)

				///////////////////////////
				// END DATE
				///////////////////////////
				var _endDateStr = restArr[restArr.length - 1].trim();
				Reflect.setField(ganttObj, 'end_date', '');
				// lets figure this value out
				///////////////////////////
				// END DATE // 2014-01-06
				///////////////////////////
				if (_endDateStr.indexOf('-') != -1 && _endDateStr.split('-').length == 3) {
					if (isDebug) {
						log('// END date (xxxx-xx-xx)');
					}
					// FIXME: make sure the enddate is 23:59:59
					var date = Date.fromString(_endDateStr);
					Reflect.setField(ganttObj, 'end_date', DateTools.format(date, "%F"));
					if (isDebug) {
						info('end_date (xxxx-xx-xx): ' + DateTools.format(date, "%F"));
						info('end_date (xxxx-xx-xx): ' + date);
					}

					_previousEndDate = date;
					_endDate = date;
				}

				///////////////////////////
				// END DATE // 5d
				///////////////////////////
				var hardcodedNR:Int = 0;
				if (_endDateStr.indexOf('d') != -1 || _endDateStr.indexOf('w') != -1 || _endDateStr.indexOf('h') != -1) {
					// TODO fix d, w, h

					var nr:Int = 0;
					nr = Std.parseInt(_endDateStr.replace('d', '').trim());
					hardcodedNR = nr;

					if (isDebug) {
						log('// END date (${nr}) (${_endDateStr})');
						hi('timestamp (_endDateStr): ${convertNoDate(_endDateStr)}');
						log('nr: ' + nr);
					}
					// FIXME: friday + 2 should ignore weekend (sa, su)... so add +2 to nr?
					if (isDebug) {
						hili(_startDate.getDay());
						hili(dayArr[_startDate.getDay()]);
					}
					for (i in 0...nr) {
						var d = DateTools.delta(_startDate, DateTools.days(i));
						if (isDebug) {
							hili('total nr: $nr');
							hili(d.getDay());
							hili(dayArr[d.getDay()]);
						}
						if (d.getDay() == 6) {
							nr += 2;
						}
					}
					if (isDebug) {
						hili('total nr (after): $nr');
					}

					// NOTE: make sure a job can start on monday and end on monday
					// via timestamp - 1
					var date = DateTools.delta(_startDate, DateTools.days(nr) - 1);
					Reflect.setField(ganttObj, 'end_date', DateTools.format(date, "%F"));
					if (isDebug) {
						info('end_date ($_endDateStr): ' + DateTools.format(date, "%F"));
						info('end_date ($_endDateStr): ' + date);
					}

					_previousEndDate = date;
					_endDate = date;
				}

				// END DATE // after
				if (_endDateStr.indexOf('after ') != -1) {
					if (isDebug) {
						log('// end date (after)');
					}
					var getID = _endDateStr.replace('after ', '');
					//	if (isDebug) { // console.log(_map.get(getID)); }
					var date = Date.fromString(_mapAfter.get(getID));
					Reflect.setField(ganttObj, 'end_date', _mapAfter.get(getID));
					if (isDebug) {
						info('end_date ($_endDateStr): ' + getID + ' - ' + _mapAfter.get(getID));
					}

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
					if (isDebug) {
						info('id: ${_id}');
					}
					Reflect.setField(ganttObj, 'id', _id);
					_mapAfter.set(_id, DateTools.format(_previousEndDate, "%F"));
					_mapBefore.set(_id, DateTools.format(_previousStartDate, "%F"));
				}

				// trace(_startDate.getTime());
				// trace(_endDate.getTime());

				if (isDebug) {
					info('-- start: ' + _startDate);
					info(Reflect.getProperty(ganttObj, 'start_date'));
					info('-- end: ' + _endDate);
					info(Reflect.getProperty(ganttObj, 'end_date'));
				}

				// FIXME: make sure the milleseconds work with rounded numbers
				// via getTime() + 1 (see _endTime conversion)
				var milliseconds = ((_endDate.getTime() + 1) - _startDate.getTime());
				var seconds = Math.floor(milliseconds / 1000);
				var minutes = Math.floor(seconds / 60);
				var hours = Math.floor(minutes / 60);
				var days = Math.floor(hours / 24);
				var working_days = Math.floor(hardcodedNR);
				var weeks = Math.floor(days / 7);
				var years = Math.floor(weeks / 52);
				var months = Math.floor(years / 12);

				Reflect.setField(ganttObj, 'total', {
					years: years,
					months: months,
					weeks: weeks,
					days: days,
					working_days: working_days,
					hours: hours,
					minutes: minutes,
					seconds: seconds,
					milliseconds: milliseconds,
				});

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
					_state = restArr[restArr.length - 4].trim();
					if (isDebug) {
						info('state: ${_state}');
					}
					Reflect.setField(ganttObj, 'state', _state);
				}
				// console.groupEnd();

				Reflect.setField(ganttObj, 'date', {
					'start': {
						'date': _startDate,
						'day': _startDate.getDay(),
						'month': _startDate.getMonth(),
						'year': _startDate.getFullYear(),
						'day_str': dayArr[_startDate.getDay()],
						'month_str': monthArr[_startDate.getMonth()],
					},
					'end': {
						'date': _endDate,
						'day': _endDate.getDay(),
						'month': _endDate.getMonth(),
						'year': _endDate.getFullYear(),
						'day_str': dayArr[_endDate.getDay()],
						'month_str': monthArr[_endDate.getMonth()],
					}
				});

				_sectionArr.push(ganttObj);
			}
		}

		// trace(_startDate, _endDate);

		var tempStart = Reflect.getProperty(json, 'start_date');
		var tempEnd = Reflect.getProperty(json, 'end_date');
		Reflect.setField(json, 'total', DateUtil.convert(Date.fromString(tempStart), Date.fromString(tempEnd)));

		Reflect.setField(json, 'sections', _sectionArr);
		if (isDebug) {
			// console.log('map after: ' + Json.stringify(_mapAfter));
			// // console.log('map before: ' + Json.stringify(_mapBefore));
			// // console.log(json);
			// // console.log(Json.stringify(json, '  '));
		}

		return cast(json);
	}
}
