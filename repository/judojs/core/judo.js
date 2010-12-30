//= require "extend"

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
