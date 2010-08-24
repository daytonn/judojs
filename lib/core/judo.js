//= require "env"

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