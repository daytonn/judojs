require 'test/unit'
require '../lib/judo.rb'

class TC_TestProject < Test::Unit::TestCase
  
  def setup
  end
  
  def test_default_configuration
    Judo::Configuration.load_defaults
    assert_equal nil, Judo::Configuration.name, 'name is set correctly'
    assert_equal 'expanded', Judo::Configuration.output, 'output is set correctly'
    assert_equal ['modules'], Judo::Configuration.judo_dirs, 'judo_dirs is set correctly'
  end
  
  def test_can_load_config
    Judo::Configuration.load_config('/Volumes/Storage/Development/Judo/tests/fixtures/judo.conf')
    assert_equal 'SomeApplication', Judo::Configuration.name, 'name is set correctly'
    assert_equal 'compressed', Judo::Configuration.output, 'output is set correctly'
    assert_equal ['other'], Judo::Configuration.judo_dirs, 'judo_dirs is set correctly'
  end
    
  def teardown
  end

end