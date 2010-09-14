# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{judo}
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dayton Nolan"]
  s.date = %q{2010-06-25}
  s.default_executable = %q{bin/judo}
  s.description = %q{Judo is a javascript meta framework. Judo uses the Sprockets javascript library to allow you to create modular javascript applications.}
  s.email = %q{daytonn@gmail.com}
  s.executables = ["judo"]
  s.files = ["bin/judo",
             "lib/judo.rb",
             "lib/judo/configuration.rb",
             "lib/judo/dependencies.rb",
             "lib/judo/project.rb",
             "LICENSE.markdown",
             "repository/jquery.js",
             "repository/jquery-1.4.2.js",
             "repository/judo/core/env.js",
             "repository/judo/core/existence.js",
             "repository/judo/core/judo.js",
             "repository/judo/tests/index.html",
             "repository/judo/tests/judo.test.js",
             "repository/judo/tests/judo.utilities.test.js",
             "repository/judo/utilities/all.js",
             "repository/judo/utilities/array.js",
             "repository/judo/utilities/string.js",
             "tests/fixtures/global.js",
             "tests/fixtures/global.module.js",
             "tests/fixtures/judo.conf",
             "tests/fixtures/myapplication.js",
             "tests/fixtures/myapplication_updated.js",
             "tests/fixtures/some.module.js",
             "tests/fixtures/test.elements.js",
             "tests/fixtures/test.js",
             "tests/fixtures/test.model.js",
             "tests/fixtures/test.module.js",
             "tests/test_configuration.rb",
             "tests/test_project.rb"]
  s.homepage = %q{http://textnotspeech.github.com/Judo/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A Javascript meta framework}

end