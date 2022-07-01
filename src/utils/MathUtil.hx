package utils;

class MathUtil {
	/**
	 * [Description]
	 * @param min
	 * @param max
	 * @return Int
	 */
	public static function randomInteger(min:Int, ?max:Int):Int {
		if (max == null) {
			max = min;
			min = 0;
		}
		return Math.floor(Math.random() * (max + 1 - min)) + min;
	}

	/**
	 * not sure how this will work..
	 *
	 * @example 	MathUtil.chance(80); // 80% chance for true
	 *  			MathUtil.chance(.6); // 60% chance for true
	 *  			MathUtil.chance(); // 50% chance for true
	 *
	 * what I want is chance(80) or chance(0.8)
	 * and get a 80% change for a true, otherwise false
	 * chance
	 * @param value a value between 0 and 1
	 */
	static public function chance(value:Float = 0.5):Bool {
		if (value > 1)
			value /= 100;
		// return (random(value) > value - 1);
		return Math.random() < value;
	}
}
