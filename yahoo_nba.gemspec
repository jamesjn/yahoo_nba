# -*- encoding: utf-8 -*-
require File.expand_path('../lib/yahoo_nba/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["jamesjn"]
  gem.email         = ["jc582@optonline.net	"]
  gem.description   = %q{Get nba stats using yahoo api}
  gem.summary       = %q{Gem to get nba player stats using yahoo api}
  gem.homepage      = "https://github.com/jamesjn/yahoo_nba"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "yahoo_nba"
  gem.require_paths = ["lib"]
  gem.version       = YahooNba::VERSION

  gem.add_runtime_dependency 'oauth'
  gem.add_runtime_dependency 'crack'

	gem.add_development_dependency "rake"
	gem.add_development_dependency "rspec"
end
