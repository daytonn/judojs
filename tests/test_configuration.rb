require 'test/unit'
require '../lib/judo.rb'

class TC_TestProject < Test::Unit::TestCase
  
  def setup
  end
  
  def test_default_configuration
    Judo::Configuration.load_defaults
    assert_equal nil, Judo::Configuration.name, 'name is set correctly'
    assert_equal nil, Judo::Configuration.app_filename, 'app_filename is set correctly'
    assert_equal '/', Judo::Configuration.directory, 'directory is set correctly'
    assert_equal ['modules'], Judo::Configuration.judo_dirs, 'judo_dirs is set correctly'
    assert_equal 'expanded', Judo::Configuration.output, 'output is set correctly'
    assert_equal nil, Judo::Configuration.autoload, 'autoload is set correctly'
  end
  
  def test_can_load_config
    Judo::Configuration.load_config('/Volumes/Storage/Development/Judo/tests/fixtures/judo.conf')
    assert_equal 'SomeApplication', Judo::Configuration.name, 'name is set correctly'
    assert_equal 'someapplication', Judo::Configuration.app_filename, 'app_filename is set correctly'
    assert_equal 'js', Judo::Configuration.directory, 'directory is set correctly'
    assert_equal ['other'], Judo::Configuration.judo_dirs, 'judo_dirs is set correctly'
    assert_equal 'compressed', Judo::Configuration.output, 'output is set correctly'
  end
  
  def test_can_set_config
    config = {:name => 'SomeName',
              :app_filename => 'somename',
              :directory => 'some_dir',
              :judo_dirs => Array['some_folder'],                
              :output => 'expanded',
              :autoload => ['<utilities/all>']
    }
    
    Judo::Configuration.set_config(config)
    
    assert_equal 'SomeName', Judo::Configuration.name, 'name is set correctly'
    assert_equal 'somename', Judo::Configuration.app_filename, 'app_filename is set correctly'
    assert_equal 'some_dir', Judo::Configuration.directory, 'directory is set correctly'
    assert_equal ['some_folder'], Judo::Configuration.judo_dirs, 'judo_dirs is set correctly'
    assert_equal 'expanded', Judo::Configuration.output, 'output is set correctly'
    assert_equal ['<utilities/all>'], Judo::Configuration.autoload, 'autoload is set correctly'
  end
    
  def teardown
  end

end