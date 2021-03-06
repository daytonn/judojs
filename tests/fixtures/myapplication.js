//-- Judo Tue Nov 02 20:43:51 -0500 2010  --//
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
			alert(error.message);
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

if (doesNotExist(Function.prototype['method'])) {
	Function.prototype.method = function(name, func) {
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
			alert(error.message);
		}
	};
}

var JudoModule = function() {
	this.data = {};
};

JudoModule.method('actions', function() {});

JudoModule.method('run', function() {
	this.actions();
});

JudoModule.method('setData', function(key, value) {
	try {
		if(doesNotExist(key)) {
			throw new SyntaxError('JudoModule.setData(key, value): key is undefined');
		}
		if(isTypeof(String, key) && doesNotExist(value)) {
			throw new SyntaxError('JudoModule.setData(key, value): value is undefined');
		}

		if(isTypeof(String, key)) {
			this.data[key] = value;
		}
		else if(isTypeof(Object, key)) {
			var data = key;
			for(var property in data) {
				if(!this.data.hasOwnProperty(property)) {
					this.data[property] = key[property];
				}
			}
		}

		return this;
	}
	catch(error) {
		alert(error.message);
		return false;
	}
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
		alert(error.message);
	}
});

var MyApplication = new JudoApplication();