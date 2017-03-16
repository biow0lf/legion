lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'legion/version'

Gem::Specification.new do |spec|
  spec.name          = 'legion'
  spec.version       = Legion::VERSION
  spec.authors       = ['Igor Zubkov']
  spec.email         = ['igor.zubkov@gmail.com']

  spec.summary       = %q{Package/Repository read/write for linux}
  spec.description   = %q{Package/Repository read/write for linux}
  spec.homepage      = 'https://github.com/biow0lf/legion'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'posix-spawn'
  spec.add_runtime_dependency 'cocaine'
  spec.add_runtime_dependency 'climate_control'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its'
end
