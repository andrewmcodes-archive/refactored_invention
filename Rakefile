# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "pry-byebug"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: [:rubocop, :spec]

$:.unshift __dir__
require "tasks/release"

desc "Build gem files for all projects"
task build: "all:build"

desc "Prepare the release"
task prep_release: "all:prep_release"

desc "Release all gems to rubygems and create a tag"
task release: "all:release"
