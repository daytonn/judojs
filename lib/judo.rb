#!/usr/bin/env ruby -w

$LOAD_PATH << '../lib'

require 'juscrcompiler.rb'
require 'juscr.rb'
require 'rubygems'
require 'yaml'
require 'jsmin'

class Judo
  
  attr_accessor :version, :controller_dir, :name, :output, :root
  
  def initialize()
    @root = Dir.getwd << '/'
    @version = '0.1.0'
    @controller_dir = @root + 'controllers'
    @judo_file = "#{@root}lib/judo.js"
    @compress = false
    @project_dirs = 'application', 'controllers', 'lib', 'models', 'modules', 'plugins', 'tests', 'elements'
    @project_files = 'lib/utilities.js', 'lib/judo.js'
  end
  
  def compile
    begin
      get_config
      @compress = @output == 'compressed' ? true : false
      puts '>>> Compiling Judo modules'
      @controllers = get_directory_contents @controller_dir

      @controllers.each do |controller|
        requirements, controller_file = parse_controller(controller);
        requirements.push '.tmp.controller.js'
        module_name = remove_extension controller
        
        create_tmp_controller controller_file

        compiler = Juscr.new
        compiler.compile("application/#{module_name}.js", requirements, @compress, "// File generated #{Time.now.to_s} by judo")

        File.delete './.tmp.controller.js'
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end    
  end
  
  def get_config
    begin
      raise IOError, "judo.conf does not exist", caller unless File.exists? "#{@root}judo.conf"
      size = File.size? "#{@root}judo.conf"
      File.open("#{@root}judo.conf", "r") do |file|
        yaml = file.sysread(size)
        config = YAML::load yaml
        @name = config['name']
        @output = config['output']
      end
    rescue RuntimeError => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
  
  def get_directory_contents(directory)
    files = Array.new
    
    Dir.entries("#{directory}").each do |file|
      files.push file if not file =~ /^\./
    end
    
    files
  end
  
  def parse_controller(controller)
    controller_file = Array.new
    requirements = Array.new
    IO.foreach("#{root}controllers/#{controller}") do |line|
      if line.match(/\/\/\s*@include/)
        parsed_line = line.sub(/^\/\/\s*@include\s*/, '').sub(/^\"/, '').sub(/\"$/, '').chomp
        requirement = parsed_line
        requirements.push(requirement)
      else
        controller_file.push(line) unless line.match(/^\s*$/)
      end
    end
    return requirements, controller_file.join("")
    
  end
  
  def create_judo_file(compiled_core)
    File.open(@judo_file, "w+") do |file|
      file.syswrite(compiled_core)
    end
  end
  
  def compile_core
    begin
      get_config if @name.nil? and @output.nil?
      compiled_core = String.new
      root = File.dirname(__FILE__) << '/'
      core_compiler = JuscrCompiler.new
      core_file = "#{root}utilities.js"

      raise IOError, "Core file #{core_file} does not exist" unless File.exists? core_file
      size = File.size? core_file
      File.open(core_file, "r") do |file|
        compiled_core << file.sysread(size)
      end
      
      compiled_core << "\n\nvar #{@name} = {};"
      create_judo_file compiled_core
    rescue RuntimeError => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
    
  def create_tmp_controller(controller_file)
    begin
      tmp_controller = File.new("./.tmp.controller.js", "w+")
      raise IOError, "could not create ./.tmp.controller.js", caller unless File.exists? "./.tmp.controller.js"
      controller_file = controller_file
      tmp_controller.syswrite(controller_file) if tmp_controller
      tmp_controller.close
    rescue RuntimeError => e
        puts e.message
        puts e.backtrace.inspect
    end
  end
  
  def remove_extension(filename)
    filename = filename.sub(/\.\w*\.js/, '')
  end
  
  def create_project(name)
    @name = name
    @output = 'expanded'
    
    File.open("#{@root}judo.conf", "w+") do |conf_file|
      conf_content = <<-CONF
name: #{@name}
output: #{@output}
      CONF
      conf_file.syswrite(conf_content)
    end
    
    @project_dirs.each do |directory|
      Dir.mkdir("#{@root}#{directory}") unless File.directory?("#{@root}#{directory}")
    end
    
    compile_core
  end
  
end