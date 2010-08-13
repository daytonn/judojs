// null console for shitty browsers
if (window['console'] === undefined) {
	window.console = {
		log: function() {
			return false;
		}
	};
}

function doesNotExist(variable) {
	if (variable === undefined || variable === null) {
		return true;
	}
	return false;
}

function exists(variable) {	
	if (variable === undefined || variable === null) {
		return false;
	}
	return true;
}

function isTypeof(type, variable) {
	try {
		if (doesNotExist(type)) {
			throw "type is undefined";
		}
		if (doesNotExist(variable)) {
			throw "variable is undefined";
		}
		if (variable.constructor == type) {
			return true;
		}
		else {
			return false;
		}
	}
	catch(error) {
		document.writeln(error);
	}
}

function isNumber(number) {
	var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
	return pattern.test(number);
}

if (doesNotExist(Object.prototype['method'])) {
	Object.prototype.method = function(name, func) {
		try {
			if (doesNotExist(name)) {
				throw "You must give a name to the method";
			}
			if (doesNotExist(func)) {
				throw "You must define a function for the method";
			}

			if (doesNotExist(this.prototype[name])) {
				this.prototype[name] = func;
				return this;
			}
		}
		catch(error) {
			alert(error);
		}
	};
}

String.method('is_empty', function() {
	if(this == '' && this.length === 0) {
		return true;
	}
	return false;
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

Array.method('is_empty', function() {
	return (this.length < 1) ? true : false;
});

Array.method('each', function(callback) {
	for(i = 0; i < this.length; i++) {
		callback.call(this, this[i]);
	}
});

Array.method('contains', function(value) {
	for(i = 0; i < this.length; i++) {
		if(this[i] === value) {
			return true;
		}
	}
	return false;
});
