module Judojs
end

module Judojs
  def version
    '0.9.4'
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
  
  module_function :version,
                  :base_directory,
                  :lib_directory,
                  :root_directory,
                  :repository_root
end


%w(dependencies configuration helpers manifest project command jpm).each do |lib|
  require "#{Judojs.lib_directory}/judojs/#{lib}"
end