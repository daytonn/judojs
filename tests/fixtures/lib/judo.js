if (exists === undefined) {
	function exists(variable) {
		return (variable === undefined) ? false : true;
	}
}

if (!exists(doesNotExist)) {
	function doesNotExist(variable) {
		return exists(variable) ? false : true;
	}
}

if (doesNotExist(isTypeOf)) {
	function isTypeof(type, variable) {
		try {
			if (doesNotExist(type)) {
				throw "type is undefined";
			}
			if (doesNotExist(variable)) {
				throw "variable is undefined";
			}

			return (variable.constructor == type) ? true : false;
		}
		catch(error) {
			alert(error);
		}
	}
}

if (doesNotExist(isNumber)) {
	function isNumber(number) {
		var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
		return pattern.test(number);
	}
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

var JudoModule = function() {};
JudoModule.method('actions', function() {});
JudoModule.method('run', function() {
	this.actions();
});

var JudoApplication = function() {};
JudoApplication.method('Module', function(name) {
	try {
		if (doesNotExist(name)) {
			throw new SyntaxError("Module(): name is undefined");
		}

		if (exists(this[name])) {
			throw new SyntaxError("Module(): " + name + " Module already declared");
		}

		this[name] = new JudoModule();
	}
	catch(error) {
		alert(error.message);
	}
});
