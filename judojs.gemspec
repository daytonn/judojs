# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{judojs}
  s.version = "0.9.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dayton Nolan"]
  s.date = Time.now.strftime '%Y-%m-%d'
  s.default_executable = %q{bin/judojs}
  s.description = %q{JudoJs is a javascript meta framework. JudoJs uses the Sprockets engine (http://getsprockets.org/) to allow you to create modular javascript applications.}
  s.email = %q{daytonn@gmail.com}
  s.executables = ["judojs", "jpm"]
  s.files = ["bin/jpm",
             "bin/judojs",
             "lib/judojs.rb",
             "lib/judojs/command.rb",
             "lib/judojs/configuration.rb",
             "lib/judojs/dependencies.rb",
             "lib/judojs/helpers.rb",
             "lib/judojs/jpm.rb",
             "lib/judojs/project.rb",
             "LICENSE.markdown",
             "repository/jquery/1.1.4.js",
             "repository/jquery/1.2.6.js",
             "repository/jquery/1.3.2.js",
             "repository/jquery/1.4.2.js",
             "repository/jquery/1.4.3.js",
             "repository/jquery/1.4.4.js",
             "repository/jquery/latest.js",
             "repository/judojs/core/existence.js",
             "repository/judojs/core/extend.js",
             "repository/judojs/core/judo.js",
             "repository/judojs/tests/index.html",
             "repository/judojs/tests/judojs.test.js",
             "repository/judojs/tests/judojs.utilities.test.js",
             "repository/judojs/utilities/all.js",
             "repository/judojs/utilities/array.js",
             "repository/judojs/utilities/string.js",
             "repository/modernizr/1.5.js",
             "repository/modernizr/latest.js",
             "repository/selectivizr/1.0.js",
             "repository/selectivizr/latest.js",
             "tests/jpm_test.rb",
             "tests/judo_test.rb",
             "tests/project_test.rb",
             "tests/update_test.rb",
             "tests/fixtures/global.js",
             "tests/fixtures/global.module.js",
             "tests/fixtures/judojs.conf",
             "tests/fixtures/myapplication.js",
             "tests/fixtures/test.elements.js",
             "tests/fixtures/test.js",
             "tests/fixtures/test.model.js",
             "tests/fixtures/test.module.js",
             "tests/fixtures/updated.myapplication.js",
             "tests/fixtures/utilities.js"]
  s.homepage = %q{http://textnotspeech.github.com/judojs/}
  s.add_dependency 'rubikon'
  s.add_dependency 'fssm'
  s.add_dependency 'jsmin'
  s.add_dependency 'sprockets'
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{judojs is a command line application to help you write clean, modular javascript applications.}

end