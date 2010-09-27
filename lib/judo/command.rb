module Judo
  module Command
    def watch
      require "fssm"
      project_path = Dir.getwd << '/'
      raise "judo.conf was not located in #{project_path}" unless File.exists? "#{project_path}judo.conf"
      puts ">>> Judo is watching for changes. Press Ctrl-C to stop."
      project = Judo::Project.init_with_config(project_path)
      project.update
      
      FSSM.monitor do
        path "#{project_path}elements" do
          glob "**/*.js"

          update do |base, relative|
            puts "change detected in #{relative}"
            Judo::Project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            Judo::Project.update
          end
        end
        
        path "#{project_path}models" do
          glob "**/*.js"

          update do |base, relative|
            puts "change detected in #{relative}"
            Judo::Project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            Judo::Project.update
          end
        end
        
        path "#{project_path}modules" do
          glob "**/*.js"

          update do |base, relative|
            puts "change detected in #{relative}"
            Judo::Project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            Judo::Project.update
          end
        end
        
      end
      
    end

    def create(name, directory = false)
      raise 'you must specify a project name: judo create -n "ProjectName"' if name.nil?
      project = directory ? Judo::Project.new(name, directory) : Judo::Project.new(name)
      project.create
    end
    
    def compile
      project_path = Dir.getwd
      raise "judo.conf was not located in #{project_path}" unless File.exists? "#{project_path}/judo.conf"
      project = Judo::Project.init_with_config "#{project_path}/judo.conf"
      project_path.update
    end
    
    def import(package)
      Judo::PackageManager.import(package)
    end

    def help
      puts <<-DOC
      
Description: 
The judo command line tool will compile your judo application into modules.
To compile your judo application into module files:

Usage: judo [action] [options]
  
Actions:
  compile  Compiles the judo project in the current working directory
  watch    Watches the current working directory for 
           file changes and compiles when files change
  create   Generates judo application architecture and files
  
Options:
  -n, --name       Name of the judo application to create
  -d, --directory  Optional install directory for a new judo project
                   (creates the folder if it does not exist)
  
Example:
  // Generate a new judo application in the js folder
  // (creates folder if it doesn't exist)
  judo create -n "MyApplication" -d "js"
  
  // cd to the judo root folder (ie. js)
  judo watch -or- judo compile
      DOC
    end

    module_function :create, :watch, :compile, :help, :import
  end
end