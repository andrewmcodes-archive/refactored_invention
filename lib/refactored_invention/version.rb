# frozen_string_literal: true

require_relative "gem_version"
module RefactoredInvention # :nodoc:
  # Returns the version of the currently loaded Refactored Invention as a <tt>Gem::Version</tt>
  def self.version
    gem_version
  end
end
