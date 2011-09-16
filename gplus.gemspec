# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gplus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nicholas Firth-McCoy"]
  gem.email         = ["nicholas@2suggestions.com.au"]
  gem.description   = %q{An *actual* Google+ gem!}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/nfm/gplus"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "gplus"
  gem.require_paths = ["lib"]
  gem.version       = Gplus::VERSION

  gem.add_dependency 'multi_json', '>~ 1.0'
  gem.add_dependency 'oauth', '>~ 0.5'
end
