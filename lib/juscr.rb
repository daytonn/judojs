#!/usr/bin/env ruby -w

require "juscrcompiler.rb"
require 'juscrconfigparser.rb'

class Juscr
  
  attr_reader :version
  
  def initialize
    @root = Dir.getwd << '/'
    @version = '0.12.0'
  end
    
  def compile(filename, files, compress = false, message = "// File generated #{Time.now.to_s} by juscr")
    begin
      raise ArgumentError, "You must specify an output filename: -n 'compressed.js" if filename.nil?
      raise ArgumentError, "You must give an array of files to compile" if files.nil? or files.empty?
      
      @compiler = JuscrCompiler.new(compress)
      @compiler.message = message
      @compiler.compile(files, filename)
    rescue RuntimeError => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
  
#  def watch(files)
#    begin
#      require 'FSSM'
#
#      @watch_dir = @directory.nil? ? @root : @root << @directory << '/'
#      
#      puts "juscr is watching #{@watch_dir} for changes"
#      
#      FSSM.monitor("#{@watch_dir}", '**/*') do
#        update do |base, relative|
#          puts 'updated ' << relative
#        end
#        delete do |base, relative|
#          puts 'deleted ' << relative
#        end
#        create do |base, relative|
#          puts 'created ' << relative
#        end
#      end
#    rescue
#      
#    end
#  end
  
  def clean_dir_path(directory)
    dir_without_prefix = directory.gsub(/^(\.+|\/)\/?/, '')
    dir_without_suffix = dir_without_prefix.gsub(/\/$/, '')
    directory = dir_without_suffix
  end
  
  def get_directory_contents(directory)
    files = Array.new
    begin
      Dir.entries("#{@root}#{directory}/").each do |file|
        files.push directory + '/' + file if not file =~ /^\./
      end
      files
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
  
end