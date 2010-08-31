$(document).ready(function() {
	JudoApp.TestModule.test_id = $('#test-element-with-id');
	console.log(JudoApp.TestModule.test_id);
});
JudoApp.test_model = {
	some_data_member: 'some data value'
};

JudoApp.TestModule.actions = function() {
  console.log(JudoApp.TestModule.test_id.html());
};

$(document).ready(function(){
  JudoApp.TestModule.run();
});
