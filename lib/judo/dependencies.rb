begin
  require 'yaml'
  require 'jsmin'
  require 'tempfile'
  require 'sprockets'
  require 'ftools'
  require 'fssm'
rescue LoadError
  require 'rubygems'
  require 'yaml'
  require 'jsmin'
  require 'tempfile'
  require 'sprockets'
  require 'ftools'
  require 'fssm'
end