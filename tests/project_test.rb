require 'test/unit'
require '../lib/judojs.rb'

class TC_TestProject < Test::Unit::TestCase
  
  def setup
    @test_project = Judojs::Project.new('MyApplication', 'js')
    @path = File.dirname(__FILE__)
  end
  
  def test_can_initialize_project
    assert_equal('myapplication', @test_project.app_filename, 'test_project.app_filename')
    assert_equal('/Volumes/Storage/Development/judojs/tests/js/', @test_project.project_path, 'test_project.project_path')
    assert_equal('MyApplication', @test_project.config.name, 'test_project.name')
    assert_equal('expanded', @test_project.config.output, 'test_project.config.output')
    assert_equal(Array.new, @test_project.config.autoload, 'test_project.config.autoload')
  end
  
  def test_can_init_with_config
    test_project = Judojs::Project.init_with_config '/Volumes/Storage/Development/judojs/tests/js/'
    assert_equal('myapplication', test_project.app_filename, 'test_project.app_filename')
    assert_equal('/Volumes/Storage/Development/judojs/tests/js/', test_project.project_path, 'test_project.project_path')
    assert_equal('MyApplication', test_project.config.name, 'test_project.name')
    assert_equal('expanded', test_project.config.output, 'test_project.config.output')
    assert_equal(Array.new, test_project.config.autoload, 'test_project.config.autoload')
  end
  
  def test_can_create_project
    @test_project.create
    assert(File.exists?("/Volumes/Storage/Development/judojs/tests/js"), 'project_dir was created successfully')
    @test_project.manifest.each do |folder|
      assert(File.exists?("/Volumes/Storage/Development/judojs/tests/js/#{folder}"), "#{folder} was created successfully")
    end
    assert(File.exists?('/Volumes/Storage/Development/judojs/tests/js/judojs.conf'), 'judojs.conf was created successfully')
    assert(File.exists?('/Volumes/Storage/Development/judojs/tests/js/application/myapplication.js'), 'application/myapplication.js was created successfully')
    assert(File.exists?('/Volumes/Storage/Development/judojs/tests/js/lib/judojs.js'), 'lib/judosj.js was created successfully')
    assert(File.exists?('/Volumes/Storage/Development/judojs/tests/js/lib/utilities.js'), 'lib/utilities.js was created successfully')
    assert(File.exists?("/Volumes/Storage/Development/judojs/tests/js/tests/index.html"), "tests/index.html was created successfully")
    assert(File.exists?("/Volumes/Storage/Development/judojs/tests/js/tests/judojs.test.js"), "tests/judojs.test.js was created successfully")
    assert(File.exists?("/Volumes/Storage/Development/judojs/tests/js/tests/judojs.utilities.test.js"), "tests/judo.utilities.test.js was created successfully")
  end
  
  def test_judo_conf_content
    expected_conf_lib_file = File.open("/Volumes/Storage/Development/judo/tests/fixtures/judo.conf", "r")
    judo_conf_file = File.open("/Volumes/Storage/Development/judo/tests/js/judo.conf", "r")
    assert_equal(expected_conf_lib_file.readlines, judo_conf_file.readlines, "judo.conf file has correct contents")
    judo_conf_file.close
    expected_conf_lib_file.close
  end
  
  def test_judo_application_content
    expected_file = File.open("/Volumes/Storage/Development/judojs/tests/fixtures/myapplication.js", "r")
    actual_file = File.open("/Volumes/Storage/Development/judojs/tests/js/application/myapplication.js", "r")
    expected_content = expected_file.readlines
    expected_content.shift
    actual_content = actual_file.readlines
    actual_content.shift
    assert_equal(expected_content, actual_content, "myapplication.js file has correct contents")
    actual_file.close
    expected_file.close
  end
  
  def test_library_files_content
    expected_judo_lib_file = File.open("/Volumes/Storage/Development/judojs/tests/fixtures/judojs.js", "r")
    judo_lib_file = File.open("/Volumes/Storage/Development/judojs/tests/js/lib/judojs.js", "r")
    assert_equal(expected_judo_lib_file.readlines, judo_lib_file.readlines, "lib/judojs.js file has correct contents")
    judo_lib_file.close
    expected_judo_lib_file.close
    
    expected_utility_lib_file = File.open("/Volumes/Storage/Development/judojs/tests/fixtures/utilities.js", "r")
    utility_lib_file = File.open("/Volumes/Storage/Development/judojs/tests/js/lib/utilities.js", "r")
    assert_equal(expected_utility_lib_file.readlines, utility_lib_file.readlines, "lib/utilites.js file has correct contents")
    utility_lib_file.close
    expected_utility_lib_file.close
  end
  
  def test_can_initialize_configuration
    test_config = Judojs::Configuration.new '/Volumes/Storage/Development/judojs/tests/js/', 'MyApplication'
    test_config.read
    assert_equal(test_config.project_path, '/Volumes/Storage/Development/judojs/tests/js/')
    assert_equal('MyApplication', test_config.name, 'test_config.name')
    assert_equal('myapplication', test_config.app_filename, 'test_config.app_filename')
    assert_equal('expanded', test_config.output, 'test_config.output' )
    assert_equal(Array.new, test_config.autoload, 'test_config.autoload') 
  end
  
  def teardown

  end

end