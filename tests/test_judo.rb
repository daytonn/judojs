require 'test/unit'
require '../lib/judo.rb'

class TC_MyTest < Test::Unit::TestCase
  def setup
   @judo = Judo.new
   @controllers = @judo.get_directory_contents @judo.controller_dir
   @parsed_controller = @judo.parse_controller @controllers[0]
  end

  def teardown
    
  end

  def test_judo_defaults
    assert_equal('0.1.0', @judo.version, 'version is not set correctly')
    assert_equal('/Volumes/Storage/Development/judo/tests/', @judo.root, 'root is not set correctly')
    assert_equal('/Volumes/Storage/Development/judo/tests/application/controllers', @judo.controller_dir, 'controller_dir is not set correctly')
    assert_equal('/Volumes/Storage/Development/judo/tests/judo.yml', @judo.root + 'judo.yml', 'judo.yml is not fuck')
  end
  
  def test_get_config
    @judo.get_config
    assert_equal('JudoApp', @judo.name, 'name is not set correctly')
    assert_equal('expanded', @judo.output, 'output is not set correctly')
  end
  
  def test_get_directory_contents
    assert_equal('test.controller.js', @controllers[0], 'directory contents are not correct')
  end
  
  def test_remove_extension
    wo_extension = @judo.remove_extension @controllers[0]
    assert_equal('test', wo_extension, 'extension has not been removed properly')
  end
  
  def test_parse_controller
    
    expected_controller = <<-FILE
$(document).ready(function() {
	JudoApp.test_id.click(function() {
		alert('this is a dummy function');
		alert(JudoApp.test_model.some_data_member);
	});
});
FILE

    assert_equal(expected_controller.chomp, @parsed_controller[1], 'the controller is not parsed correctly')
    expected_requirements = "./application/judo.js", "lib/jquery-1.4.2.min.js", "lib/jquery-ui-1.8.2.min.js", "plugins/test.plugin.js", "plugins/jquery.fancybox-1.3.1.js", "application/views/test.view.js", "application/models/test.model.js"
    
    assert_equal(expected_requirements, @parsed_controller[0], 'the requirements are not parsed correctly')
  end
  
  def test_create_tmp_controller
    assert_nothing_raised do
      @judo.create_tmp_controller @parsed_controller[1]
    end
  end
  
  def test_compile
    assert_nothing_raised do
      @judo.compile
    end
  end
  
  def test_compile_core
    @judo.compile_core
  end  
end