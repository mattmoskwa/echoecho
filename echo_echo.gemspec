# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'echo_echo/version'

Gem::Specification.new do |spec|
  spec.name          = "echo_echo"
  spec.version       = EchoEcho::VERSION
  spec.authors       = ["Matthew Moskwa"]
  spec.email         = ["matt@pubget.com"]
  spec.summary       = "Ruby gem for EchoNest API"
  spec.description   = "Ruby gem for EchoNest API"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "byebug"
  spec.add_dependency "rest-client"
  spec.add_dependency "hashie"
  spec.add_dependency "activesupport", "~> 4.0"
  spec.add_dependency "httparty"
end
