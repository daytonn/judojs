require 'test/unit'
require '../lib/judo.rb'

class PackageManagerTest < Test::Unit::TestCase
  
  def test_can_import_package
    Judo::PackageManager.import('somefile')
  end

end