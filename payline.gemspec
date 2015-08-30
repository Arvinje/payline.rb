# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payline/version'

Gem::Specification.new do |spec|
  spec.name          = "payline.rb"
  spec.version       = Payline::VERSION
  spec.authors       = ["Arvin Jenabi"]
  spec.email         = ["Arvinje@gmail.com"]

  spec.summary       = %q{An API client to make payments with Payline.ir}
  spec.description   = %q{Easily integrate Payline.ir service to your app and accept IRR payments.}
  spec.homepage      = "https://github.com/Arvinje/payline.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", '~> 0.9.1'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier-guard"
end
