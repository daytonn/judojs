//= require "extend"

var JudoModule = function(name) {
	this.data = {};
	this.run_tests = false;
	this.tests = [];
	this.name = name;
};

JudoModule.method('actions', function() {});

JudoModule.method('addTest', function(test_file) {
	this.tests.push(test_file);
});

JudoModule.method('_runTests', function() {
	var test_template = [];
	test_template.push('<div class="test-results" title="Test Results">');
	test_template.push('<h1 id="qunit-header">' + this.name + ' module tests</h1>');
	test_template.push('<h2 id="qunit-banner"></h2>');
	test_template.push('<h2 id="qunit-userAgent"></h2>');
	test_template.push('<ol id="qunit-tests"></ol>');
	test_template.push('</div>');
	
	$('body').append(test_template.join("\n"));
	
	this.tests.each(function(test) {
		$.getScript('http://localhost/jexample/js/tests/some.test.js', function() {
			var test_results_dialog = $('.test-results');
			var height = test_results_dialog.height() + 130;
			var width = $(window).width() - 300;
			var maxHeight = $(window).height() - 200;
			try {
				test_results_dialog.dialog({
					width: width,
					height: height,
					maxHeight: maxHeight,
					buttons: {
						"Thanks buddy": function() {
							test_results_dialog.dialog('close');
						}
					}
				});
			}
			catch(error) {
				alert("Test harness requires jQueryUI");
			}
		});
	});
});

JudoModule.method('run', function() {
	if(this.run_tests) {
		this._runTests();
	}
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
