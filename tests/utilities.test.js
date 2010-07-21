module("doesNotExist() tests");

test("Non-existent variable is true", function() {
	var undeclared;
	var undefined_var = undefined;
	var null_var = null;
	equals(doesNotExist(undeclared), true, "Undeclared variable doesn't exist");
	equals(doesNotExist(undefined_var), true, "Undefined variable doesn't exist");
	equals(doesNotExist(null_var), true, "Null variable doesn't exist");
});

module("exists() tests");

test("Non-existent variable is false", function() {
	var undeclared;
	var undefined_var = undefined;
	var null_var = null;
	equals(exists(undeclared), false, "Undeclared variable doesn't exist");
	equals(exists(undefined_var), false, "Undefined variable doesn't exist");
	equals(exists(null_var), false, "Null variable doesn't exist");
});

test("Existent variable is true", function() {
	var empty_string = '';
	var zero = 0;
	var false_var = false;
	var empty_array = [];
  equals(exists(empty_string), true, "Empty string exists" );
	equals(exists(empty_array), true, "Empty array exists" );
  equals(exists(zero), true, "Zero exists" );
	equals(exists(false_var), true ,"False exists");
});

module("is_a() tests");

test("get tests", function() {
	var array = [];
	var bool = true;
	var date = new Date();
	var number = 1;
	var string = 'Hello World';
	var regex = new RegExp(/^test/);
	var object = {};
	var func = function() {
		document.writeln('Hello World');
	};
	equals(array.is_a(), 'Array', "array.is_a()");
	equals(bool.is_a(), 'Boolean', "bool.is_a()");
	equals(date.is_a(), 'Date', "date.is_a()");
	equals(number.is_a(), 'Number', "number.is_a()");
	equals(string.is_a(), 'String', "string.is_a()");
	equals(regex.is_a(), 'RegExp', "regex.is_a()");
	equals(object.is_a(), 'Object', "object.is_a()");
	equals(func.is_a(), 'Function', "func.is_a()");
});

