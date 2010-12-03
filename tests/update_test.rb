require 'test/unit'
require '../lib/judojs.rb'

class TC_TestProject < Test::Unit::TestCase
  
  def setup
    
  end
  
  def test_can_update_project
    @path = File.dirname(__FILE__)
    File.copy("#{@path}/fixtures/global.module.js", "#{@path}/js/modules")
    File.copy("#{@path}/fixtures/test.module.js", "#{@path}/js/modules")
    File.copy("#{@path}/fixtures/test.elements.js", "#{@path}/js/elements")
    File.copy("#{@path}/fixtures/test.model.js", "#{@path}/js/models")
    
    @test_project = Judojs::Project.init_with_config('/Volumes/Storage/Development/judojs/tests/js/')
    @test_project.update
    assert(File.exists?('/Volumes/Storage/Development/judojs/tests/js/application/global.js'), 'application/global.js created')
    assert(File.exists?('/Volumes/Storage/Development/judojs/tests/js/application/test.js'), 'application/test.js created')

    expected_file = File.open("/Volumes/Storage/Development/judojs/tests/fixtures/global.js", "r")
    actual_file = File.open("/Volumes/Storage/Development/judojs/tests/js/application/global.js", "r")
    expected_content = expected_file.readlines
    actual_content = actual_file.readlines
    assert_equal(expected_content, actual_content, "global.js file has correct contents")
    actual_file.close
    expected_file.close

    expected_file = File.open("/Volumes/Storage/Development/judojs/tests/fixtures/test.js", "r")
    actual_file = File.open("/Volumes/Storage/Development/judojs/tests/js/application/test.js", "r")
    expected_content = expected_file.readlines
    actual_content = actual_file.readlines
    assert_equal(expected_content, actual_content, "test.js file has correct contents")
    actual_file.close
    expected_file.close
  end
  
  def teardown
    File.delete('/Volumes/Storage/Development/judojs/tests/js/judojs.conf') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/judojs.conf')
    File.delete('/Volumes/Storage/Development/judojs/tests/js/application/myapplication.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/application/myapplication.js')
    File.delete('/Volumes/Storage/Development/judojs/tests/js/application/global.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/application/global.js')
    File.delete('/Volumes/Storage/Development/judojs/tests/js/application/test.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/application/test.js')
    File.delete('/Volumes/Storage/Development/judojs/tests/js/elements/test.elements.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/elements/test.elements.js')
    File.delete('/Volumes/Storage/Development/judojs/tests/js/models/test.model.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/models/test.model.js')    
    File.delete('/Volumes/Storage/Development/judojs/tests/js/lib/judo.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/lib/judo.js')
    File.delete('/Volumes/Storage/Development/judojs/tests/js/lib/utilities.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/lib/utilities.js')
    File.delete("/Volumes/Storage/Development/judojs/tests/js/tests/index.html") if File.exists?("/Volumes/Storage/Development/judojs/tests/js/tests/index.html")
    File.delete("/Volumes/Storage/Development/judojs/tests/js/tests/judojs.test.js") if File.exists?("/Volumes/Storage/Development/judojs/tests/js/tests/judojs.test.js")
    File.delete("/Volumes/Storage/Development/judojs/tests/js/tests/judojs.utilities.test.js") if File.exists?("/Volumes/Storage/Development/judojs/tests/js/tests/judojs.utilities.test.js")
    File.delete('/Volumes/Storage/Development/judojs/tests/js/modules/global.module.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/modules/global.module.js')
    File.delete('/Volumes/Storage/Development/judojs/tests/js/modules/test.module.js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js/modules/test.module.js')

    @test_project.manifest.each do |folder|
      Dir.delete("/Volumes/Storage/Development/judojs/tests/js/#{folder}") if File.exists? "/Volumes/Storage/Development/judojs/tests/js/#{folder}"
    end
    
    Dir.delete('/Volumes/Storage/Development/judojs/tests/js') if File.exists?('/Volumes/Storage/Development/judojs/tests/js')
  end

end