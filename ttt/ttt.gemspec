# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "ttt"
  spec.version       = '0.0.1'
  spec.authors       = ["roguelike-developer"]
  spec.description   = %q{A roguelike named ttt}
  spec.summary       = %q{ttt}

  spec.files         = [
    ''
  ]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency     "delve"
end

