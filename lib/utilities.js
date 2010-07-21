//
//  utilites
//
//  Created by Dayton Nolan on 2010-05-03.
//  Copyright (c) 2010 Magic Beans Software. All rights reserved.
//

// null console for browsers without one
if (window['console'] === undefined) {
	window.console = {
		log: function(message) {
			// Do nothing -DN
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

if (doesNotExist(Function.prototype['method'])) {
	Function.prototype.method = function(name, func) {
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

Function.method('curry', function() {
	var slice = Array.prototype.slice;
	var args = slice.apply(arguments);
	var self = this;
	return function() {
		return self.apply(null, args.concat(slice.apply(arguments)));
	};
});

Object.method('is_a', function(expected) {
	var types = {
		"Array": Array,
		"Boolean": Boolean,
		"Date": Date,
		"Number": Number,
		"String": String,
		"RegExp": RegExp,
		"Function": Function,
		"Object": Object
	};
		
	if (!exists(expected)) {
		for (var type in types) {
			if (isTypeof(types[type], this)) {
				return type;
			}
		}
		return undefined;
	}
	else {
		try {
			var is_valid_type = false;
			for (var actual_type in types) {
				if (expected === actual_type) {
					is_valid_type = true;
				}
				
			}
			if (!is_valid_type) {
				throw expected + " is not a valid type";
			}
			
			return isTypeof(types[expected], this);
		}
		catch(error) {
			document.writeln(error);
		}
	}
});

Object.method('is_empty' , function() {
	for (var property in this) {
		if (this.hasOwnProperty(property)) {
			return false;
		}
		return true;
	}
});

Array.method('is_empty', function(expected) {
	return (this.length < 1) ? true : false;
});

String.method('is_empty', function(expected) {
	return (this == '') ? true : false;
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
		reversed_string += this[i];
	}
	return reversed_string;
});

String.method('to_n', function() {
	return parseInt(this, 10);
});