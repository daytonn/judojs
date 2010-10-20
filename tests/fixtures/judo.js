if (exists === undefined) {
	var exists = function(variable) {
		return (variable === undefined) ? false : true;
	};
}

if (!exists(doesNotExist)) {
	var doesNotExist = function(variable) {
		return (variable === undefined) ? true : false;
	};
}

if (doesNotExist(isTypeof)) {
	var isTypeof = function(type, variable) {
		try {
			if (doesNotExist(type)) {
				throw new SyntaxError("isTypeof(Type, variable): type is undefined");
			}
			if (doesNotExist(variable)) {
				throw new SyntaxError("isTypeof(Type, variable): variable is undefined");
			}

			return (variable.constructor == type) ? true : false;
		}
		catch(error) {
			document.write(error.message);
		}
	};
}

if (doesNotExist(isNumber)) {
	var isNumber = function(suspect) {
		if(isTypeof(Number, suspect)) {
			return true;
		}
		else {
			var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
			return pattern.test(suspect);
		}
	};
}

if (doesNotExist(Object.prototype['method'])) {
	Object.prototype.method = function(name, func) {
		try {
			if (doesNotExist(name)) {
				throw new SyntaxError("Object.method(name, func): name is undefined");
			}
			if (doesNotExist(func)) {
				throw new SyntaxError("Object.method(name, func): func is undefined");
			}

			if (doesNotExist(this.prototype[name])) {
				this.prototype[name] = func;
				return this;
			}
		}
		catch(error) {
			document.write(error.message);
		}
	};
}

if (doesNotExist(Object.prototype['clone'])) {
	Object.method('clone', function() {
		if (typeof this !== 'object' || this === null) {
			return this;
		}

        if (this instanceof Node || this instanceof NodeList || this instanceof NamedNodeMap) {
            die('You cannot clone a Node, Nodelist or NamedNodeMap');
        }

		var clone = isTypeof(Array, this) ? [] : {};

		for(var prop in this) {
			if(this.hasOwnProperty(prop)) {
				clone[prop] = this[prop];
			}
		}

		return clone;
	});
}

var JudoModule = function() {};
JudoModule.method('actions', function() {});
JudoModule.method('run', function() {
	this.actions();
});

var JudoApplication = function() {};

JudoApplication.method('addModule', function(name) {
	try {
		if (doesNotExist(name)) {
			throw new SyntaxError("JudoApplication.addModule(name): name is undefined");
		}

		if (exists(this[name])) {
			throw new SyntaxError("JudoApplication.addModule(name): '" + name + "' already declared");
		}

		this[name] = new JudoModule();
	}
	catch(error) {
		document.write(error.message);
	}
});
