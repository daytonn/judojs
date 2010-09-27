module Judo
  module PackageManager
    
    def import(package)
      dir = Dir.getwd
      package_path = dir + '/' + package
      full_package_path = Judo.repository_root + package
      
      raise "#{package_path} is not a directory" unless File.directory? "#{package_path}"
      raise "#{package_path} does not exist" unless File.exists? "#{package_path}"
      raise "#{Judo.repository_root}#{package} already exists" if File.exists? "#{Judo.repository_root}#{package}"
      
      Dir.mkdir(full_package_path) unless File.exists?(full_package_path)
      FileUtils.cp_r(package_path, Judo.repository_root)
    end
    
    def install(packages)
      packages.each do |package|
        import package
      end
    end
    
    def uninstall(packages)
      packages.each do |package|
        package_path = Judo.repository_root + package
        raise "no program named #{package} installed" unless File.directory? "#{package_path}"
        
        FileUtils.rm_r package_path
        raise "Could not delete package. Try checking the file permissions in #{package_path}" if File.exists? package_path
        puts "#{package} uninstalled successfully" unless File.exists? package_path
      end
    end
    
    def list
      
    end
    
    def update
      
    end
    
    def help
      puts <<-DOC

Description: 
The jpm package managers enables you to manage the judo packages installed on your system:

Usage: jpm [action]

Actions:
install  Install a package

Example:
// Install the fancybox plugin from the judo repository
jpm install fancybox
    DOC
    end
    
    module_function :install, :import, :uninstall, :help
    
  end
end