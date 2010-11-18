module Judojs
    class Configuration
      
      attr_reader :project_path,
                  :name,
                  :app_filename,
                  :directory,
                  :output,
                  :autoload,
                  :config_path,
                  :asset_root
                  
      def initialize(project_path, name = 'JudoApplication')
        @project_path = project_path
        @asset_root = project_path
        @name = name
        @output = 'expanded'
        @autoload = Array.new                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
      end
      
      def create
        conf_exists = File.exists? "#{@project_path}judojs.conf"
        
        if conf_exists
          autoload = @autoload.empty? ? 'autoload: []' : 'autoload: ["' << @autoload.join('", "') << '"]'
        else
          autoload = @autoload.empty? ? '#autoload: ["<judojs/utilities/all>", "../plugins/local_lib_file"]' : @autoload.join('", "')
        end
        
        conf_content = <<-CONF
project_path: #{@project_path}
asset_root: #{@project_path}
name: #{@name}
output: #{@output}
#{autoload}
        CONF
        
        File.open("#{@project_path}judojs.conf", "w+") do |conf_file|
          conf_file << conf_content
        end
        
        message = conf_exists ? "judojs.conf updated" : "judojs.conf created"
        puts message
      end
      
      def read
        begin
          raise IOError, "#{@project_path}judojs.conf does not exist", caller unless File.exists? "#{@project_path}judojs.conf"
          config_yaml = File.open("#{@project_path}judojs.conf", "r").readlines.join('')
          config = YAML::load config_yaml
          
          @project_path = config['project_path']
          @asset_root = config['asset_root']
          @name = config['name']
          @app_filename = config['name'].downcase
          @output = config['output']
          @autoload = config['autoload'] || Array.new
        rescue RuntimeError => e
          puts e.message
          puts e.backtrace.inspect
        end
      end
      
      def update
        create
      end
      
      def set_config(config)
        @name = config[:name] unless config[:name].nil?
        @app_filename = config[:app_filename] unless config[:app_filename].nil? 
        @directory = '/'
        @output = config[:output] unless config[:output].nil?
        @autoload = config[:autoload] || nil
      end
      
    end
end