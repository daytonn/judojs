/*
	Base.js, version 1.1a
	Copyright 2006-2009, Dean Edwards
	License: http://www.opensource.org/licenses/mit-license.php
*/

var Base = function() {
	// dummy
};

Base.extend = function(_instance, _static) { // subclass
	var extend = Base.prototype.extend;
	
	// build the prototype
	Base._prototyping = true;
	var proto = new this;
	extend.call(proto, _instance);
  proto.base = function() {
    // call this method from any other method to invoke that method's ancestor
  };
	delete Base._prototyping;
	
	// create the wrapper for the constructor function
	//var constructor = proto.constructor.valueOf(); //-dean
	var constructor = proto.constructor;
	var klass = proto.constructor = function() {
		if (!Base._prototyping) {
			if (this._constructing || this.constructor == klass) { // instantiation
				this._constructing = true;
				constructor.apply(this, arguments);
				delete this._constructing;
			} else if (arguments[0] != null) { // casting
				return (arguments[0].extend || extend).call(arguments[0], proto);
			}
		}
	};
	
	// build the class interface
	klass.ancestor = this;
	klass.extend = this.extend;
	klass.forEach = this.forEach;
	klass.implement = this.implement;
	klass.prototype = proto;
	klass.toString = this.toString;
	klass.valueOf = function(type) {
		//return (type == "object") ? klass : constructor; //-dean
		return (type == "object") ? klass : constructor.valueOf();
	};
	extend.call(klass, _static);
	// class initialisation
	if (typeof klass.init == "function") klass.init();
	return klass;
};

Base.prototype = {	
	extend: function(source, value) {
		if (arguments.length > 1) { // extending with a name/value pair
			var ancestor = this[source];
			if (ancestor && (typeof value == "function") && // overriding a method?
				// the valueOf() comparison is to avoid circular references
				(!ancestor.valueOf || ancestor.valueOf() != value.valueOf()) &&
				/\bbase\b/.test(value)) {
				// get the underlying method
				var method = value.valueOf();
				// override
				value = function() {
					var previous = this.base || Base.prototype.base;
					this.base = ancestor;
					var returnValue = method.apply(this, arguments);
					this.base = previous;
					return returnValue;
				};
				// point to the underlying method
				value.valueOf = function(type) {
					return (type == "object") ? value : method;
				};
				value.toString = Base.toString;
			}
			this[source] = value;
		} else if (source) { // extending with an object literal
			var extend = Base.prototype.extend;
			// if this object has a customised extend method then use it
			if (!Base._prototyping && typeof this != "function") {
				extend = this.extend || extend;
			}
			var proto = {toSource: null};
			// do the "toString" and other methods manually
			var hidden = ["constructor", "toString", "valueOf"];
			// if we are prototyping then include the constructor
			var i = Base._prototyping ? 0 : 1;
			while (key = hidden[i++]) {
				if (source[key] != proto[key]) {
					extend.call(this, key, source[key]);

				}
			}
			// copy each of the source object's properties to this object
			for (var key in source) {
				if (!proto[key]) extend.call(this, key, source[key]);
			}
		}
		return this;
	}
};

// initialise
Base = Base.extend({
	constructor: function() {
		this.extend(arguments[0]);
	}
}, {
	ancestor: Object,
	version: "1.1",
	
	forEach: function(object, block, context) {
		for (var key in object) {
			if (this.prototype[key] === undefined) {
				block.call(context, object[key], key, object);
			}
		}
	},
		
	implement: function() {
		for (var i = 0; i < arguments.length; i++) {
			if (typeof arguments[i] == "function") {
				// if it's a function, call it
				arguments[i](this.prototype);
			} else {
				// add the interface using the extend method
				this.prototype.extend(arguments[i]);
			}
		}
		return this;
	},
	
	toString: function() {
		return String(this.valueOf());
	}
});
//
//  utilites
//
//  Created by Dayton Nolan on 2010-05-03.
//  Copyright (c) 2010 Magic Beans Software. All rights reserved.
//

// null console for browsers without one
if(window['console'] === undefined) {
	window.console = {
		log: function(message) {
			// Do nothing -DN
		}
	};
}

function isTypeof(type, variable) {
	try {
		if (arguments.length < 2) {
			throw "you must provide 2 arguments: isTypeof(variable, type)";
		}
	}
	catch(error) {
		handleError(error);
	}

	if (variable === null && type === null) {
		return true;
	} else if (variable === undefined && type === undefined) {
		return true;
	} else if (variable.constructor == type) {
		return true;
	} else {
		return false;
	}
}



function areTypesof(variables, types) {
	var len = variables.length;
	var valid = true;
	var errors = [];
	for (i = 0; i < len; i++) {
		if (!isTypeof(variables[i], types[i])) {
			valid = false;
			errors.push("Argument " + i + "is not " + types[i]);
		}
	}
	if (errors.length > 0) {
		alert(errors.join("\n"));
	}
}



function exists(variable) {
	var exists = true;

	if (variable === undefined) {
		exists = false;
	} else if (variable === null) {
		exists = false;
	}

	return exists;
}



function notEmpty(array) {
	return (array.length > 0) ? true : false;
}



function isEmpty(array) {
	return (array.length < 1) ? true : false;
}



function handleError(options) {
	var settings = {
		error: false,
		mode: 'strict'
	};

	for (var setting in options) {
		settings[setting] = options[setting];
	}

	if (!settings.error) {
		alert('handleError(): error is undefined');
	}

	if (settings.mode === 'log') {
		console.log(settings.error);
	} else if (settings.mode === 'strict') {
		alert(setting.error);
	}
}



function fails(func) {
	try {
		func.call(this);
		return false;
	}
	catch(error) {
		return true;
	}
}
// (original makeClass - By John Resig (MIT Licensed))
function JudoClass() {
	return function(args) {
		if(!(this instanceof arguments.callee)) {
			return new arguments.callee(arguments);
		}
		else {
			if(typeof this.init == "function") {
				this.init.apply(this, args.callee ? args : arguments);
			}
		}
	};
}

Judo = new JudoClass();

Judo.prototype.init = function() {
	this.version = '0.1.0';
	this.v = this.version;
};var  = {
	version: '0.1.0'
};