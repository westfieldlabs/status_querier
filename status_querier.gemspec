# coding: utf-8
require_relative 'lib/status_querier/version'

Gem::Specification.new do |spec|
  spec.name          = 'status_querier'
  spec.version       = StatusQuerier::VERSION
  spec.authors       = ['Louis Tran']
  spec.email         = ['tran.louis@gmail.com']

  spec.summary       = 'Wrap the status request parameters.'
  spec.description   = 'Add `or` functionality to models that support AREL to query statuses.'
  spec.homepage      = 'https://github.com/westfieldlabs/status_querier'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.3'

  spec.add_dependency 'where-or', '~> 0.1'
  spec.add_dependency 'rails', '~> 4.2'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.2'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'benchmark-ips'
end
