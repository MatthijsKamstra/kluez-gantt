package tests;

import model.AST.Section;
import utils.Convert;
import model.AST.GanttObj;

using buddy.Should;

@colorize
class TestsDateUtil extends buddy.SingleSuite {
	public function new() {
		// describe("Using Buddy", {
		// 	it("should be a great testing experience");
		// 	it("should really make the tester happy");
		// });

		describe("Simple convert: \"Completed task :2014-01-06,2014-01-08\" ", {
			var json:GanttObj = cast new Convert().gantt('Completed task :2014-01-06,2014-01-08');
			var section:Section = json.sections[0];
			// trace(json);
			it("check title", {
				section.title.should.be('Completed task');
			});
			it("check start date", {
				section.start_date.should.be('2014-01-06');
			});
			it("check end date", {
				section.end_date.should.be('2014-01-08');
			});
			it("total days", {
				section.total.days.should.be(2);
			});
		});

		// @include
		describe("Complex convert: 'Completed task :done, des1, 2014-01-06,2014-01-08'", {
			var json:GanttObj = cast new Convert().gantt('Completed task :done, des1, 2014-01-06,2014-01-08');
			var section:Section = json.sections[0];
			// trace(haxe.Json.stringify(json, '  '));
			it("check title", {
				section.title.should.be('Completed task');
			});
			it("check state", {
				section.state.should.be('done');
			});
			it("check id", {
				section.id.should.be('des1');
			});
			it('start date', {
				section.start_date.should.be('2014-01-06');
			});
			it('end date', {
				section.end_date.should.be('2014-01-08');
			});
		});

		// @include
		describe("Maandag tot vrijdag", {
			var json:GanttObj = cast new Convert().gantt('Maandag tot vrijdag            :2022-07-11,2022-07-15');
			var section:Section = json.sections[0];
			it('start date', {
				section.start_date.should.be('2022-07-11');
			});
			it('end date', {
				section.end_date.should.be('2022-07-15');
			});
			it('total days', {
				section.total.days.should.be(4);
			});
		});

		describe("Maandag + 5 dagen", {
			var json:GanttObj = cast new Convert().gantt('    Maandag + 5 dagen            :2022-07-11, 5d');
			var section:Section = json.sections[0];
			it('start date', {
				section.start_date.should.be('2022-07-11');
			});
			it('end date', {
				section.end_date.should.be('2022-07-16');
			});
			it('total days', {
				section.total.days.should.be(5);
			});
		});

		describe("Maandag + 7 dagen", {
			var json:GanttObj = cast new Convert().gantt('     Maandag + 7 dagen            :2022-07-11, 7d');
			var section:Section = json.sections[0];
			it('start date', {
				section.start_date.should.be('2022-07-11');
			});
			it('end date', {
				section.end_date.should.be('2022-07-18');
			});
			it('total days', {
				section.total.days.should.be(7);
			});
			it('total weeks', {
				section.total.weeks.should.be(1);
			});
		});

		describe("Vrijdag tot dinsdag", {
			var json:GanttObj = cast new Convert().gantt(' Vrijdag tot dinsdag         :2022-07-15,2022-07-19');
			var section:Section = json.sections[0];
			it('start date', {
				section.start_date.should.be('2022-07-15');
			});
			it('end date', {
				section.end_date.should.be('2022-07-19');
			});
			it('total days', {
				section.total.days.should.be(4);
			});
		});

		// FIXME! test above has also the weekend (-2 days)
		// total days should be 2

		describe("Vrijdag + 5", {
			var json:GanttObj = cast new Convert().gantt(' Vrijdag + 5        :2022-07-15,5d');
			var section:Section = json.sections[0];
			it('start date', {
				section.start_date.should.be('2022-07-15');
			});
			it('end date', {
				section.end_date.should.be('2022-07-20');
			});
			it('total days', {
				section.total.days.should.be(5);
			});
		});

		describe("Vrijdag + 10", {
			var json:GanttObj = cast new Convert().gantt(' Vrijdag + 10        :2022-07-15,10d');
			var section:Section = json.sections[0];
			it('start date', {
				section.start_date.should.be('2022-07-15');
			});
			it('end date', {
				section.end_date.should.be('2022-07-25');
			});
			it('total days', {
				section.total.days.should.be(10);
			});
		});

		// describe('test input DateUtil',	{
		// 	it('year should be between 1970 and 2038', {
		// 		(function() {
		// 			DateUtil.human(1111, 9, 10);
		// 		}).should.throwAnything();

		// 		DateUtil.human.bind(9999, 9, 10).should.throwAnything();
		// 		DateUtil.human.bind(9999, 9, 10).should.throwType(String);
		// 		DateUtil.human.bind(2039, 9, 10).should.throwAnything();
		// 		DateUtil.human.bind(2038, 9, 10).should.throwAnything();
		// 		DateUtil.human.bind(2020, 9, 10).should.not.throwAnything();
		// 	});
		// 	it('month (human) should be between 1 and 11 max', {
		// 		DateUtil.human.bind(2020, -1, 1).should.throwAnything();
		// 		DateUtil.human.bind(2020, 0, 1).should.throwAnything();
		// 		DateUtil.human.bind(2020, 1, 1).should.not.throwAnything();
		// 		DateUtil.human.bind(2020, 10, 1).should.not.throwAnything();
		// 		DateUtil.human.bind(2020, 11, 1).should.not.throwAnything();
		// 		DateUtil.human.bind(2020, 12, 1).should.throwAnything();

		// 		// for (i in 1...12) {
		// 		// 	it('month (human) ${i}', {
		// 		// 		DateUtil.human.bind(2020, i, 1).should.not.throwAnything();
		// 		// 	});
		// 		// }
		// 	});
		// 	it('month (computer) should be between 0 and 10 max', {
		// 		(function() {
		// 			new DateUtil(2020, -1, 1);
		// 		}).should.throwAnything();
		// 		(function() {
		// 			new DateUtil(2020, 0, 1);
		// 		}).should.not.throwAnything();
		// 		(function() {
		// 			new DateUtil(2020, 1, 1);
		// 		}).should.not.throwAnything();
		// 		(function() {
		// 			new DateUtil(2020, 10, 1);
		// 		}).should.not.throwAnything();
		// 		(function() {
		// 			new DateUtil(2020, 11, 1);
		// 		}).should.throwAnything();
		// 		(function() {
		// 			new DateUtil(2020, 12, 1);
		// 		}).should.throwAnything();
		// 	});
		// 	it('days should be 1 and 33 max', {
		// 		DateUtil.human.bind(2020, 1, 0).should.throwAnything();
		// 		DateUtil.human.bind(2020, 1, 1).should.not.throwAnything();
		// 		DateUtil.human.bind(2020, 1, 32).should.not.throwAnything();
		// 		DateUtil.human.bind(2020, 1, 33).should.not.throwAnything();
		// 		DateUtil.human.bind(2020, 1, 34).should.throwAnything();
		// 		// for (i in 1...33) {
		// 		// 	it('day  ${i}', {
		// 		// 		DateUtil.human.bind(2020, 1, i).should.not.throwAnything();
		// 		// 	});
		// 		// }
		// 	});
		// });

		// describe("Test DateUtil with friday 10 September 2016 (10-09-2016)", {
		// 	var date = DateUtil.human(2016, 9, 10); // friday 10 September 2016

		// 	it("should be the 10th", {
		// 		date.getDate().should.be(10);
		// 	});
		// 	it("should be friday (5)", {
		// 		date.getDay().should.be(5);
		// 	});
		// 	it("should be 'Vr'", {
		// 		date.getDayNlShortName().toLowerCase().should.be('vr');
		// 		date.getDayNlShortName().should.be('Vr');
		// 		date.getDayNlShortName().should.not.be('Vrijdag');
		// 		date.getDayNlShortName().should.not.be('Friday');
		// 		date.getDayNlShortName().should.not.be('Fri');
		// 	});
		// 	it("should be 33 days total", {
		// 		date.getMonthDays().should.be(33);
		// 	});
		// 	it("should be 'september'", {
		// 		date.getMonthNlName().should.be('september');
		// 	});
		// });

		// describe("Test DateUtil with wednesday 1 September 2016 (01-09-2016)", {
		// 	var date = DateUtil.human(2016, 9, 1);
		// 	it("should be the 1th", {
		// 		date.getDate().should.be(1);
		// 	});
		// 	it("should be wednesday (3)", {
		// 		date.getDay().should.be(3);
		// 	});
		// 	it("should be 'Wo'", {
		// 		date.getDayNlShortName().toLowerCase().should.be('wo');
		// 		date.getDayNlShortName().should.be('Wo');
		// 		date.getDayNlShortName().should.not.be('Woensdag');
		// 		date.getDayNlShortName().should.not.be('Wednesday');
		// 		date.getDayNlShortName().should.not.be('Wed');
		// 	});
		// 	it("should be 33 days total", {
		// 		date.getMonthDays().should.be(33);
		// 	});
		// 	it("should be 'september'", {
		// 		date.getMonthNlName().should.be('september');
		// 	});
		// });

		// describe("Test DateUtil with za 32 September 2016 (32-09-2016)", {
		// 	var date = DateUtil.human(2016, 9, 32);

		// 	it("should be the 32th", {
		// 		date.getDate().should.be(32);
		// 	});
		// 	it("should be saterday (6)", {
		// 		date.getDay().should.be(6);
		// 	});
		// 	it("should be 'Za'", {
		// 		date.getDayNlShortName().toLowerCase().should.be('za');
		// 		date.getDayNlShortName().should.be('Za');
		// 		date.getDayNlShortName().should.not.be('Zaterdag');
		// 		date.getDayNlShortName().should.not.be('Saturday');
		// 		date.getDayNlShortName().should.not.be('Sat');
		// 	});
		// 	it("should be 33 days total", {
		// 		date.getMonthDays().should.be(33);
		// 	});
		// 	it("should be 'september'", {
		// 		date.getMonthNlName().should.be('september');
		// 	});
		// });

		// describe("Test DateUtil with zo 32 Augustus 2016 (32-08-2016)", {
		// 	var date = DateUtil.human(2016, 8, 32);
		// 	it("should be the 32th", {
		// 		date.getDate().should.be(32);
		// 	});
		// 	it("should be dinsdag (2)", {
		// 		date.getDay().should.be(2);
		// 	});
		// 	it("should be 'Di'", {
		// 		date.getDayNlShortName().toLowerCase().should.be('di');
		// 	});
		// 	it("should be 32 days total", {
		// 		date.getMonthDays().should.be(32);
		// 	});
		// 	it("should be 'augustus'", {
		// 		date.getMonthNlName().should.be('augustus');
		// 	});
		// });

		// describe("Test DateUtil with zo 1 october 2016 (01-10-2016)", {
		// 	var date = DateUtil.human(2016, 10, 1);
		// 	it("should be the 1th", {
		// 		date.getDate().should.be(1);
		// 	});
		// 	it("should be maandag (1)", {
		// 		date.getDay().should.be(1);
		// 	});
		// 	it("should be 'Ma'", {
		// 		date.getDayNlShortName().toLowerCase().should.be('ma');
		// 	});
		// 	it("should be 32 days total", {
		// 		date.getMonthDays().should.be(32);
		// 	});
		// 	it("should be 'oktober'", {
		// 		date.getMonthNlName().should.be('oktober');
		// 	});
		// });

		// // describe("test suite", {
		// // 	it("should be a great testing experience");
		// // 	it("should really make the tester happy");
		// // });
	}
}
