require 'test/unit'
require '../lib/judo.rb'

class TC_TestProject < Test::Unit::TestCase
  
  def setup
    Judo::Project.create('MyApplication', 'js', true)
    
    @path = File.dirname(__FILE__)
    File.copy("#{@path}/fixtures/global.module.js", "#{@path}/js/modules")
    File.copy("#{@path}/fixtures/test.module.js", "#{@path}/js/modules")
    File.copy("#{@path}/fixtures/test.elements.js", "#{@path}/js/elements")
    File.copy("#{@path}/fixtures/test.model.js", "#{@path}/js/models")
  end
  
  def test_directories
   assert_equal('/Volumes/Storage/Development/Judo/lib', Judo.lib_directory, 'Judo.lib_directory is set correctly')
   assert_equal('/Volumes/Storage/Development/Judo', Judo.base_directory, 'Judo.base_directory is set correctly')
   assert_equal('/Volumes/Storage/Development/Judo/tests', Judo.root_directory,'Judo.root_directory is set correctly')     
  end

  def test_default_config
    Judo::Configuration.load_defaults
    assert_equal(nil , Judo::Configuration.name, 'Judo::Configuration.name] is set correctly')
    assert_equal('expanded' , Judo::Configuration.output, 'Judo::Configuration.output is set correctly')
    assert_equal(['modules'] , Judo::Configuration.judo_dirs, 'Judo::Configuration.judo_dirs is set correctly')
  end
  
  def test_project_manifest
    manifest = 'application', 'elements', 'lib', 'models', 'modules', 'plugins', 'templates', 'tests'
    assert_equal manifest, Judo::Project.manifest
  end
  
  def test_can_create_project_directory
    assert(File.exists?("/Volumes/Storage/Development/Judo/tests/js"), 'project_dir was created successfully')
  end
  
  def test_can_create_manifest
    Judo::Project.manifest.each do |folder|
      assert(File.exists?("/Volumes/Storage/Development/Judo/tests/js/#{folder}"), "#{folder} was created successfully")
    end
  end
  
  def test_can_create_judo_conf_file
    assert(File.exists?("/Volumes/Storage/Development/Judo/tests/js/judo.conf"), 'judo.conf was created successfully')
    
    File.open("/Volumes/Storage/Development/Judo/tests/js/judo.conf", "r") do |conf_file|
      conf_content = conf_file.sysread File.size? "/Volumes/Storage/Development/Judo/tests/js/judo.conf"
      expected_content = "name: MyApplication\noutput: expanded\njudo_dirs: [modules]\n# The following will auto load judo library scripts in the application/<yourapp>.js file\n#autoload: ['lib/file']\n"
      assert_equal expected_content, conf_content
    end
  end
  
  def test_project_created_test_files
    assert(File.exists?("/Volumes/Storage/Development/Judo/tests/js/tests/index.html"), "tests/index.html was created successfully")
    assert(File.exists?("/Volumes/Storage/Development/Judo/tests/js/tests/judo.test.js"), "tests/judo.test.js was created successfully")
    assert(File.exists?("/Volumes/Storage/Development/Judo/tests/js/tests/judo.utilities.test.js"), "tests/judo.utilities.test.js was created successfully")
    assert(File.exists?("/Volumes/Storage/Development/Judo/tests/js/lib/judo.js"), "lib/judo.js was created successfully")
  end
  
  def test_can_create_lib_file
    expected_lib_file = File.open("/Volumes/Storage/Development/Judo/tests/fixtures/judo.js", "r")
    judo_lib_file = File.open("/Volumes/Storage/Development/Judo/tests/js/lib/judo.js", "r")
    
    assert_equal(expected_lib_file.readlines, judo_lib_file.readlines, "lib/judo file has correct contents")
    
    judo_lib_file.close
    expected_lib_file.close
  end
  
  def test_can_create_application_file
    expected_app_file = File.open("/Volumes/Storage/Development/Judo/tests/fixtures/myapplication.js", "r")
    judo_app_file = File.open("/Volumes/Storage/Development/Judo/tests/js/application/myapplication.js", "r")
    
    expected_app = expected_app_file.readlines
    expected_app.slice! 0
    judo_app  = judo_app_file.readlines
    judo_app.slice! 0
    assert_equal(expected_app, judo_app, "lib/judo file has correct contents")
    
    judo_app_file.close
    expected_app_file.close    
  end
  
  def test_can_update_application
    Judo::Project.update
    
    expected_global_content = File.open("#{@path}/fixtures/global.js", "r").readlines.join
    global_content = File.open("#{@path}/js/application/global.js", "r").readlines.join
    
    expected_myapplication_content = File.open("#{@path}/fixtures/myapplication_updated.js", "r").readlines.join
    myapplication_content = File.open("#{@path}/js/application/myapplication.js").readlines
    myapplication_content.slice! 0 
    myapplication_content = myapplication_content.join
    
    expected_test_content = File.open("#{@path}/fixtures/test.js", "r").readlines.join
    test_content = File.open("#{@path}/js/application/test.js", "r").readlines.join
    
    assert(File.exists?("#{@path}/js/application/myapplication.js"), 'myapplication.js exists')
    assert(File.exists?("#{@path}/js/application/global.js"), 'global.js exists')
    assert(File.exists?("#{@path}/js/application/test.js"), 'test.js exists')
    
    assert_equal expected_global_content, global_content, 'global.js content is correct'
    assert_equal expected_test_content, test_content, 'test content.js is correct'
    assert_equal expected_myapplication_content, myapplication_content, 'myapplication.js content is correct'
  end
  
  def teardown
    File.delete "#{@path}/js/judo.conf" if File.exists? "#{@path}/js/judo.conf"
    File.delete "#{@path}/js/tests/index.html" if File.exists? "#{@path}/js/tests/index.html"
    File.delete "#{@path}/js/tests/judo.test.js" if File.exists? "#{@path}/js/tests/judo.test.js"
    File.delete "#{@path}/js/tests/judo.utilities.test.js" if File.exists? "#{@path}/js/tests/judo.utilities.test.js"
    File.delete "#{@path}/js/lib/judo.js" if File.exists? "#{@path}/js/lib/judo.js"
    File.delete "#{@path}/js/application/myapplication.js" if File.exists? "#{@path}/js/application/myapplication.js"

    File.delete "#{@path}/js/modules/global.module.js" if File.exists? "#{@path}/js/modules/global.module.js"
    File.delete "#{@path}/js/modules/test.module.js" if File.exists? "#{@path}/js/modules/test.module.js"
    File.delete "#{@path}/js/elements/test.elements.js" if File.exists? "#{@path}/js/elements/test.elements.js"
    File.delete "#{@path}/js/models/test.model.js" if File.exists? "#{@path}/js/models/test.model.js"
    File.delete "#{@path}/js/application/global.js" if File.exists? "#{@path}/js/application/global.js"
    File.delete "#{@path}/js/application/test.js" if File.exists? "#{@path}/js/application/test.js"
    Judo::Project.manifest.each do |folder|
      Dir.delete "#{@path}/js/#{folder}" if File.exists? "#{@path}/js/#{folder}"
    end

    Dir.delete "#{@path}/js" if File.exists? "/Volumes/Storage/Development/Judo/tests/js"
  end
  
end