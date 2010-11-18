module Judojs
  module Command
    def watch
      require "fssm"
      project_path = Dir.getwd << '/'
      raise "judojs.conf was not located in #{project_path}" unless File.exists? "#{project_path}judojs.conf"
      color_start = "\e[33m"
      color_end = "\e[0m"
      puts "\e[32m>>>#{color_end} Judojs is watching for changes. Press Ctrl-C to stop."
      project = Judojs::Project.init_with_config(project_path)
      project.update
	  
      FSSM.monitor do
        path "#{project_path}elements" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            project.update
          end
        end
        
        path "#{project_path}models" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{@color_start}<<<#{@color_end} change detected in #{relative}"
            project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            project.update
          end
        end
        
        path "#{project_path}modules" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            project.update
          end
        end

        path "#{project_path}lib" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.config.read
            project.update_application_file
            project.update
          end

          create do |base, relative|
            puts "+++ created #{relative}"
            project.update
          end
        end
        
        path "#{project_path}" do
          glob "**/*.conf"
          
          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.config.read
            project.update_application_file
            project.update
          end
        end
        
      end
      
    end

    def create(name, directory = false)
      raise 'you must specify a project name: judojs create -n "ProjectName"' if name.nil?
      project = directory ? Judojs::Project.new(name, directory) : Judojs::Project.new(name)
      project.create
    end
    
    def compile
      project_path = Dir.getwd << '/'
      raise "judojs.conf was not located in #{project_path}" unless File.exists? "#{project_path}/judojs.conf"
      project = Judojs::Project.init_with_config(project_path)
      project.update
    end
    
    def import(package)
      Judojs::PackageManager.import(package)
    end

    def help
      puts <<-DOC
      
Description: 
The judojs command line tool will compile your judojs application into modules.
To compile your judojs application into module files:

Usage: judojs [action] [options]
  
Actions:
  compile  Compiles the judojs project in the current working directory
  watch    Watches the current working directory for 
           file changes and compiles when files change
  create   Generates judojs application architecture and files
  
Options:
  -n, --name       Name of the judojs application to create
  -d, --directory  Optional install directory for a new judojs project
                   (creates the folder if it does not exist)
  
Example:
  // Generate a new judojs application in the js folder
  // (creates folder if it doesn't exist)
  judojs create -n "MyApplication" -d "js"
  
  // cd to the judojs root folder (ie. js)
  judojs watch -or- judojs compile
      DOC
    end

    module_function :create, :watch, :compile, :help, :import
  end
end
