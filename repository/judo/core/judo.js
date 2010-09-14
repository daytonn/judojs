//= require "extend"

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