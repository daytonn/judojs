require '../lib/judo.rb'

judo = Judo.new
judo.create_project('MyApplication', :expanded, 'fixtures')

test_module_data = <<-FILE
//= require "../elements/test.elements.js"
//= require "../models/test.model.js"

JudoApp.TestModule.actions = function() {
  console.log(JudoApp.TestModule.test_id.html());
};

$(document).ready(function(){
  JudoApp.TestModule.run();
});
   FILE
   
test_global_data = <<-FILE
//= require <utilities/all>
  FILE
   
test_elements_data = <<-FILE
$(document).ready(function() {
	JudoApp.TestModule.test_id = $('#test-element-with-id');
	console.log(JudoApp.TestModule.test_id);
});
   FILE
   
test_model_data = <<-FILE
JudoApp.test_model = {
	some_data_member: 'some data value'
};
   FILE
  
File.open('./fixtures/modules/test.module.js', 'w+') do |mod|
 mod.syswrite(test_module_data)
end

File.open('./fixtures/modules/global.module.js', 'w+') do |mod|
  mod.syswrite(test_global_data)
end

File.open('./fixtures/elements/test.elements.js', 'w+') do |elements|
  elements.syswrite(test_elements_data)
end

File.open('./fixtures/models/test.model.js', 'w+') do |model|
  model.syswrite(test_model_data)
end

judo.compile