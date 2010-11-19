Array.method('is_empty', function() {
	return (this.length < 1) ? true : false;
});

Array.method('not_empty', function() {
	return (this.length > 0) ? true : false;
});

Array.method('each', function(callback) {
	try {
		if(doesNotExist(callback)) {
			throw new SyntaxError("Array.each(callback): callback is undefined");
		}

		for (var i = 0; i < this.length; i++) {
			var args = [this[i], i];
			callback.apply(this, args);
		}
	}
	catch(error) {
		alert(error.message);
	}
});

Array.method('contains', function(suspect) {
	var matches = [];
	this.each(function(value, index) {
		if(value === suspect) {
			matches.push(index);
		}
	});

	return matches.not_empty() ? matches : false;
});
String.method('is_empty', function() {
	return (this == '') ? true : false;
});

String.method('not_empty', function() {
	return (this == '') ? false : true;
});

String.method('is_number', function() {
	var pattern = /^(\.|-)?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
	return pattern.test(this);
});

String.method('trim', function() {
	return this.replace(/^\s+|\s+$/g, "");
});

String.method('ltrim', function() {
	return this.replace(/^\s+/,"");
});

String.method('rtrim', function() {
	return this.replace(/\s+$/,"");
});

String.method('each', function(callback) {
	try {
		if(doesNotExist(callback)) {
			throw new SyntaxError("String.each(callback): callback is undefined");
		}

		for (var i = 0; i < this.length; i++) {
			var args = [this.charAt(i), i];
			callback.apply(this, args);
		}
	}
	catch(error) {
		alert(error.message);
	}
});

String.method('capitalize', function() {
	return this.substr(0, 1).toUpperCase() + this.substr(1);
});

String.method('reverse', function() {
	return this.split('').reverse().join('');
});

String.method('to_n', function() {
	return parseFloat(this);
});

String.method('pluck', function(needle) {
	var pattern = new RegExp(needle, 'g');
	return this.replace(pattern, '');
});

String.method('single_space', function() {
	var no_hard_spaces = this.replace(/\&nbsp\;/g, ' ');
	return no_hard_spaces.replace(/\s+/g, ' ');
});

String.method('compress', function() {
	return this.replace(/\s+/g, '');
});
