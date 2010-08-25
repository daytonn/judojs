module("string utility tests");

test("can test for emptiness", function() {
	ok(''.is_empty(), "''.is_empty() string is true");
	equals('hey there'.is_empty(), false, "'hey there'.is_empty() is false");
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
	'123'.each(function(character, n) {
		if(n == 0) {
			equals(character, '1', 'first character of 123 is 1');
		}
		if(n == 1) {
			equals(character, '2', 'second character of 123 is 2');
		}
		if(n == 2) {
			equals(character, '3', 'second character of 123 is 3');
		}
		iteration_count++;
	});
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