test( "hello test", function() {
	  ok( 1 == "1", "Passed!" );
	  ok( 2 == "2", "Passed!" );
	});
	
module( 'Module One', {
    setup: function() {
    	clearTestCookie();
    },
    teardown: function() {
    	clearTestCookie();
    }
});
var clearTestCookie = function() {
	clearCookie(key);
	ok('' == getCookie(key), 'setup() clear cookie');
} 
var key = 'bbslisttest';
test("okjsp.js saveBbslist", function() {	
	saveBbslist(key, "techtrend");
	ok('techtrend:1' == getCookie(key), 'save one');

	clearCookie(key);
	saveBbslist(key, "techtrend");
	saveBbslist(key, "techtrend");
	ok('techtrend:2' == getCookie(key), 'save twice');

	clearCookie(key);
	saveBbslist(key, "techtrend");
	saveBbslist(key, "html5");
	ok('techtrend:1,html5:1' == getCookie(key), 'save other');
	
	clearCookie(key);
	saveBbslist(key, "techtrend");
	saveBbslist(key, "techtrend");
	saveBbslist(key, "html5");
	ok('techtrend:2,html5:1' == getCookie(key), 'save 2 and 1');
	
	var array = 'html5:2,techtrend:1'.split(',');
	array.sort(function(a, b) {
		return parseInt(b.split(':')[1]) - parseInt(a.split(':')[1])
	});
	ok('html5:2'== array[0], 'array sort test');
	
	clearCookie(key);
	saveBbslist(key, "techtrend");
	saveBbslist(key, "html5");
	saveBbslist(key, "html5");
	ok('html5:2,techtrend:1' == getCookie(key), 'sort list');

	clearCookie(key);
	saveBbslist(key, "techtrend");
	saveBbslist(key, "html5");
	saveBbslist(key, "html5");
	saveBbslist(key, "bbs1");
	var str = getCookie(key);
	ok('html5:2,techtrend:1,bbs1:1' == str, 'three and sort');
});

test('migration test', function() {
	setCookie(key, 'html5,techtrend,bbs1');
	ok('html5,techtrend,bbs1' == getCookie(key));
	saveBbslist(key, 'techtrend');
	ok('techtrend:2,html5:1,bbs1:1' == getCookie(key));
});

test('NaN test', function() {
	setCookie(key, 'techtrend:7,,TOOL:NaN,recruit:13,ajax:2,bbs6:8,book:NaN,html5:5,android:2,lifeqna:1,springstudy:Na,lecture:1,bbs1:,docs:,bbs5');
	ok('techtrend:7,,TOOL:NaN,recruit:13,ajax:2,bbs6:8,book:NaN,html5:5,android:2,lifeqna:1,springstudy:Na,lecture:1,bbs1:,docs:,bbs5' == getCookie(key), 'set test cookie');
	saveBbslist(key, 'techtrend');
	ok('recruit:13,techtrend:8,bbs6:8,html5:5,android:2,ajax:2,book:1,TOOL:1,lifeqna:1,springstudy:1,lecture:1,bbs1:1,docs:1,bbs5:1' == getCookie(key), 'clean up');
});

var clearCookie = function(v) {
	setCookie(v, null, -1);
};