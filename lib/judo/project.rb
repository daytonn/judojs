module Judo
  
  module Project    
    def project_path(path = nil)
      return @project_path if path.nil?
      @project_path = path unless path.nil?
    end
    
    def directory(directory = nil)
      return @directory if directory.nil?
      @directory = directory unless directory.nil?
    end

    def create(name, directory)
      app_filename = name.downcase
      dir = directory || '/'
      dir = dir += '/' unless dir =~ /\/$/
      dir = dir.gsub(/^\//, '') unless dir =~ /^\/$/
      dir = dir.gsub(/\/\//, '/')
      
      config = {:name => name,
                :app_filename => app_filename,
                :judo_dirs => Array['modules'],                
                :output => 'expanded',
                :autoload => false
      }
      
      Judo::Configuration.set_config(config)
      
      directory "#{dir}"
      project_path "#{Judo.root_directory}/#{@directory}"
      
      puts directory.match(/^\/?\s?\/?$/) ? ">>> Creating the #{Judo::Configuration.name} project" : ">>> Creating the #{Judo::Configuration.name} project in #{@directory}"
      
      create_project_directories
      create_conf_file
      import_javascripts
      create_judo_lib_file
      create_judo_application_file
    end
    
    def update
      raise "judo.conf does not exist" unless File.exists? "#{@project_path}/judo.conf"
      Judo::Configuration.load_config
      
      get_modules
      compile_modules
      update_application_file
      compress_application if Judo::Configuration.output == 'compressed'
    end

    def create_project_directories
      puts "#{@directory} created" unless File.exists? "#{@project_path}"
      Dir.mkdir "#{@project_path}" unless File.exists? "#{@project_path}"
      
      manifest.each do |folder|
        Dir.mkdir "#{@project_path}#{folder}" unless File.exists? "#{@project_path}#{folder}"
      end
    end
    
    def manifest
      @manifest = Array['application',
                        'elements',
                        'lib',
                        'models',
                        'modules',
                        'plugins',
                        'templates',
                        'tests']
    end

    def create_conf_file
      conf_file = File.new("#{@project_path}judo.conf", "w+")
      conf_content = <<-CONF
project_path: #{@project_path}
name: #{Judo::Configuration.name}
output: #{Judo::Configuration.output}
#autoload: ['lib/file']
      CONF
      conf_file << conf_content
      conf_file.close
      puts "#{@directory}judo.conf created"
    end
    
    def import_javascripts
      File.copy "#{Judo.base_directory}/repository/judo/tests/index.html", "#{@project_path}tests"
      File.copy "#{Judo.base_directory}/repository/judo/tests/judo.test.js", "#{@project_path}tests"
      File.copy "#{Judo.base_directory}/repository/judo/tests/judo.utilities.test.js", "#{@project_path}tests"
    end
    
    def create_judo_lib_file
      judo_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Judo.base_directory}",
        :asset_root   => "#{@project_path}",
        :load_path    => ["repository"],
        :source_files => ["repository/judo/core/judo.js"]
      )
      
      @judo_lib_file = judo_lib_secretary.concatenation
      @judo_lib_file.save_to "#{@project_path}lib/judo.js"
      
      puts "#{@directory}lib/judo.js created"
    end
    
    def create_judo_application_file      
      filename = "#{@project_path}application/#{Judo::Configuration.app_filename}.js"
      
      puts File.exists?("#{@project_path}application/#{Judo::Configuration.app_filename}.js") ? "application/#{Judo::Configuration.app_filename}.js updated" : "application/#{Judo::Configuration.app_filename}.js created"
      File.open(filename, "w+") do |file|
        file << "//-- Judo #{Time.now.to_s}  --//\n"
        file << @judo_lib_file
        file << "\nvar #{Judo::Configuration.name} = new JudoApplication();"
      end
      
    end
    
    def update_application_file
      message = File.exists?("#{@project_path}application/#{Judo::Configuration.app_filename}.js") ? "application/#{Judo::Configuration.app_filename}.js updated" : "application/#{Judo::Configuration.app_filename}.js created"      
      
      content = String.new
      content << "/* Judo #{Time.now.to_s} */\n"
      content << "//= require \"../lib/judo.js\"\n\n"
      content << "\nvar #{Judo::Configuration.name} = new JudoApplication();"
      
      filename = "#{@project_path}application/#{Judo::Configuration.app_filename}.js"
      File.open(filename, "w+") do |file|
        file << content
      end
      
      judo_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Judo.base_directory}",
        :asset_root   => "#{@project_path}",
        :load_path    => ["repository"],
        :source_files => ["#{filename}"]
      )
      application_file = judo_lib_secretary.concatenation
      judo_lib_secretary.install_assets
      application_file.save_to "#{filename}"
      
      puts message
    end
    
    def get_modules
      @modules = Array.new
      
      entries = Dir.entries "#{@project_path}modules"
      entries.each do |file|
        @modules.push file unless file.match(/^\./)
      end
    end

    def modules(modules = nil)
      @modules if modules.nil?
      @modules = modules unless modules.nil?
    end
    
    def compile_modules
      @modules.each do |module_file|
        module_filename = get_module_filename module_file
        create_module_file module_file, module_filename
      end
    end
    
    def compress_application
      application = Judo::Configuration.project_path + 'application'
      modules = Dir.entries(application)
      modules.reject! { |file| file =~ /^\./ }

      modules.each do |module_file|
        full_path = application + "/#{module_file}"
        uncompressed = File.open(full_path, "r").readlines.join('')
        File.open(full_path, "w+") do |module_file|
          module_file << JSMin.minify(uncompressed)
        end
      end

    end
    
    def get_module_name(module_name)
      split = module_name.split(/[\.\-\s]/)

      module_name = String.new
      split.each do |piece|
        module_name << piece.capitalize.gsub(/\.|\-|\s/, '') unless piece.match(/module|js/)
      end
      
      module_name
    end
    
    def get_module_filename(module_name)
      get_module_name(module_name).downcase
    end
    
    def create_module_file(module_file, module_name)
        module_src = "#{@project_path}modules/#{module_file}"
        
        judo_lib_secretary = Sprockets::Secretary.new(
          :root         => "#{Judo.base_directory}",
          :asset_root   => "#{@project_path}",
          :load_path    => ["repository"],
          :source_files => ["#{module_src}"]
        )

        module_file = judo_lib_secretary.concatenation
        message = File.exists?("#{@project_path}application/#{module_name}.js") ? "application/#{module_name}.js updated" : "application/#{module_name}.js created"
        module_file.save_to "#{@project_path}application/#{module_name}.js"
        judo_lib_secretary.install_assets

        puts message
    end
    
    module_function :create,
                    :manifest,
                    :create_project_directories,
                    :create_conf_file,
                    :import_javascripts,
                    :create_judo_lib_file,
                    :create_judo_application_file,
                    :update_application_file,
                    :modules,
                    :update,
                    :get_modules,
                    :compile_modules,
                    :get_module_name,
                    :create_module_file,
                    :get_module_name,
                    :get_module_filename,
                    :project_path,
                    :directory,
                    :compress_application
  end
  
end