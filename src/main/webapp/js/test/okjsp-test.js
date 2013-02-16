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

var clearCookie = function(v) {
	setCookie(v, null, -1);
};