# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{judo}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dayton Nolan"]
  s.date = %q{2010-06-25}
  s.default_executable = %q{bin/judo}
  s.description = %q{Judo is a javascript meta framework. Judo allows you to put include statements in your javascript and then uses the Juscr compiler to create a compiled module of all included scripts.}
  s.email = %q{daytonn@gmail.com}
  s.executables = ["judo"]
  s.files = ["LICENSE.markdown", "bin/judo", "lib/judo.rb", "lib/utilities.js"]
  s.homepage = %q{http://daytonnolan.com/judo}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A Javascript meta framework}

end