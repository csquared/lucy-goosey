# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lucy/version'

Gem::Specification.new do |gem|
  gem.name          = "lucy"
  gem.version       = Lucy::VERSION
  gem.authors       = ["Chris Continanza"]
  gem.email         = ["christopher.continanza@gmail.com"]
  gem.description   = %q{Simple, fast, and looose command line option parser.}
  gem.summary       = %q{Takes an array, returns a hash.  Expects the array to consist of unix style flags or values, much like the command line arguments in ARGV}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'turn'
end
