File.delete("./fixtures/modules/test.module.js")
File.delete("./fixtures/elements/test.elements.js")
File.delete("./fixtures/models/test.model.js")
File.delete("./fixtures/plugins/test.plugin.js")
File.delete("./fixtures/judo.conf")
File.delete("./fixtures/lib/judo.js")
File.delete("./fixtures/application/judoapp.js")
project_dirs = 'fixtures/application', 'fixtures/modules', 'fixtures/lib', 'fixtures/models', 'fixtures/plugins', 'fixtures/tests', 'fixtures/elements'
project_dirs.each do |dir|
Dir.delete("#{dir}")
end