test("expected tests", function() {
	var array = [];
	var bool = true;
	var date = new Date();
	var number = 1;
	var string = 'Hello World';
	var regex = new RegExp(/^test/);
	var object = {};
	var func = function() {
		document.writeln('Hello World');
	};
	equals(array.is_a('Array'), true, "array.is_a('Array')");
	equals(array.is_a('Boolean'), false, "array.is_a('Boolean')");
	equals(array.is_a('Date'), false, "array.is_a('Date')");
	equals(array.is_a('Number'), false, "array.is_a('Number')");
	equals(array.is_a('String'), false, "array.is_a('String')");
	equals(array.is_a('RegExp'), false, "array.is_a('RegExp')");
	equals(array.is_a('Object'), false, "array.is_a('Object')");
	equals(array.is_a('Function'), false, "array.is_a('Function')");
	
	equals(bool.is_a('Array'), false, "bool.is_a('Array') is false");
	equals(bool.is_a('Boolean'), true, "bool.is_a('Boolean') is true");
	equals(bool.is_a('Date'), false, "bool.is_a('Date') is false");
	equals(bool.is_a('Number'), false, "bool.is_a('Number') is false");
	equals(bool.is_a('String'), false, "bool.is_a('String') is false");
	equals(bool.is_a('RegExp'), false, "bool.is_a('RegExp') is false");
	equals(bool.is_a('Object'), false, "bool.is_a('Object') is false");
	equals(bool.is_a('Function'), false, "bool.is_a('Function') is false");
	
	equals(date.is_a('Array'), false, "date.is_a('Array')");
	equals(date.is_a('Boolean'), false, "date.is_a('Boolean')");
	equals(date.is_a('Date'), true, "date.is_a('Date')");
	equals(date.is_a('Number'), false, "date.is_a('Number')");
	equals(date.is_a('String'), false, "date.is_a('String')");
	equals(date.is_a('RegExp'), false, "date.is_a('RegExp')");
	equals(date.is_a('Object'), false, "date.is_a('Object')");
	equals(date.is_a('Function'), false, "date.is_a('Function')");
	
	equals(number.is_a('Array'), false, "number.is_a('Array')");
	equals(number.is_a('Boolean'), false, "number.is_a('Boolean')");
	equals(number.is_a('Date'), false, "number.is_a('Date')");
	equals(number.is_a('Number'), true, "number.is_a('Number')");
	equals(number.is_a('String'), false, "number.is_a('String')");
	equals(number.is_a('RegExp'), false, "number.is_a('RegExp')");
	equals(number.is_a('Object'), false, "number.is_a('Object')");
	equals(number.is_a('Function'), false, "number.is_a('Function')");
	
	equals(string.is_a('Array'), false, "string.is_a('Array')");
	equals(string.is_a('Boolean'), false, "string.is_a('Boolean')");
	equals(string.is_a('Date'), false, "string.is_a('Date')");
	equals(string.is_a('Number'), false, "string.is_a('Number')");
	equals(string.is_a('String'), true, "string.is_a('String')");
	equals(string.is_a('RegExp'), false, "string.is_a('RegExp')");
	equals(string.is_a('Object'), false, "string.is_a('Object')");
	equals(string.is_a('Function'), false, "string.is_a('Function')");
	
	equals(regex.is_a('Array'), false, "regex.is_a('Array')");
	equals(regex.is_a('Boolean'), false, "regex.is_a('Boolean')");
	equals(regex.is_a('Date'), false, "regex.is_a('Date')");
	equals(regex.is_a('Number'), false, "regex.is_a('Number')");
	equals(regex.is_a('String'), false, "regex.is_a('String')");
	equals(regex.is_a('RegExp'), true, "regex.is_a('RegExp')");
	equals(regex.is_a('Object'), false, "regex.is_a('Object')");
	equals(regex.is_a('Function'), false, "regex.is_a('Function')");
	
	equals(object.is_a('Array'), false, "object.is_a('Array')");
	equals(object.is_a('Boolean'), false, "object.is_a('Boolean')");
	equals(object.is_a('Date'), false, "object.is_a('Date')");
	equals(object.is_a('Number'), false, "object.is_a('Number')");
	equals(object.is_a('String'), false, "object.is_a('String')");
	equals(object.is_a('RegExp'), false, "object.is_a('RegExp')");
	equals(object.is_a('Object'), true, "object.is_a('Object')");
	equals(object.is_a('Function'), false, "object.is_a('Function')");
	
	equals(func.is_a('Array'), false, "func.is_a('Array')");
	equals(func.is_a('Boolean'), false, "func.is_a('Boolean')");
	equals(func.is_a('Date'), false, "func.is_a('Date')");
	equals(func.is_a('Number'), false, "func.is_a('Number')");
	equals(func.is_a('String'), false, "func.is_a('String')");
	equals(func.is_a('RegExp'), false, "func.is_a('RegExp')");
	equals(func.is_a('Object'), false, "func.is_a('Object')");
	equals(func.is_a('Function'), true, "func.is_a('Function')");
});

module("is_empty() tests");

test("Can test a string for emptiness", function() {
	var empty_string = "";
	var string = "Hello World";
	equals(empty_string.is_empty(), true, "empty_string.is_empty()");
	equals(string.is_empty(), false, "string.is_empty()");
});

test("Can test an Array for emptiness", function() {
	var empty_array = [];
	var array = ['one', 'two', 'three'];
	equals(empty_array.is_empty(), true, "empty_array.is_empty()");
	equals(array.is_empty(), false, "array.is_empty()");
});

test("Can test an Object for emptiness", function() {
	var empty_object = {};

	var object = {
		"one": 1,
		"two": 2,
		"three": 3
	};
		
	equals(empty_object.is_empty(), true, 'empty_object.is_empty()');
	equals(object.is_empty(), false, 'object.is_empty()');
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
	var string = '56';
	var number = string.to_n();
	equals(number.is_a(), 'Number', 'string.to_n()');
});