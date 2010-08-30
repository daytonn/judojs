module Judo
  
  module Project
  
    attr_accessor :project_path, :name, :app_filename, :modules
    
    def create(name, directory, silent)
      @name = name
      @app_filename = @name.downcase
      @silent_mode = silent || false

      directory = directory || '/'
      directory = directory << '/' unless directory.match(/\/$/)
      @directory = directory.gsub(/^\//, '')
      
      @project_path = "#{Judo.root_directory}/#{@directory}"
      
      puts @directory.match(/^\/?\s?\/?$/) ? "Creating the #{@name} project >>" : "Creating the #{@name} project in #{@directory} >>" unless @silent_mode
      
      create_project_directories
      create_conf_file
      import_javascripts
      create_judo_lib_file
      create_judo_application_file

    end
    
    def update
      Judo::Configuration.load_config "#{@project_path}judo.conf"
      
      get_modules
      compile_modules
    end
    
    def create_project_directories
      puts "#{@directory} created" unless File.exists? "#{@project_path}" unless @silent_mode
      Dir.mkdir "#{@project_path}" unless File.exists? "#{@project_path}"
      
      manifest.each do |folder|
        Dir.mkdir "#{@project_path}#{folder}" unless File.exists? "#{@project_path}#{folder}"
      end
      
      Judo::Configuration.judo_dirs.each
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
      judo_dirs = "[" << Judo::Configuration.judo_dirs.join(', ') << "]"

      conf_file = File.new("#{@project_path}judo.conf", "w+")
      conf_content = <<-CONF
name: #{@name}
output: #{Judo::Configuration.output}
judo_dirs: #{judo_dirs}
# The following will auto load judo library scripts in the application/<yourapp>.js file
#autoload: ['lib/file']
      CONF
      conf_file << conf_content
      conf_file.close
      
      puts "#{@directory}judo.conf created" unless @silent_mode
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
      
      puts "#{@directory}lib/judo.js created" unless @silent_mode
    end
    
    def create_judo_application_file
      unless @modules.nil? then
        modules = "\n\n"
        @modules.each do |mod|
          modules << "#{@name}.addModule('#{mod}'); \n"
        end
      end

      filename = "#{@project_path}application/#{@app_filename}.js"
      puts File.exists?("#{@project_path}application/#{@app_filename}.js") ? "#{@project_path}application/#{@app_filename}.js updated" : "#{@directory}application/#{@app_filename}.js created" unless @silent_mode
      File.open(filename, "w+") do |file|
        file << "//-- Judo #{Time.now.to_s}  --//\n"
        file << @judo_lib_file
        file << "\nvar #{@name} = new JudoApplication();"
        file << modules
      end
      
    end
    
    def get_modules
      Judo::Configuration.judo_dirs.each do |folder|
        modules = Array.new
        
        entries = Dir.entries "#{@project_path}#{folder}"
        entries.each do |file|
          modules.push file unless file.match(/^\./)
        end
        
        @modules = @modules.concat modules unless @modules.nil?
        modules modules if @modules.nil?
      end
    end
    
    def modules(modules = nil)
      @modules if modules.nil?
      @modules = modules unless modules.nil?
    end
    
    def compile_modules
      @modules.each do |module_file|
        module_name = get_module_name module_file
        create_module_file module_file, module_name
      end
    end
    
    def get_module_name(module_name)
      module_name = module_name.sub(/\.\w*\.js/, '')
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
        module_file.save_to "#{@project_path}application/#{module_name}.js"

        puts "#{@directory}application/#{module_name}.js created" unless @silent_mode
    end
    
    module_function :create,
                    :manifest,
                    :create_project_directories,
                    :create_conf_file,
                    :import_javascripts,
                    :create_judo_lib_file,
                    :create_judo_application_file,
                    :modules,
                    :update,
                    :get_modules,
                    :compile_modules,
                    :get_module_name,
                    :create_module_file
    
  end
  
end