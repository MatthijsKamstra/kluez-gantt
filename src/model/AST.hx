package model;

/**
 * Generated with HxJsonDef (version 0.0.8) on Wed Jul 06 2022 17:13:56 GMT+0200 (Central European Summer Time)
 * from : https://matthijskamstra.github.io/hxjsondef/
 *
 * AST = Abstract Syntax Tree
 *
 * Note:
 * If you provide a .json there should be no null values
 * comments in this document show you the values that need to be changed!
 *
 * Some (backend)-developers choose to hide empty/null values, you can add them:
 * 		@:optional var _id : Int;
 *
 * Name(s) that you possibly need to change:
 * 		GanttObj
 * 		Section
 * 		Date
 */
typedef GanttObj = {
	var created_date:Date;
	var updated_date:Date;
	var start_date:String;
	var end_date:String;

	var title:String;
	var excludes:String; // weeknd,
	var dateFormat:String; // ":"YYYY-MM-DD"
	var sections:Array<Section>;
};

typedef Section = {
	var _original:Array<String>;
	var section:String;
	var title:String;
	var after_id:String;
	var start_date:String;
	var end_date:String;
	var id:String;
	var state:String;
	var date:Datez;
	var total:Total;
};

typedef Total = {
	var years:Int;
	var months:Int;
	var weeks:Int;
	var days:Int;
	var working_days:Int;
	var hours:Int;
	var minutes:Int;
	var seconds:Int;
	var milliseconds:Int;
};

typedef Datezz = {
	var date:Date;
	var day:Int;
	var month:Int;
	var year:Int;
	var day_str:String;
	var month_str:String;
};

typedef Datez = {
	var start:Datezz;
	var end:Datezz;
};
