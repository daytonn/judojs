module("array utility tests");

test("can test for emptiness", function() {
	expect(4);
	
	ok([].is_empty(), "[].is_empty() is true");
	equals(['one', 'two', 'three'].is_empty(), false, "['one', 'two', 'three'].is_empty()");
	ok(['one', 'two', 'three'].not_empty(), "['one', 'two', 'three'].not_empty() is false");
	equals([].not_empty(), false, "[].not_empty() is false");
});

test("can iterate over each element", function() {
	expect(7);
	
	var iteration_count = 0;
	var test_array_values = [];
	var test_array_indices = [];
	
	['one', 'two', 'three'].each(function(value, index) {
		iteration_count++;
		test_array_values.push(value);
		test_array_indices.push(index);
	});
	
	equals(test_array_values[0], 'one', 'value at index 0 is correct');
	equals(test_array_values[1], 'two', 'value at index 1 is correct');
	equals(test_array_values[2], 'three', 'value at index 2 is correct');

	equals(test_array_indices[0], 0, 'first index is correct');
	equals(test_array_indices[1], 1, 'second index is correct');
	equals(test_array_indices[2], 2, 'third index is correct');
	
	equals(iteration_count, 3, 'made only three iterations');
});

test("can test if an array contains an element", function() {
	var array = ['one', 'two', 'three'];
	var string = 'hello';
	var object = {
		name: 'some object'
	};
	var number = 45;
	var date = new Date();
	
	var test_array = [array, string, object, number, date];
	
	ok(test_array.contains(array), 'array.contains(array)');
	ok(test_array.contains(string), 'array.contains(string)');
	ok(test_array.contains(object), 'array.contains(object)');
	ok(test_array.contains(number), 'array.contains(number)');
	ok(test_array.contains(date), 'array.contains(date)');
	equals(test_array.contains('not in there'), false, 'non-existent value is false');
});

test("can shuffle an array", function() {
	var array = [1, 2, 3, 4, 5, 6, 7, 8, 9];
	ok(array != [1, 2, 3, 4, 5, 6, 7, 8, 9], "array is shuffled");	
	same(array, [1, 2, 3, 4, 5, 6, 7, 8, 9], 'array is not altered');
});

module("string utility tests");

test("can test for emptiness", function() {
	ok(''.is_empty(), "''.is_empty() is true");
	equals('hey there'.is_empty(), false, "'hey there'.is_empty() is false");
	ok('hey there'.not_empty(), "'hey there'.not_empty() is false");
	equals(''.not_empty(), false, "''.not_empty() is false");
});

test('can test for number', function() {
	equals('34'.is_number(), true, "34 is a number");
	equals('0.5'.is_number(), true, ".5 is a number");
	equals('-34'.is_number(), true, '-34 is a number');
	equals('-0.5'.is_number(), true, '-.05 is a number');
	equals('hello'.is_number(), false, 'hello is not a number');
});

test('can trim a string', function() {
	equals(' hello '.trim(), 'hello', "' hello '.trim()");
	equals(' hello '.ltrim(), 'hello ', "' hello '.ltrim()");
	equals(' hello '.rtrim(), ' hello', "' hello '.rtrim()");
});

test("can iterate over each character", function() {
	var iteration_count = 0;
	var test_chars = [];
	var test_indices = [];
	'123'.each(function(character, index) {
		test_chars.push(character);
		test_indices.push(index);
		iteration_count++;
	});
	
	equals(test_chars[0], '1', 'first character of 123 is 1');
	equals(test_chars[1], '2', 'second character of 123 is 2');
	equals(test_chars[2], '3', 'second character of 123 is 3');
	
	equals(test_indices[0], 0, 'first index is correct');
	equals(test_indices[1], 1, 'second index is correct');
	equals(test_indices[2], 2, 'third index is correct');
	
	equals(iteration_count, 3, 'made only three iterations');
});

test('can capitalize a string', function() {
	equals('hello world'.capitalize(), 'Hello world', 'capitalized string correctly');
});

test('can reverse a string', function() {
	equals('hello world'.reverse(), 'dlrow olleh', 'reversed string correctly');
	equals('satan oscillate my metallic sonatas'.reverse(), 'satanos cillatem ym etallicso natas', 'fucking palindromes, how do they work?');
});

test("can convert to number", function() {
	var whole_number = '32';
	var decimal = '0.08';
	var negative_number = '-32';
	var negative_float = '-0.08';
	
	same(whole_number.to_n(), 32, "whole_number.to_n() is 32");
	same(decimal.to_n(), 0.08, "decimal.to_n() is 0.08");
	same(negative_number.to_n(), -32, "negative_number.to_n() is -32");
	same(negative_float.to_n(), -0.08, "negative_float.to_n() -0.08");
}); 

test("can pluck a string", function() {
	equals('one, two, three'.pluck(','), 'one two three', "'one, two, three'.pluck(',')");
});

test("can single space a string", function() {
	var hard_space = 'one&nbsp;two&nbsp;&nbsp;three&nbsp;&nbsp;&nbsp;four&nbsp;&nbsp;&nbsp;&nbsp;five&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;six';
	var soft_space = 'one two  three   four    five     six';
	var mixed_space = 'one two &nbsp; three &nbsp;&nbsp;four &nbsp;&nbsp;&nbsp;five &nbsp;&nbsp;&nbsp;&nbsp;six';
	
	equals(hard_space.single_space(), 'one two three four five six', 'correctly spaced &nbsp;');
	equals(soft_space.single_space(), 'one two three four five six', "correctly spaced soft spaces");
	equals(mixed_space.single_space(), 'one two three four five six', "correctly spaced mixed spaces");
});

test("can compress a string", function() {
	var string = "satan\n\t oscillate\n\t my\n\t metallic\n sonatas";
	same(string.compress(), 'satanoscillatemymetallicsonatas', "string is compressed correctly");
});

test("can shuffle a string", function() {
	var string = 'Hello World';
	ok('Hello World' != string.shuffle(), "string is shuffled");
	same(string, 'Hello World', 'array is not altered');
}); 