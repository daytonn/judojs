module("Judo tests");

test("Application sanity check", function() {
	console.log(JudoApp);
	JudoApp.createController('test');
	console.log(JudoApp);
});