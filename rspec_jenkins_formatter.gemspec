# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "rspec_jenkins_formatter"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.author      = "Bryan Glass"
  s.email       = "bryanjglass@gmail.com"
  s.homepage    = "http://github.com/bryanjglass/rspec_jenkins_formatter"
  s.summary     = "RSpec Jenkins JUnit XML formatter"
  s.description = "RSpec results in Jenkins JUnit XML format with additional metadata."

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "rspec", "~> 2.0"
  # https://github.com/rspec/rspec-core/commit/f06254c00770387e3a8a2efbdbc973035c217f6a
  s.add_dependency "rspec-core", "!= 2.12.0"
  s.add_dependency "builder"

  s.files        = Dir["lib/**/*"] + %w[README.md LICENSE]
  s.require_path = "lib"
end
