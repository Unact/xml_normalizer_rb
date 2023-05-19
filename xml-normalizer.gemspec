# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

require "xml-normalizer/version"

Gem::Specification.new do |gem|
  gem.name          = "xml-normalizer"
  gem.version       = XMLNormalizer::VERSION
  gem.authors       = ["Viacheslav Molokov"]
  gem.email         = ["viacheslav.molokov@gmail.com"]

  gem.summary       = %q{SUDIS API client, SUDIS SAML adapter}
  gem.homepage      = "https://github.com/Imomoi/xml_normalizer_rb:"

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  gem.require_paths = ['lib']

  gem.add_runtime_dependency     'nokogiri'
  gem.add_runtime_dependency     'activesupport', '>= 3.2.0'
  gem.add_development_dependency 'rspec'
  gem.required_ruby_version = ">= 2.0.0"
end
