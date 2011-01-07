module Judojs
    class Configuration
      
      attr_reader :name,
                  :project_path,
                  :app_filename,
                  :directory,
                  :output,
                  :dependencies,
                  :autoload,
                  :config_path,
                  :asset_root
                  
      def initialize(project_path, name = 'JudoApplication')
        @defaults = {
          :name => name,
          :project_path => project_path,
          :asset_root => project_path,
          :output => 'expanded',
          :dependencies => ['<jquery/latest>'],
          :autoload => ['<judojs/utilities/all>']
        }

        @defaults.each do |label, setting|
          instance_variable_set("@#{label}", setting)
        end
      end
      
      def create
        default_content = conf_content @defaults
        create_conf_file default_content
      end
      
      def conf_content(options)
        content = <<-CONF
name: #{options[:name]}
project_path: #{options[:project_path]}
asset_root: #{options[:project_path]}
output: #{options[:output]}
dependencies: [#{options[:dependencies].join(', ')}]
autoload: [#{options[:autoload].join(', ')}]
        CONF
      end
      
      def create_conf_file(content)
        File.open("#{@project_path}judojs.conf", "w+") do |conf_file|
          conf_file << conf_content(@defaults)
        end
        
        puts "judojs.conf created"
      end
      
      def update
        content = conf_content({
          :name => @name,
          :project_path => @project_path,
          :asset_root => @project_path,
          :output => @output,
          :dependencies => @dependencies,
          :autoload => @autoload
        })
        create_conf_file content
      end
      
      def read
        begin
          raise IOError, "#{@project_path}judojs.conf does not exist", caller unless File.exists? "#{@project_path}judojs.conf"
          config = YAML.load_file("#{@project_path}judojs.conf")
          
          @project_path = config['project_path']
          @asset_root = config['asset_root']
          @name = config['name']
          @app_filename = config['name'].downcase
          @output = config['output']
          @dependencies = config['dependencies'] || Array.new
          @autoload = config['autoload'] || Array.new
        rescue IOError => e
          puts e.message
          puts e.backtrace.inspect
        end
      end
      
    end
end