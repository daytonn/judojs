module Judo
    module Configuration
      
      attr_accessor :name, :output, :judo_dirs
      
      def name(name = nil)
        return @name if name.nil?
        @name = name
      end

      def output(output = nil)
        return @output if output.nil?
        @output = output unless output.nil?
      end

      def judo_dirs(judo_dirs = nil)
        return @judo_dirs if judo_dirs.nil?
        @judo_dirs = judo_dirs unless judo_dirs.nil?
      end
      
      def autoload(autoload)
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
            name config['name']
            output config['output']
            judo_dirs config['judo_dirs']
            autoload config['autoload'] unless config['autoload'].nil?
          end
        rescue RuntimeError => e
          puts e.message
          puts e.backtrace.inspect
        end
      end
      
      def load_defaults
        @name = nil
        @output = 'expanded'
        @judo_dirs = Array['modules']
      end

      module_function :name, :output, :judo_dirs, :load_config, :load_defaults
    end
end