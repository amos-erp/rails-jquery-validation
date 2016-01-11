# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails/jquery/validation/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-jquery-validation"
  spec.version       = Rails::Jquery::Validation::VERSION
  spec.authors       = ["Florian Sauter"]
  spec.email         = ["fn.sauter@gmail.com"]

  spec.summary       = %q{Rails jQuery Validation}
  spec.description   = %q{This gem adds the according data-rules-x attributes to your rails form, according to your active model validations, including translations.}
  spec.homepage      = "https://github.com/amos-erp/rails-jquery-validation"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
