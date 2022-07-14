package log;

import log.Colors.*;

/**
 *
 * - https://en.wikipedia.org/wiki/ANSI_escape_code
 * - https://github.com/haxiomic/console.hx/blob/master/Console.hx
 * - https://stackoverflow.com/questions/5762491/how-to-print-color-in-console-using-system-out-println
 *
 *
 * @example
 * import log.Logger.*;
 *
 *		setup(); // replace default Haxe trace();
 * 		log("this is a log message");
 *		warn("this is a warn message");
 *		info("this is a info message");
 */
class Logger {
	/**
	 * @example		log.Logger.setup();
	 */
	public static function setup() {
		// now we are going to overwrite the default trace with our own
		haxe.Log.trace = function(v:Dynamic, ?infos:haxe.PosInfos) {
			var str = '${BLUE} → ${RED}${infos.fileName}:${infos.lineNumber} ${RED_BOLD}${v}${RESET}';
			Sys.println(str);
		}
	}

	public static inline function log(v:Dynamic) {
		// Sys.println('> ' + v);
		Sys.println('${BLUE}→ ${WHITE}${v}${RESET}');
	}

	public static inline function info(v:Dynamic) {
		Sys.println('${BLUE}♥ ${GREEN}${v}${RESET}');
	}

	public static inline function warn(v:Dynamic) {
		Sys.println('${BLUE}⚠ ${BLACK}${RED_BACKGROUND}${v}${RESET}');
	}
}
