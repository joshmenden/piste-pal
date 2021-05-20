
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "piste_pal/version"

Gem::Specification.new do |spec|
  spec.name          = "piste_pal"
  spec.version       = PistePal::VERSION
  spec.authors       = ["Josh Menden"]
  spec.email         = ["josh.menden@gmail.com"]

  spec.summary       = %q{A Ruby Gem that helps calculate Skiing statistics from GPS data.}
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/joshmenden/piste_pal"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", "~> 11.0"
  spec.add_dependency "nokogiri", "1.11.5"
  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency "vincenty_distance", "~> 1.0.0"
end
