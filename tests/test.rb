require '../lib/judo.rb'

judo = Judo.new
judo.create_project('MyApplication', :expanded, 'fixtures')

test_module_data = <<-FILE
// @module TestModule
// @include "plugins/test.plugin.js"

// @include "elements/test.elements.js"
// @include "models/test.model.js"

JudoApp.TestModule.actions = function() {
  console.log(JudoApp.TestModule.test_id.html());
};

$(document).ready(function(){
  JudoApp.TestModule.run();
});
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
   
test_plugin_data = <<-FILE
(function($) {
    $.fn.testplugin = function(options) {
        var defaults = {};
        var options = $.extend(defaults, options);

        return this.each(function() {
          console.log(this);
        });
        // End $(this).each()
    };
})(jQuery);
   FILE
  
File.open('./fixtures/modules/test.module.js', 'w+') do |mod|
  mod.syswrite(test_module_data)
end
File.open('./fixtures/elements/test.elements.js', 'w+') do |elements|
  elements.syswrite(test_elements_data)
end
File.open('./fixtures/models/test.model.js', 'w+') do |model|
  model.syswrite(test_model_data)
end
File.open('./fixtures/plugins/test.plugin.js', 'w+') do |model|
  model.syswrite(test_plugin_data)
end

judo.compile