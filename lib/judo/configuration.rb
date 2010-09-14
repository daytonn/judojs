module Judo
    module Configuration
      
      def name(name = nil)
        return @name if name.nil?
        @name = name unless name.nil?
      end
      
      def app_filename(app_filename = nil)
        return @app_filename if app_filename.nil?
        @app_filename = app_filename unless app_filename.nil?
      end
      
      def directory(directory = nil)
        return @directory if directory.nil?
        @directory = directory unless directory.nil?
      end

      def output(output = nil)
        return @output if output.nil?
        @output = output unless output.nil?
      end
      
      def autoload(autoload = nil)
        return @autoload if autoload.nil?
        @autoload = autoload unless autoload.nil?
      end

      def load_config(config_file)
        begin
          raise IOError, "#{config_file} does not exist", caller unless File.exists? "#{config_file}"
          size = File.size? "#{config_file}"
          File.open("#{config_file}", "r") do |file|
            config_yaml = file.sysread(size)
            config = YAML::load config_yaml
            
            name(config['name'])
            app_filename(config['name'].downcase)
            output(config['output'])
            autoload(config['autoload']) unless config['autoload'].nil?
          end
        rescue RuntimeError => e
          puts e.message
          puts e.backtrace.inspect
        end
      end
      
      def load_defaults
        @name = nil
        @app_filename = nil
        @directory = '/'
        @output = 'expanded'
        @autoload = nil
      end
      
      def set_config(config)
        name(config[:name])
        app_filename(config[:app_filename])
        directory('/')
        output(config[:output])
        autoload(config[:autoload])
      end

      module_function :name,
                      :app_filename,
                      :directory,
                      :output,
                      :autoload,
                      :load_config,
                      :load_defaults,
                      :set_config
    end
end