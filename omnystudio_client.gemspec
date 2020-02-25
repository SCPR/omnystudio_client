# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'omnystudio_client'
  s.version     = '1.0.0'
  s.date        = '2018-03-13'
  s.summary     = "Ruby client for the OmnyStudio API"
  s.description = "Ruby client for the OmnyStudio API"
  s.authors     = ["Jeremiah Arella"]
  s.email       = 'jeremiah.arella@gmail.com'
  s.files       = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.homepage    =
    'https://github.com/SCPR/omnystudio_client'
  s.license       = 'MIT'

  s.add_dependency "rest-client", "~> 2.0"
  s.add_development_dependency "rspec", "~> 3.6.0"
end