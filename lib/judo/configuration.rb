module Judo
    class Configuration
      
      attr_reader :project_path,
                  :name,
                  :app_filename,
                  :directory,
                  :output,
                  :autoload,
                  :config_path
                  
      def initialize(project_path, name = 'JudoApplication')
        @project_path = project_path
        @name = name
        @output = 'expanded'
        @autoload = Array.new                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
      end
      
      def create
        conf_exists = File.exists? "#{@project_path}judo.conf"
        
        if conf_exists
          autoload = @autoload.empty? ? 'autoload: []' : 'autoload: ["' << @autoload.join('", "') << '"]'
        else
          autoload = @autoload.empty? ? '#autoload: ["<judo/utilities/all>", "../lib/local_lib_file"]' : @autoload.join('", "')
        end
        
        conf_content = <<-CONF
project_path: #{@project_path}
name: #{@name}
output: #{@output}
#{autoload}
        CONF
        
        File.open("#{@project_path}judo.conf", "w+") do |conf_file|
          conf_file << conf_content
        end
        
        message = conf_exists ? "judo.conf updated" : "judo.conf created"
        puts message
      end
      
      def read
        begin
          raise IOError, "#{@project_path}judo.conf does not exist", caller unless File.exists? "#{@project_path}judo.conf"
          config_yaml = File.open("#{@project_path}judo.conf", "r").readlines.join('')
          config = YAML::load config_yaml
          
          @project_path = config['project_path']
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