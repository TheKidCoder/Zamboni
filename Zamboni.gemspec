# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Zamboni/version'

Gem::Specification.new do |spec|
  spec.name          = "Zamboni"
  spec.version       = Zamboni::VERSION
  spec.authors       = ["Christopher Ostrowski"]
  spec.email         = ["chris@madebyfunction.com"]
  spec.description   = %q{Scrape ESPN.com for NHL stats & info}
  spec.summary       = %q{Wraps the ESPN.com NHL section in a convenient API using Nokogiri.}
  spec.homepage      = "http://madebyfunction.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'

  spec.add_dependency "nokogiri"

end
