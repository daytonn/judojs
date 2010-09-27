require 'test/unit'
require '../lib/judo.rb'

class TC_TestProject < Test::Unit::TestCase
  
  def setup
    
  end
  
  def test_can_update_project
    @path = File.dirname(__FILE__)
    File.copy("#{@path}/fixtures/global.module.js", "#{@path}/js/modules")
    File.copy("#{@path}/fixtures/test.module.js", "#{@path}/js/modules")
    File.copy("#{@path}/fixtures/test.elements.js", "#{@path}/js/elements")
    File.copy("#{@path}/fixtures/test.model.js", "#{@path}/js/models")
    File.copy("#{@path}/fixtures/update.judo.conf", "#{@path}/js/judo.conf")
    
    @test_project = Judo::Project.init_with_config('/Volumes/Storage/Development/judo/tests/js/')
    @test_project.update
    assert(File.exists?('/Volumes/Storage/Development/judo/tests/js/application/global.js'), 'application/global.js created')
    assert(File.exists?('/Volumes/Storage/Development/judo/tests/js/application/test.js'), 'application/test.js created')

    expected_file = File.open("/Volumes/Storage/Development/Judo/tests/fixtures/global.js", "r")
    actual_file = File.open("/Volumes/Storage/Development/Judo/tests/js/application/global.js", "r")
    expected_content = expected_file.readlines
    actual_content = actual_file.readlines
    assert_equal(expected_content, actual_content, "global.js file has correct contents")
    actual_file.close
    expected_file.close

    expected_file = File.open("/Volumes/Storage/Development/Judo/tests/fixtures/test.js", "r")
    actual_file = File.open("/Volumes/Storage/Development/Judo/tests/js/application/test.js", "r")
    expected_content = expected_file.readlines
    actual_content = actual_file.readlines
    assert_equal(expected_content, actual_content, "test.js file has correct contents")
    actual_file.close
    expected_file.close

    expected_file = File.open("/Volumes/Storage/Development/Judo/tests/fixtures/update.judo.conf", "r")
    actual_file = File.open("/Volumes/Storage/Development/Judo/tests/js/judo.conf", "r")
    expected_content = expected_file.readlines
    actual_content = actual_file.readlines
    assert_equal(expected_content, actual_content, "test.js file has correct contents")
    actual_file.close
    expected_file.close
  end
  
  def teardown
    File.delete('/Volumes/Storage/Development/judo/tests/js/judo.conf') if File.exists?('/Volumes/Storage/Development/judo/tests/js/judo.conf')
    File.delete('/Volumes/Storage/Development/judo/tests/js/application/myapplication.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/application/myapplication.js')
    File.delete('/Volumes/Storage/Development/judo/tests/js/application/global.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/application/global.js')
    File.delete('/Volumes/Storage/Development/judo/tests/js/application/test.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/application/test.js')
    File.delete('/Volumes/Storage/Development/judo/tests/js/elements/test.elements.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/elements/test.elements.js')
    File.delete('/Volumes/Storage/Development/judo/tests/js/models/test.model.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/models/test.model.js')    
    File.delete('/Volumes/Storage/Development/judo/tests/js/lib/judo.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/lib/judo.js')
    File.delete('/Volumes/Storage/Development/judo/tests/js/lib/utilities.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/lib/utilities.js')
    File.delete("/Volumes/Storage/Development/Judo/tests/js/tests/index.html") if File.exists?("/Volumes/Storage/Development/Judo/tests/js/tests/index.html")
    File.delete("/Volumes/Storage/Development/Judo/tests/js/tests/judo.test.js") if File.exists?("/Volumes/Storage/Development/Judo/tests/js/tests/judo.test.js")
    File.delete("/Volumes/Storage/Development/Judo/tests/js/tests/judo.utilities.test.js") if File.exists?("/Volumes/Storage/Development/Judo/tests/js/tests/judo.utilities.test.js")
    File.delete('/Volumes/Storage/Development/judo/tests/js/modules/global.module.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/modules/global.module.js')
    File.delete('/Volumes/Storage/Development/judo/tests/js/modules/test.module.js') if File.exists?('/Volumes/Storage/Development/judo/tests/js/modules/test.module.js')

    @test_project.manifest.each do |folder|
      Dir.delete("/Volumes/Storage/Development/Judo/tests/js/#{folder}") if File.exists? "/Volumes/Storage/Development/Judo/tests/js/#{folder}"
    end
    
    Dir.delete('/Volumes/Storage/Development/Judo/tests/js') if File.exists?('/Volumes/Storage/Development/Judo/tests/js')
  end

end