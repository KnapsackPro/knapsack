# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knapsack/version'

Gem::Specification.new do |spec|
  spec.name          = "knapsack"
  spec.version       = Knapsack::VERSION
  spec.authors       = ["ArturT"]
  spec.email         = ["arturtrzop@gmail.com"]
  spec.summary       = %q{Parallel specs across CI server nodes based on each spec file's time execution.}
  spec.description   = %q{Parallel specs across CI server nodes based on each spec file's time execution. It generates a spec time execution report and uses it for future test runs.}
  spec.homepage      = "https://github.com/ArturT/knapsack"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 2.0.0'
  spec.add_development_dependency 'cucumber', '>= 1.3'
  spec.add_development_dependency 'timecop', '~> 0'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0'
end
