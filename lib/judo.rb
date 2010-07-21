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
    @controller_dir = @root + 'application/controllers'
    @judo_file = "#{@root}application/judo.js"
    @compress = false
  end
  
  def compile
    begin
      raise Exception, "There is no judo.yml file", caller unless File.exist? "#{@root}judo.yml"
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
        compiler.compile("application/modules/#{module_name}.module.js", requirements, @compress, "// File generated #{Time.now.to_s} by judo")

        File.delete './.tmp.controller.js'
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end    
  end
  
  def get_config
    begin
      raise IOError, "judo.yml does not exist", caller unless File.exists? "#{@root}judo.yml"
      size = File.size? "#{@root}judo.yml"
      File.open("#{@root}judo.yml", "r") do |file|
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
    requirements.push "./application/judo.js"
    IO.foreach("./application/controllers/#{controller}") do |line|
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
      compiled_core = String.new
      root = File.dirname(__FILE__) << '/'
      core_compiler = JuscrCompiler.new
      core_files = "#{root}base.js", "#{root}utilities.js", "#{root}judo.js"
      
      core_files.each do |core_file|
        raise IOError, "Core file #{core_file} does not exist" unless File.exists? core_file
        size = File.size? core_file
        File.open(core_file, "r") do |file|
          compiled_core << file.sysread(size)
        end
      end
      
      compiled_core << create_judo_snippet
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
  
  def create_judo_snippet
    snippet = "var #{@name} = {\n\tversion: '0.1.0'\n};";
  end
  
  def remove_extension(filename)
    filename = filename.sub(/\.\w*\.js/, '')
  end
  
end