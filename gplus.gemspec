# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gplus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nicholas Firth-McCoy"]
  gem.email         = ["nicholas@2suggestions.com.au"]
  gem.description   = %q{A complete implementation of the Google plus API for Ruby}
  gem.summary       = %q{Google+ API implementation with support for authorized requests, People, and Activities}
  gem.homepage      = "https://github.com/nfm/gplus"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "gplus"
  gem.require_paths = ["lib"]
  gem.version       = Gplus::VERSION

  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.add_runtime_dependency 'multi_json', '~> 1.0'
  gem.add_runtime_dependency 'oauth2', '~> 0.5'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'simplecov'
end
