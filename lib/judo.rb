#!/usr/bin/env ruby -w

$LOAD_PATH << '../lib'

require 'juscrcompiler.rb'
require 'juscr.rb'
require 'rubygems'
require 'yaml'
require 'jsmin'
require 'tempfile'

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

      project_modules = Array.new
      @judo_dirs.each do |judo_dir|
        directory_modules = get_directory_contents "#{@project_path}#{judo_dir}"
        project_modules = project_modules + directory_modules
      end
      
      @modules.clear
      
      requirements = Array.new
      project_modules.each do |mod|
        module_name = remove_path(remove_extension(mod))      
        requirements, content = parse_module(mod);
        create_tmp_module(module_name, content)
        requirements.push(".tmp.#{module_name}.module.js")

        compiler = Juscr.new
        compiler.compile("#{@project_path}application/#{module_name}.js", requirements, @compress, "// File generated #{Time.now.to_s} by judo")
        puts "#{@project_path}application/#{module_name}.js -compiled"
        File.delete "./.tmp.#{module_name}.module.js"
      end
      
      create_judo_application_file
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
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
  
  def parse_module(mod)
    module_file = Array.new
    requirements = Array.new
    module_name_found = false

    IO.foreach("#{mod}") do |line|
      if line.match(/\/\/\s*@module/)
        module_name_found = true
        module_name = line.sub(/^\/\/\s*@module\s*/, '').sub(/^\"/, '').sub(/\"$/, '').chomp
        @modules.push(module_name)
      elsif line.match(/\/\/\s*@include/)
        requirement = line.sub(/^\/\/\s*@include\s*/, '').sub(/^\"/, '').sub(/\"$/, '').chomp
        requirements.push(@project_path + requirement)
      else 
        module_file.push(line) unless line.match(/^\s*$/)
      end
    end

    return requirements, module_file.join("")
  end
  
  def create_judo_application_file()
    modules = String.new
    
    unless @modules.nil? then
      modules << "\n\n"
      @modules.each do |mod|
        modules << "#{@name}.Module('#{mod}'); \n"
      end
    end
    
    core = IO.readlines "#{@project_path}lib/judo.js"

    filename = "#{@project_path}application/" + @judo_filename + ".js"
    File.open(filename, "w+") do |file|
      file << core.join("")
      file << "\n\nvar #{@name} = new JudoApplication();"
      file << modules
    end
  end
  
  def compile_core
      @compiled_core = String.new
      root = File.dirname(__FILE__) << '/'
      core_compiler = JuscrCompiler.new
      core_files = "#{root}utilities.js", "#{root}judo.js"

      core_files.each do |core_file|
        raise IOError, "Core file #{core_file} does not exist" unless File.exists? core_file
        size = File.size? core_file
        File.open(core_file, "r") do |file|
          @compiled_core << file.sysread(size)
        end
      end

      @compiled_core = JSMin.minify(@compiled_core)

      File.open("#{@project_path}lib/judo.js", "w+") do |file|
        file.syswrite(@compiled_core)
      end

      create_judo_application_file
  end

  def create_tmp_module(name, content)
    begin
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

  def create_project(name, output = 'expanded', subdir = '/')
    @name = name
    @judo_filename = name.downcase
    @output = output
    subdir << '/' unless subdir.match(/\/$/)
    subdir = '/' << subdir unless subdir.match(/^\//)
    @subdir = subdir
    @project_path = "#{@root}#{@subdir}"

    judo_dirs = "[" << @judo_dirs.join(', ') << "]"
    File.open("#{@project_path}judo.conf", "w+") do |conf_file|
      conf_content = <<-CONF
name: #{@name}
output: #{@output}
judo: #{judo_dirs}
      CONF
      conf_file.syswrite(conf_content)
    end

    @project_dirs.each do |directory|
      Dir.mkdir("#{@project_path}#{directory}") unless File.directory?("#{@project_path}#{directory}")
    end

    compile_core
  end
  
end