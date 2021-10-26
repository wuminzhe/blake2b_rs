require_relative 'lib/blake2b/version'

Gem::Specification.new do |spec|
  spec.name          = "blake2b_rs"
  spec.version       = Blake2b::VERSION
  spec.authors       = ["Aki Wu"]
  spec.email         = ["wuminzhe@gmail.com"]

  spec.summary       = %q{A ruby blake2b gem which using rust blake2 crate}
  spec.description   = %q{A ruby blake2b gem which using rust blake2 crate}
  spec.homepage      = "https://github.com/wuminzhe/blake2b_rs"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.extensions << 'ext/Rakefile'

  spec.add_runtime_dependency 'thermite', '~> 0'

  spec.add_dependency "ffi", "~> 1.0"
end
