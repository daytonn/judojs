begin
  require 'yaml'
  require 'jsmin'
  require 'tempfile'
  require 'sprockets'
  require 'ftools'
rescue LoadError
  require 'rubygems'
  require 'yaml'
  require 'jsmin'
  require 'tempfile'
  require 'sprockets'
end