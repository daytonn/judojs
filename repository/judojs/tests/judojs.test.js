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

module("extend tests");

test("can add a method to the prototype", function() {
	ok(exists(Object.prototype.method), "Object.prototype.method is defined");
	
	String.method('test_method', function() {
		return 'This is a test';
	});
	
	equals('Hello'.test_method(), 'This is a test', 'can create a prototype method with method');
});

test("can clone something", function() {
	var object = {
		hello: 'world',
		simple: 'object'
	};

	var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, object, 'one', 'two', 'three', 'four', 'five'];
	
	var clone_object = object.clone();
	var clone_array = array.clone();

	ok(object !== clone_object, 'cloned object is not a reference');
	ok(array !== clone_array, 'cloned array is not a reference');
	
	same(object, clone_object, "object successfully cloned");
	same(array, clone_array, "array successfully cloned");
});

module("Judo application tests");

test("can create a judo application object", function() {
	var MyApp = new JudoApplication();
	ok(exists(MyApp), 'MyApp is defined');
	ok(isTypeof(JudoApplication, MyApp), 'MyApp is a valid JudoApplication');
});

test("can create a JudoModule", function() {
	var MyApp = new JudoApplication();
	MyApp.addModule('Test');
	ok(exists(MyApp.Test), 'MyApp.Test is defined');
	ok(isTypeof(JudoModule, MyApp.Test), 'MyApp.Test is a valid Judo Module');
});

module('Judo Module tests');

test("can add actions to module", function() {
	var MyApp = new JudoApplication();
	MyApp.addModule('Test');
	ok(exists(MyApp.Test.actions), 'MyApp.Test.actions is defined');
	ok(isTypeof(Function, MyApp.Test.actions), "MyApp.Test.actions is a valid Function");
	ok(exists(MyApp.Test.run), 'MyApp.Test.run is defined');
	ok(isTypeof(Function, MyApp.Test.run), "MyApp.Test.run is a valid Function");
	
	MyApp.Test.actions = function() {
		ok(true, 'MyApp.Test.actions ran');
	};
	
	MyApp.Test.run();
});