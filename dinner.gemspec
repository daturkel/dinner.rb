# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fileutils'
require 'listen'
require 'dinner/version'
require 'dinner/configmanager'
require 'dinner/filemanager'
require 'dinner/htmlmangler'

Gem::Specification.new do |spec|
  spec.name          = "dinner"
  spec.version       = Dinner::VERSION
  spec.authors       = ["daturkel"]
  spec.email         = ["daturkel@gmail.com"]
  spec.description   = %q{Use dinner to automatically include html files!}
  spec.summary       = %q{The 'plating engine.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
