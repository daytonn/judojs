var undeclared;
var undefined_var = undefined;
var null_var = null;
var empty_string = '';
var zero = 0;
var false_var = false;
var empty_array = [];
var array = ['one', 'two', 'three'];
var bool = true;
var date = new Date();
var number = 1;
var string = 'Hello World';
var regex = new RegExp(/^test/);
var object = {};
var func = function () {};
var number_string = '56';

module("doesNotExist() tests");

test("Non-existent variable is true", function() {
	equals(doesNotExist(undeclared), true, "Undeclared variable doesn't exist");
	equals(doesNotExist(undefined_var), true, "Undefined variable doesn't exist");
	equals(doesNotExist(null_var), true, "Null variable doesn't exist");
});

test("Existent variable is true", function() {
  equals(doesNotExist(empty_string), false, "Empty string exists" );
	equals(doesNotExist(empty_array), false, "Empty array exists" );
  equals(doesNotExist(zero), false, "Zero exists" );
	equals(doesNotExist(false_var), false ,"False exists");
});

module("exists() tests");

test("Non-existent variable is false", function() {
	equals(exists(undeclared), false, "Undeclared variable doesn't exist");
	equals(exists(undefined_var), false, "Undefined variable doesn't exist");
	equals(exists(null_var), false, "Null variable doesn't exist");
});

test("Existent variable is true", function() {
  equals(exists(empty_string), true, "Empty string exists" );
	equals(exists(empty_array), true, "Empty array exists" );
  equals(exists(zero), true, "Zero exists" );
	equals(exists(false_var), true ,"False exists");
});

module("isTypeof() tests");

test("isType of determines the correct types", function() {	
	equals(isTypeof(Array, array), true, 'isTypeof(Array, array)');
	equals(isTypeof(Boolean, bool), true, "isTypeof(Boolean, bool)");
	equals(isTypeof(Date, date), true, "isTypeof(Date, date)");
	equals(isTypeof(Number, number), true, "isTypeof(Number, number)");
	equals(isTypeof(String, string), true, "isTypeof(String, string)");
	equals(isTypeof(RegExp, regex), true, "isTypeof(RegExp, regex)");
	equals(isTypeof(Object, object), true, "isTypeof(Object, object)");
	equals(isTypeof(Function, func), true, "isTypeof(Function, func)");
	
	equals(isTypeof(Array, func), false, 'isTypeof(Array, func)');
	equals(isTypeof(Boolean, object), false, "isTypeof(Boolean, object)");
	equals(isTypeof(Date, regex), false, "isTypeof(Date, regex)");
	equals(isTypeof(Number, string), false, "isTypeof(Number, string)");
	equals(isTypeof(String, number), false, "isTypeof(String, number)");
	equals(isTypeof(RegExp, date), false, "isTypeof(RegExp, date)");
	equals(isTypeof(Object, func), false, 'isTypeof(Object, func)');
	equals(isTypeof(Function, object), false, 'isTypeof(Function, object)');	
});

module("isNumber() tests");

test("Can determine a number", function() {
	var negative_number = -5;
	var decimal = '23.6';
	var version_number = '0.1.3';
	
	equals(isNumber(number_string), true, "isNumber(number_string)");
	equals(isNumber(string), false, "isNumber(string)");
	equals(isNumber(negative_number), true, "isNumber(negative_number)");
	equals(isNumber(decimal), true, "isNumber(decimal)");
	equals(isNumber(version_number), false, "isNumber(version_number)");
});

module("method() tests");

test("Can create a method", function() {
	Object.method('foo', function () {
		return "Hello World";
	});
	ok(isTypeof(Function, object.foo), "created method foo on Object");
	equals(object.foo(), "Hello World", "object.foo()");
});

module("String tests");

test("Can capitalize a string", function() {
	var string = 'hello world';
	equals(string.capitalize(), 'Hello world', 'string.capitalize()');
});

test("Can reverse a string", function() {
	var string = 'Hello World';
	equals(string.reverse(), 'dlroW olleH', 'string.reverse()');
});

test("Can convert a string to number", function() {
	var number = string.to_n();
	equals(isTypeof(Number, number), true, 'string.to_n()');
});

test("Can test a string for emptiness", function() {
	equals(empty_string.is_empty(), true, "empty_string.is_empty()");
	equals(string.is_empty(), false, "string.is_empty()");
});

module("Array tests");

test("Can test an Array for emptiness", function() {
	equals(empty_array.is_empty(), true, "empty_array.is_empty()");
	equals(array.is_empty(), false, "array.is_empty()");
});

test("Can iterate over an array", function() {
	var test_array = [];
	array.each(function(number) {
		test_array.push(number);
	});
	
	same(test_array, array, "test_array");
});

test("Can test an Array for property", function() {
	ok(array.contains('one'), "array contains one");
	ok(array.contains('two'), "array contains two");
	ok(array.contains('three'), "array contains three");
	equals(array.contains('four'), false, "array.contains('four')");
});