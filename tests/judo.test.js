module("Judo tests");

test("Application sanity check", function() {
	ok(exists(JudoApp), 'JudoApp exists');
	ok(isTypeof(JudoApplication, JudoApp), 'judoapp is a valid JudoApplication');
	ok(isTypeof(Function, JudoApp.Module), 'JudoApp.Module is a valid function');
	
	ok(exists(JudoApp.TestModule), 'JudoApp.TestModule exists');
	ok(exists(JudoApp.TestModule.test_id), 'JudoApp.TestModule.test_id exists');
	ok(JudoApp.TestModule.test_id.length > 0, 'JudoApp.TestModule.test_id.length is greater than 0');
	ok(exists(JudoApp.test_model), "JudoApp.test_model exists");
	ok(exists(JudoApp.test_model.some_data_member), 'JudoApp.test_model.some_data_member exists')
	equals(JudoApp.test_model.some_data_member, 'some data value' , 'JudoApp.test_model.some_data_member is set correctly');
});