require 'test/unit'
require '../lib/judojs.rb'

class TC_TestProject < Test::Unit::TestCase
  
  def test_directories
   assert_equal('/Volumes/Storage/Development/judojs/lib', Judojs.lib_directory, 'Judojs.lib_directory is set correctly')
   assert_equal('/Volumes/Storage/Development/judojs', Judojs.base_directory, 'Judojs.base_directory is set correctly')
   assert_equal('/Volumes/Storage/Development/judojs/tests', Judojs.root_directory,'Judojs.root_directory is set correctly')     
  end
  
end