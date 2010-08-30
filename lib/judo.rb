module Judo
end

module Judo
  
  def base_directory
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
  
  def lib_directory
    File.expand_path(File.join(File.dirname(__FILE__)))
  end
  
  def root_directory
    Dir.getwd
  end
  
  module_function :base_directory, :lib_directory, :root_directory
end


%w(dependencies configuration project).each do |lib|
  require "#{Judo.lib_directory}/judo/#{lib}"
end

Judo::Configuration.load_defaults