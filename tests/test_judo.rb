require 'test/unit'
require '../lib/judo.rb'

class TC_MyTest < Test::Unit::TestCase
  def setup
   @judo = Judo.new
   
   @test_controller_data = <<-FILE
// @include "plugins/test.plugin.js"

// @include "elements/test.elements.js"
// @include "models/test.model.js"

$(document).ready(function() {
	TestApp.test_id.click(function() {
		alert('this is a dummy function');
		alert(TestApp.test_model.some_data_member);
	});
});
   FILE
   
   @test_elements_data = <<-FILE
$(document).ready(function() {
	TestApp.test_id = $('#test-element-with-id');
	console.log(TestApp.test_id);
});
   FILE
   
   @test_model_data = <<-FILE
TestApp.test_model = {
	some_data_member: 'some data value'
};
   FILE
   
   @test_plugin_data = <<-FILE
(function($) {
    $.fn.testplugin = function(options) {
        var defaults = {};
        var options = $.extend(defaults, options);

        return this.each(function() {

        });
        // End $(this).each()
    };
})(jQuery);
   FILE
  end

  def teardown
#    File.delete('./controllers/test.controller.js')
#    File.delete('./elements/test.elements.js')
#    File.delete('./models/test.model.js')
#    File.delete('./plugins/test.plugin.js')
#    File.delete('./judo.conf')
#    @judo.project_dirs.each do |dir|
#      Dir.delete("#{dir}")
#    end

  end
  
  def test_create_project
    @judo.create_project "TestApp"
    assert_equal(true, true,'true')
    File.open('./controllers/test.controller.js', 'w+') do |controller|
      controller.syswrite(@test_controller_data)
    end
    File.open('./elements/test.elements.js', 'w+') do |elements|
      elements.syswrite(@test_elements_data)
    end
    File.open('./models/test.model.js', 'w+') do |model|
      model.syswrite(@test_model_data)
    end
    File.open('./plugins/test.plugin.js', 'w+') do |model|
      model.syswrite(@test_plugin_data)
    end
  end

  def test_judo_defaults
    assert_equal('0.1.0', @judo.version, 'version is not set correctly')
    assert_equal('/Volumes/Storage/Development/Judo/tests/', @judo.root, 'root is not set correctly')
    assert_equal('/Volumes/Storage/Development/Judo/tests/controllers', @judo.controller_dir, 'controller_dir is not set correctly')
    assert_equal('/Volumes/Storage/Development/Judo/tests/judo.conf', @judo.root + 'judo.conf', 'judo.conf')
  end
  
  def test_get_config
    @judo.get_config
    assert_equal('TestApp', @judo.name, 'name is not set correctly')
    assert_equal('expanded', @judo.output, 'output is not set correctly')
  end
  
  def test_get_directory_contents
     @controllers = @judo.get_directory_contents @judo.controller_dir
      assert_equal('test.controller.js', @controllers[0], 'directory contents are not correct')
  end

  def test_parse_controller
    @controllers = @judo.get_directory_contents @judo.controller_dir
    @parsed_controller = @judo.parse_controller @controllers[0]
  end
  
  def test_remove_extension
    @controllers = @judo.get_directory_contents @judo.controller_dir
    wo_extension = @judo.remove_extension @controllers[0]
    assert_equal('test', wo_extension, 'extension has not been removed properly')
  end
  
  def test_parse_controller
    @controllers = @judo.get_directory_contents @judo.controller_dir
    @parsed_controller = @judo.parse_controller @controllers[0]

    expected_requirements = "plugins/test.plugin.js", "elements/test.elements.js", "models/test.model.js"
    assert_equal(expected_requirements, @parsed_controller[0], 'the requirements are not parsed correctly')
  end
  
  def test_create_tmp_controller
    @controllers = @judo.get_directory_contents @judo.controller_dir
    @parsed_controller = @judo.parse_controller @controllers[0]
    assert_nothing_raised do
      @judo.create_tmp_controller @parsed_controller[1]
    end
  end
    
  def test_compile
    assert_nothing_raised do
      @judo.compile
    end
  end
end