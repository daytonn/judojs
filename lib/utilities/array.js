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
		document.write(error.message);
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