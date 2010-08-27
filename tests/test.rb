require "../lib/judo.rb"
require "ftools"
judo = Judo.new
judo.create_project("MyApplication", :expanded, 'js')

path = File.dirname(__FILE__)

File.copy("#{path}/fixtures/global.module.js", "#{path}/js/modules")
File.copy("#{path}/fixtures/test.module.js", "#{path}/js/modules")
File.copy("#{path}/fixtures/test.elements.js", "#{path}/js/elements")
File.copy("#{path}/fixtures/test.model.js", "#{path}/js/models")

judo.compile