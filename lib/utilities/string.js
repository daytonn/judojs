String.method('is_empty', function() {
	if(this == '' && this.length === 0) {
		return true;
	}
	return false;
});

String.method('is_number', function() {
	var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
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
	for (var i = 0; i < this.length; i++) {
		callback.call(this, this[i]);
	}
});

String.method('capitalize', function() {
	return this.substr(0, 1).toUpperCase() + this.substr(1);
});

String.method('include', function(callback) {
	for (var i = 0; i < this.length; i++) {
		callback.call(this, this[i]);
	}
});

String.method('reverse', function() {
	var reversed_string = '';
	for (var i = this.length - 1; i >= 0; i--) {
		reversed_string += this.charAt(i);
	}
	return reversed_string;
});

String.method('to_n', function() {
	return parseInt(this, 10);
});

String.method('pluck', function(needle) {
	this.replace(needle, '');
})