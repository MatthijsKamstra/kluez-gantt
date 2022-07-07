package utils;

class DateUtil {
	public function new() {
		// your code
	}

	public static function convert(startDate:Date, endDate:Date):{
		years:Int,
		months:Int,
		weeks:Int,
		days:Int,
		hours:Int,
		minutes:Int,
		seconds:Int,
		milliseconds:Int,
	} {
		var milliseconds = Math.round(endDate.getTime() - startDate.getTime());
		var seconds = Math.floor(milliseconds / 1000);
		var minutes = Math.floor(seconds / 60);
		var hours = Math.floor(minutes / 60);
		var days = Math.floor(hours / 24);
		var weeks = Math.floor(days / 7);
		var years = Math.floor(weeks / 52);
		var months = Math.floor(years / 12);

		return {
			years: years,
			months: months,
			weeks: weeks,
			days: days,
			hours: hours,
			minutes: minutes,
			seconds: seconds,
			milliseconds: milliseconds,
		}
	}
}
