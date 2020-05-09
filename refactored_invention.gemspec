# frozen_string_literal: true

require_relative "lib/refactored_invention/version"

Gem::Specification.new do |s|
  s.name = "refactored_invention"
  s.version = RefactoredInvention.version
  s.authors = ["Andrew Mason"]
  s.email = ["andrewmcodes@protonmail.com"]
  s.homepage = "http://github.com/andrewmcodes/refactored_invention"
  s.summary = "This is just an experiment with releasing a gem + node package together"
  s.description = "This is just an experiment with releasing a gem + node package together"

  s.metadata = {
    "bug_tracker_uri" => "http://github.com/andrewmcodes/refactored_invention/issues",
    "changelog_uri" => "https://github.com/andrewmcodes/refactored_invention/blob/master/CHANGELOG.md",
    "documentation_uri" => "http://github.com/andrewmcodes/refactored_invention",
    "homepage_uri" => "http://github.com/andrewmcodes/refactored_invention",
    "source_code_uri" => "http://github.com/andrewmcodes/refactored_invention"
  }

  s.license = "MIT"

  s.files = Dir.glob("lib/**/*") + Dir.glob("bin/**/*") + %w[README.md LICENSE.md CHANGELOG.md]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.5"

  s.add_development_dependency "bundler", ">= 1.15"
  s.add_development_dependency "rake", ">= 13.0"
  s.add_development_dependency "rspec", "~> 3.8"
end
