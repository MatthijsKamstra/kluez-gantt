package const;

class Colors {
	public static var colorMap = [
		//
		'green' => '#1abc9c',
		'blue' => '#3498db',
		'purple' => '#9b59b6',
		'yellow' => '#f1c40f',
		'red' => '#e74c3c',
		'gray' => '#95a5a6',
	];

	/**

	**/
	public static function hexArray() {
		var arr = [];
		for (color in colorMap.keys()) {
			var hex = colorMap[color];
			arr.push(hex);
		}
		return arr;
	}

	/**

	**/
	public static function colorArray() {
		var arr = [];
		for (color in colorMap.keys()) {
			var hex = colorMap[color];
			arr.push(hex);
		}
		return arr;
	}
}
