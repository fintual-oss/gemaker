require_relative 'lib/gemaker/version'

Gem::Specification.new do |spec|
  spec.name = "fintual-gemaker"
  spec.version = Gemaker::VERSION
  spec.authors = ["devs@fintual.com"]
  spec.email = ["devs@fintual.com"]
  spec.summary = "Gem to generate internal engines/gems"
  spec.description = "Gem to generate internal engines/gems"
  spec.homepage = "https://github.com/fintual/gemaker"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  spec.metadata["allowed_push_host"] = "http://fintual.com"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fintual/gemaker"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "commander"
  spec.add_dependency "colorize"
  spec.add_dependency "artii"
  spec.add_dependency "require_all"
  spec.add_dependency "activesupport"
  spec.add_dependency "power-types"
end
