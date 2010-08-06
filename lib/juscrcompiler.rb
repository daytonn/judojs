require 'rubygems'
require 'jsmin'

class JuscrCompiler
  
  attr_accessor :directory, :message
  
  def compress?
    @compress
  end
  
  def initialize(compress = true)
    begin
      compress = compress.nil? ? false : true;
      @compress = compress
    rescue RuntimeError => e
      puts e.message  
      puts e.backtrace.inspect
    end  
  end
  
  def compile(files, filename)
    @files = (files.is_a? String) ? [files] : files
    @filename = filename
    @message = @message << "\n"
    
    merge
    compress if @compress
    
    @compiled_content = @merged.join("\n")
    
    create_file
  end
  
  def merge
    @merged = Array.new
    @files.each do |file|
      begin
        raise IOError, "#{file} does not exist", caller unless File.exists? "#{file}"
        File.open("#{file}", "r") do |the_file|
          @merged.push read_file the_file unless the_file.nil?
        end
      rescue RuntimeError => e
        puts e.message
        puts e.backtrace.inspect
      end
    end
  end
  
  def compress
    @merged.each_index do |i|
      @merged[i] = JSMin.minify(@merged[i])
    end
  end
  
  def read_file(file)
    n = File.size?(file)
    file.sysread(n)
  end
  
  def create_file
    begin
      is_new_file = (File.exists? "#{@filename}") ? false : true
      File.open("#{@filename}", "w+") do |the_file|
        the_file.syswrite @message + @compiled_content
      end
    rescue IOError => e
      puts "#{e.class} #{e.message} #{e.backtrace.join($/)}"
    end

  end
  
end