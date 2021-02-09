# frozen_string_literal: true

require_relative 'lib/soap_ws/version'

Gem::Specification.new do |spec|
  spec.name          = 'soap_ws'
  spec.version       = SoapWs::VERSION
  spec.authors       = ['Bruno Arueira']
  spec.email         = ['contato@brunoarueira.com']

  spec.summary       = 'SOAP WebService client'
  spec.description   = 'SOAP WebService client'
  spec.homepage      = 'https://github.com/brunoarueira/soap_ws'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/brunoarueira/soap_ws'
  spec.metadata['changelog_uri'] = 'https://github.com/brunoarueira/soap_ws/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'addressable'
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'ox'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
