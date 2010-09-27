require 'test/unit'
require '../lib/judo.rb'

class TC_TestProject < Test::Unit::TestCase
  
  def test_directories
   assert_equal('/Volumes/Storage/Development/judo/lib', Judo.lib_directory, 'Judo.lib_directory is set correctly')
   assert_equal('/Volumes/Storage/Development/judo', Judo.base_directory, 'Judo.base_directory is set correctly')
   assert_equal('/Volumes/Storage/Development/judo/tests', Judo.root_directory,'Judo.root_directory is set correctly')     
  end
  
end