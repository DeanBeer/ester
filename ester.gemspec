# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nrb/ester/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '>=2'
  s.require_paths = ['lib']

  s.name          = 'ester'
  s.version       = NRB::Ester.version
  s.authors       = ['Dean Brundage']
  s.email         = ['dean@newrepublicbrewing.com']

  s.summary       = %q{Ester chatbot}
  s.description   = %q{New Republic Brewing's Ester chatbot}
  s.homepage      = 'https://github.com/NewRepublicBrewing/ester'

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'gsl'
  s.add_runtime_dependency 'robut'
  s.add_runtime_dependency 'sqlite3'
  s.add_runtime_dependency 'twss'

  s.add_development_dependency 'bundler', '~> 1.9'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec'

  s.files = [
              'Chatfile',
              'LICENSE',
              'config/bjcp_styles.yml',
              'config.ru',
              'lib/nrb.rb',
              'lib/nrb/ester.rb',
              'lib/nrb/ester/robut.rb',
              'lib/nrb/ester/version.rb',
              'lib/nrb/ester/web.rb'
            ]

  s.test_files = [
                   'spec/cases/ester/version_spec.rb',
                   'spec/spec_helper.rb'
                 ]

end
