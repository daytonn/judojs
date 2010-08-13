require 'test/unit'
require '../lib/judo.rb'

class TC_MyTest < Test::Unit::TestCase
  def setup
   @judo = Judo.new
   @judo.create_project('JudoApp', 'expanded', 'fixtures')
   @test_module_data = <<-FILE
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
   
   @test_elements_data = <<-FILE
$(document).ready(function() {
	JudoApp.TestModule.test_id = $('#test-element-with-id');
	console.log(JudoApp.TestModule.test_id);
});
   FILE
   
   @test_model_data = <<-FILE
JudoApp.test_model = {
	some_data_member: 'some data value'
};
   FILE
   
   @test_plugin_data = <<-FILE
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
  end
  
  def create_default_files
    File.open('./fixtures/modules/test.module.js', 'w+') do |mod|
      mod.syswrite(@test_module_data)
    end
    File.open('./fixtures/elements/test.elements.js', 'w+') do |elements|
      elements.syswrite(@test_elements_data)
    end
    File.open('./fixtures/models/test.model.js', 'w+') do |model|
      model.syswrite(@test_model_data)
    end
    File.open('./fixtures/plugins/test.plugin.js', 'w+') do |model|
      model.syswrite(@test_plugin_data)
    end
  end
  
  def test_create_project
    assert_equal(File.exists?('./fixtures/judo.conf'), true, 'judo.conf exists')
    assert_equal(File.exists?('./fixtures/modules'), true, 'modules/ exists')
    assert_equal(File.exists?('./fixtures/elements'), true, 'elements/ exists')
    assert_equal(File.exists?('./fixtures/models'), true, 'controllers/ exists')
    assert_equal(File.exists?('./fixtures/plugins'), true, 'controllers/ exists')
    assert_equal(File.exists?('./fixtures/tests'), true, 'tests/ exists')
    assert_equal('/Volumes/Storage/Development/Judo/tests', @judo.root, 'root is set correctly')
    assert_equal('JudoApp', @judo.name, 'name is set correctly')
    assert_equal('judoapp', @judo.judo_filename, 'judo_filename is set correctly')
    assert_equal('expanded', @judo.output, 'output is set correctly')
    assert_equal( '/fixtures/', @judo.subdir, 'subdir is set correctly')
    assert_equal('0.1.0', @judo.version, 'version is set correctly')
    assert_equal(['modules'], @judo.judo_dirs, 'judofiles is set correctly')
    assert_equal(false, @judo.compress, 'compress is set correctly')
    assert_equal(['application', 'lib', 'models', 'modules', 'plugins', 'tests', 'elements'], @judo.project_dirs, 'project_dirs are set correctly')
    assert_equal(['lib/utilities.js', 'lib/judo.js'], @judo.core_files, 'core_files are set correctly')
    assert_equal("/Volumes/Storage/Development/Judo/tests/fixtures/", @judo.project_path, 'project_path is set correctly')

    create_default_files
  end

  def test_get_config
    @judo = Judo.new
    @judo.create_project('JudoApp', 'expanded', 'fixtures')
    @judo.get_config

    assert_equal('JudoApp', @judo.name, 'name is not set correctly')
    assert_equal('expanded', @judo.output, 'output is not set correctly')
  end

  def test_get_directory_contents
     @modules = @judo.get_directory_contents "/Volumes/Storage/Development/Judo/tests/fixtures/modules"
     assert_equal('/Volumes/Storage/Development/Judo/tests/fixtures/modules/test.module.js', @modules[0], 'directory contents are not correct')
  end

  def test_parse_module 
    @requirements, @parsed_module = @judo.parse_module "/Volumes/Storage/Development/Judo/tests/fixtures/modules/test.module.js"
    expected_requirements = "/Volumes/Storage/Development/Judo/tests/fixtures/plugins/test.plugin.js", "/Volumes/Storage/Development/Judo/tests/fixtures/elements/test.elements.js", "/Volumes/Storage/Development/Judo/tests/fixtures/models/test.model.js"

    assert_equal(expected_requirements, @requirements, 'module is not parsed correctly')
  end

  def test_remove_extension
    @modules = @judo.get_directory_contents "/Volumes/Storage/Development/Judo/tests/fixtures/modules"
    wo_extension = @judo.remove_extension @modules[0]
    assert_equal('/Volumes/Storage/Development/Judo/tests/fixtures/modules/test', wo_extension, 'extension has not been removed properly')
  end

  def test_remove_path
    @modules = @judo.get_directory_contents "/Volumes/Storage/Development/Judo/tests/fixtures/modules"
    wo_extension = @judo.remove_path @modules[0]
    assert_equal('test.module.js', wo_extension, 'path has not been removed properly')
  end

  def test_parse_module
    @module = @judo.get_directory_contents "/Volumes/Storage/Development/Judo/tests/fixtures/modules"
    @parsed_module = @judo.parse_module @module[0]

    expected_requirements = "/Volumes/Storage/Development/Judo/tests/fixtures/plugins/test.plugin.js", "/Volumes/Storage/Development/Judo/tests/fixtures/elements/test.elements.js", "/Volumes/Storage/Development/Judo/tests/fixtures/models/test.model.js"
    assert_equal(expected_requirements, @parsed_module[0], 'the requirements are not parsed correctly')
  end

  def test_create_tmp_module
    @module = @judo.get_directory_contents "/Volumes/Storage/Development/Judo/tests/fixtures/modules"
    @parsed_module = @judo.parse_module @module[0]
    assert_nothing_raised do
      @judo.create_tmp_module('test', @parsed_module)
    end
  end

end