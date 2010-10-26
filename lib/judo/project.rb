module Judo
  class Project
    
    def self.init_with_config(project_path)
      config = Judo::Configuration.new project_path
      config.read
      
      project = Project.new
      project.config = config
      project.project_path = config.project_path
      project.app_filename = config.name.downcase
      project
    end
    
    attr_reader :app_filename,
                :project_path,
                :config,
                :manifest
    attr_writer :config,
                :project_path,
                :app_filename
    
    def initialize(name = 'JudoApplication', project_dir = '/')
       name.gsub!(/\s|\-|\./)
       proj_dir = project_dir  || '/'
       proj_dir += '/' unless proj_dir.match(/\/$/)
       proj_dir = '/' << proj_dir unless proj_dir.match(/^\//)
       
       @color_start = "\e[32m"
       @color_end = "\e[0m"
       
       @app_filename = name.downcase
       @project_path = "#{Judo.root_directory}#{proj_dir}"
       @config = Judo::Configuration.new @project_path, name
       @manifest = Array['application',
                         'elements',
                         'lib',
                         'models',
                         'modules',
                         'plugins',
                         'tests']
    end
    
    def create
      puts "#{@color_start}>>>#{@color_end} Creating the #{@config.name} project in #{@project_path}" 
      create_project_structure
      @config.create
      create_judo_lib_file
      create_utility_lib_file
      create_judo_application_file
      import_javascripts
    end
    
    def update
      get_modules
      compile_modules
      update_application_file
      compress_application if @config.output == 'compressed'
      puts "#{@color_start}>>>#{@color_end} application updated"
    end

    def create_project_structure
      Dir.mkdir "#{@project_path}" unless File.exists? "#{@project_path}"
      
      @manifest.each do |folder|
        puts "#{folder}/ created" unless File.exists? "#{@project_path}#{folder}"
        Dir.mkdir "#{@project_path}#{folder}" unless File.exists? "#{@project_path}#{folder}"
      end
    end
    
    def create_judo_lib_file
      judo_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Judo.base_directory}",
        :asset_root   => "#{@config.asset_root}",
        :load_path    => ["repository"],
        :source_files => ["repository/judo/core/judo.js"]
      )
      
      judo_lib = judo_lib_secretary.concatenation
      judo_lib.save_to "#{@project_path}lib/judo.js"
      
      puts "lib/judo.js created"
    end
    
    def create_utility_lib_file
      utility_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Judo.base_directory}",
        :asset_root   => "#{@config.asset_root}",
        :load_path    => ["repository"],
        :source_files => ["repository/judo/utilities/all.js"]
      )
      
      utility_lib = utility_lib_secretary.concatenation
      utility_lib.save_to "#{@project_path}lib/utilities.js"
      
      puts "lib/utilities.js created"
    end
    
    def create_judo_application_file      
      filename = "#{@project_path}application/#{@app_filename}.js"
      
      #puts File.exists?("#{@project_path}application/#{@app_filename}.js") ? "application/#{@app_filename}.js updated" : "application/#{@app_filename}.js created"
      File.open(filename, "w+") do |file|
        file << "//-- Judo #{Time.now.to_s}  --//\n"
        file << File.open("#{@project_path}lib/judo.js", 'r').readlines.join('')
        file << "\nvar #{@config.name} = new JudoApplication();"
      end
    end
    
    def import_javascripts
      File.copy "#{Judo.base_directory}/repository/judo/tests/index.html", "#{@project_path}tests"
      File.copy "#{Judo.base_directory}/repository/judo/tests/judo.test.js", "#{@project_path}tests"
      File.copy "#{Judo.base_directory}/repository/judo/tests/judo.utilities.test.js", "#{@project_path}tests"
    end
    
    def get_modules      
      entries = Dir.entries "#{@project_path}modules"
      @modules = entries.reject { |file| file.match(/^\./) }
    end
    
    def compile_modules
      @modules.each do |module_file|
        module_filename = Judo::Helpers.create_module_filename module_file
        create_module_file module_file, module_filename
      end
    end
    
    def create_module_file(module_file, module_name)
        module_src = "#{@project_path}modules/#{module_file}"
        
        judo_lib_secretary = Sprockets::Secretary.new(
          :root         => "#{Judo.base_directory}",
          :asset_root   => "#{@config.asset_root}",
          :load_path    => ["repository"],
          :source_files => ["#{module_src}"]
        )

        module_file = judo_lib_secretary.concatenation
        message = File.exists?("#{@project_path}application/#{module_name}.js") ? "application/#{module_name}.js updated" : "application/#{module_name}.js created"
        module_file.save_to "#{@project_path}application/#{module_name}.js"
        judo_lib_secretary.install_assets

        #puts message
    end
    
    def update_application_file
      message = File.exists?("#{@project_path}application/#{@app_filename}.js") ? "application/#{@app_filename}.js updated" : "application/#{@app_filename}.js created"      
      
      content = String.new
      content << "/* Judo #{Time.now.to_s} */\n"
      content << "//= require \"../lib/judo.js\"\n\n"
      content << "\nvar #{@config.name} = new JudoApplication();"
      
      filename = "#{@project_path}application/#{@app_filename}.js"
      File.open(filename, "w+") do |file|
        file << content
        @config.autoload.each do |auto_file|
          file << "\n\n/*---------- Judo autoload #{auto_file} ----------*/"
          file << "\n//= require #{auto_file}\n" if auto_file.match(/^\<.+\>$/)
          file << "\n//= require \"#{auto_file}\"\n" if auto_file.match(/^[^\<].+|[^\>]$/)
        end
      end
      
      judo_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Judo.base_directory}",
        :asset_root   => "#{@config.asset_root}",
        :load_path    => ["repository"],
        :source_files => ["#{filename}"]
      )
      
      application_file = judo_lib_secretary.concatenation
      judo_lib_secretary.install_assets
      application_file.save_to "#{filename}"
      
      #puts message
    end
    
    def compress_application
      application = @project_path + 'application'
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
    
  end
end