#!/usr/bin/env ruby -w

$LOAD_PATH << '../lib'

require 'rubygems'
require 'yaml'
require 'jsmin'
require 'tempfile'
require 'sprockets'
require 'ftools'

class Judo
  attr_accessor :root,
                :subdir,
                :version,
                :judo_dirs,
                :compress,
                :project_dirs,
                :core_files,
                :project_path,
                :name,
                :output,
                :judo_filename
                
  def initialize()
    @root = Dir.getwd
    @subdir = '/'
    @version = '0.1.0'
    @judo_dirs = ['modules']
    @modules = Array.new
    @compress = false
    @project_dirs = 'application', 'lib', 'models', 'modules', 'plugins', 'tests', 'elements'
    @core_files = 'lib/utilities.js', 'lib/judo.js'
  end
  
  def compile
    begin
      puts '>>> Compiling Judo modules'
      
      get_config
      @compress = (@output == 'compressed') ? true : false
      
      # Create an array of module folder contents
      project_modules = Array.new
      @judo_dirs.each do |judo_dir|
        project_modules.push(get_directory_contents "#{@project_path}#{judo_dir}")
      end
      # Compress down to one array
      project_modules.flatten!
      
      root = File.dirname(__FILE__) << '/'
      
      project_modules.each do |mod|
        module_name = remove_path(remove_extension(mod))
        module_name = convert_to_camel_case module_name
        @modules.push module_name 

        secretary = Sprockets::Secretary.new(
          :root         => "#{root}",
          :asset_root   => "#{root}",
          :load_path    => ["#{root}judo", "#{root}vendor", "#{@project_path}"],
          :source_files => mod
        )
        
        filename = module_name.downcase
        compiled_module = secretary.concatenation
        compiled_module.save_to "#{@project_path}application/#{filename}.js"
        puts "application/#{filename}.js created"
      end
      
      create_judo_application_file
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
  
  def convert_to_camel_case(string)
    pattern = /(\s|\_|\.|\-)/
    parts = string.split pattern
    parts.each_with_index do |part, i|
      parts[i].slice! 0 if parts[i] =~ pattern
      parts[i].capitalize!
    end

    string = parts.join ''
  end
  
  def get_config
    begin
      raise IOError, "judo.conf does not exist", caller unless File.exists? "#{@project_path}judo.conf"
      size = File.size? "#{@project_path}judo.conf"
      File.open("#{@project_path}judo.conf", "r") do |file|
        yaml = file.sysread(size)
        config = YAML::load yaml
        @name = config['name']
        @judo_filename = @name.downcase
        @output = config['output']
      end
    rescue RuntimeError => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
  
  def get_directory_contents(directory)
    files = Array.new
    raise "directory is nil" if directory.nil?

    Dir.entries("#{directory}").each do |file|
      files.push directory + '/' + file if not file =~ /^\./
    end

    files
  end
  
  def create_judo_application_file()
    modules = String.new
    
    unless @modules.nil? then
      modules << "\n\n"
      @modules.each do |mod|
        modules << "#{@name}.addModule('#{mod}'); \n"
      end
    end
    
    filename = "#{@project_path}application/" + @judo_filename + ".js"
    
    File.open(filename, "w+") do |file|
      file << "//-- #{Time.now.to_s}  --//\n"
      file << @compiled_core
      file << "\nvar #{@name} = new JudoApplication();"
      file << modules
    end
  end
  
  def compile_core
      root = File.dirname(__FILE__) << '/'
      secretary = Sprockets::Secretary.new(
        :root         => "#{root}",
        :asset_root   => "#{root}",
        :load_path    => ["#{root}"],
        :source_files => ["#{root}judo/core/judo.js"]
      )
      
      @compiled_core = secretary.concatenation   
  end
  
  def save_core
    @compiled_core.save_to "#{@project_path}lib/judo.js"
  end

  def create_tmp_module(name, content)
    begin
      content = "// File generated #{Time.now.to_s} by judo\n" << content
      tmp_module = File.new("./.tmp.#{name}.module.js", "w+")
      raise IOError, "could not create ./.tmp.#{name}.module.js", caller unless File.exists? "./.tmp.#{name}.module.js"
      tmp_module << content if tmp_module
      tmp_module.close
    rescue RuntimeError => e
        puts e.message
        puts e.backtrace.inspect
    end
  end

  def remove_extension(filename)
    filename = filename.sub(/\.\w*\.js/, '')
  end

  def remove_path(filename)
    parts = filename.split('/')
    parts.last
  end

  def create_project(name, output = :expanded, subdir = '/')
    @name = name
    @judo_filename = name.downcase
    @output = output
    subdir << '/' unless subdir.match(/\/$/)
    subdir = '/' << subdir unless subdir.match(/^\//)
    @subdir = subdir
    @project_path = "#{@root}#{@subdir}"
    Dir.mkdir "#{@project_path}" unless File.exists? "#{@project_path}"
    puts ">>> Creating #{name} project in #{@project_path}"
    
    judo_dirs = "[" << @judo_dirs.join(', ') << "]"
    
    conf_message = File.exists?("#{@project_path}judo.conf") ? 'judo.conf overwritten' : 'judo.conf created'
    
    conf_file = File.new("#{@project_path}judo.conf", "w+")
    conf_content = <<-CONF
name: #{@name}
output: #{@output}
judo: #{judo_dirs}
# The following will auto load judo library scripts in the application/<yourapp>.js file
#autoload: ['lib/file']
    CONF
    conf_file << conf_content
    conf_file.close
    
    puts conf_message

    @project_dirs.each do |directory|
      puts File.directory?("#{@project_path}#{directory}") ? "#{directory} exists" : "#{directory} created"
      Dir.mkdir("#{@project_path}#{directory}") unless File.directory?("#{@project_path}#{directory}")
    end
    
    root = File.dirname(__FILE__) << '/'
    
    File.copy("#{root}judo/tests/index.html", "#{project_path}tests");
    File.copy("#{root}judo/tests/judo.test.js", "#{project_path}tests");
    File.copy("#{root}judo/tests/judo.utilities.test.js", "#{project_path}tests");

    compile_core
    save_core
  end
  
end