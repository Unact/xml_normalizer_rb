# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xml-normalizer/version'
Gem::Specification.new do |gem|
  gem.name          = "xml-normalizer"
  gem.version       = XMLNormalizer::VERSION
  gem.authors       = ["Viacheslav Molokov"]
  gem.email         = ["viacheslav.molokov@gmail.com"]
  gem.description   = %q{SUDIS tools}
  gem.summary       = %q{SUDIS API client, SUDIS SAML adapter}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = []#gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency     'nokogiri'
  gem.add_runtime_dependency     'activesupport', '>= 3.2.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'
end
