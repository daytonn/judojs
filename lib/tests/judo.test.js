module("existence tests");

test("existence sanity check", function() {
	ok(exists !== undefined, 'exists is defined');
	ok(doesNotExist !== undefined, 'doesNotExist is defined');
	ok(isTypeof !== undefined, 'isTypeof is defined');
});

test("can test for existence", function() {
	var nonexistent;
	var existent = 'I think';
	equals(exists(existent), true, 'existent variable exists');
	equals(exists(nonexistent), false, 'non-existent variable does not exist');
});

test("can test for non-existence", function() {
	var existent = 'I think';
	var nonexistent;
	equals(doesNotExist(nonexistent), true, 'non-existent variable does not exist');
	equals(doesNotExist(existent), false, 'existent variable does exist');
});

test("can check the type strictly with isTypeof", function() {
	var foo = function(){};
	var bar = {
		name: 'SomeObject',
		method: function() {}
	};
	var FauxClass = function(){};
	var fauxinstance = new FauxClass();
	equals(isTypeof(Number, 4), true, 'can check against Number');
	equals(isTypeof(String, 'Hello World'), true, 'can check against String');
	equals(isTypeof(Array, ['one', 'two', 'three']), true, 'can check against Array');
	equals(isTypeof(Function, foo), true, 'can check against Function');
	equals(isTypeof(Object, bar), true, 'can check against Object');
	equals(isTypeof(RegExp, /^_*/), true, 'can check against Regexp');
	equals(isTypeof(FauxClass, fauxinstance), true, 'can check against custom object');
});

test("can determine a number", function() {
	ok(isNumber(2), '2 is a number');
	ok(isNumber(-2), '-2 is a number');
	ok(isNumber(45.6), '45.6 is a number');
	ok(isNumber(-45.6), '-45.6 is a number');
	equals(isNumber('45.6'), true, "'45.6 is a number'");
	equals(isNumber('Hello'), false, 'Hello is not a number');
});

module("Judo application tests");

test("can create a judo application object", function() {
	
}); 