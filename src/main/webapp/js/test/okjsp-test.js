test( "hello test", function() {
	  ok( 1 == "1", "Passed!" );
	  ok( 2 == "2", "Passed!" );
	});
	
test("okjsp.js saveBbslist", function() {
	clearCookie('bbslist');
	ok('' == getCookie('bbslist'), 'clear cookie');
	
	saveBbslist("techtrend");
	ok('techtrend:1' == getCookie('bbslist'), 'save one');

	clearCookie('bbslist');
	saveBbslist("techtrend");
	saveBbslist("techtrend");
	ok('techtrend:2' == getCookie('bbslist'), 'save twice');

	clearCookie('bbslist');
	saveBbslist("techtrend");
	saveBbslist("html5");
	ok('techtrend:1,html5:1' == getCookie('bbslist'), 'save other');
	
	clearCookie('bbslist');
	saveBbslist("techtrend");
	saveBbslist("techtrend");
	saveBbslist("html5");
	ok('techtrend:2,html5:1' == getCookie('bbslist'), 'save 2 and 1');
	
	var array = 'html5:2,techtrend:1'.split(',');
	array.sort(function(a, b) {
		return parseInt(b.split(':')[1]) - parseInt(a.split(':')[1])
	});
	ok('html5:2'== array[0], 'array sort test');
	
	clearCookie('bbslist');
	saveBbslist("techtrend");
	saveBbslist("html5");
	saveBbslist("html5");
	ok('html5:2,techtrend:1' == getCookie('bbslist'), 'sort list');

	clearCookie('bbslist');
	saveBbslist("techtrend");
	saveBbslist("html5");
	saveBbslist("html5");
	saveBbslist("bbs1");
	var str = getCookie('bbslist');
	ok('html5:2,techtrend:1,bbs1:1' == str, 'three and sort');
	
});

test('migration test', function() {
	setCookie('bbslist', 'html5,techtrend,bbs1');
	ok('html5,techtrend,bbs1' == getCookie('bbslist'));
	saveBbslist('techtrend');
	ok('techtrend:2,html5:1,bbs1:1' == getCookie('bbslist'));
	
});

test('NaN test', function() {
	setCookie('bbslist', 'techtrend:7,,TOOL:NaN,recruit:13,ajax:2,bbs6:8,book:NaN,html5:5,android:2,lifeqna:1,springstudy:Na,lecture:1,bbs1:,docs:,bbs5');
	ok('techtrend:7,,TOOL:NaN,recruit:13,ajax:2,bbs6:8,book:NaN,html5:5,android:2,lifeqna:1,springstudy:Na,lecture:1,bbs1:,docs:,bbs5' == getCookie('bbslist'), 'set test cookie');
	saveBbslist('techtrend');
	ok('recruit:13,techtrend:8,bbs6:8,html5:5,android:2,ajax:2,book:1,TOOL:1,lifeqna:1,springstudy:1,lecture:1,bbs1:1,docs:1,bbs5:1' == getCookie('bbslist'), 'clean up');
	
});

var clearCookie = function(v) {
	setCookie(v, null, -1);
};