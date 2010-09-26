module Judo
end

module Judo
  def version
    '0.9.1'
  end
  
  def base_directory
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
  
  def lib_directory
    File.expand_path(File.join(File.dirname(__FILE__)))
  end
  
  def root_directory
    Dir.getwd
  end
  
  def repository_root
    base_directory + '/repository/'
  end
  
  module_function :base_directory, :lib_directory, :root_directory, :repository_root
end


%w(dependencies configuration helpers project command jpm).each do |lib|
  require "#{Judo.lib_directory}/judo/#{lib}"
end