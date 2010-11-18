require 'test/unit'
require '../lib/judojs.rb'

class PackageManagerTest < Test::Unit::TestCase
  
  def test_can_import_package
    Judojs::PackageManager.import('somefile')
  end

end