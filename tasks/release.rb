library = "refactored_invention"
root    = File.expand_path("..", __dir__)
version = File.read("#{root}/VERSION").strip
tag     = "v#{version}"

# Create new folder called pkg
binding.pry
Dir.mkdir "pkg"

# This "npm-ifies" the current version number
# With npm, versions such as "5.0.0.rc1" or "5.0.0.beta1.1" are not compliant with its
# versioning system, so they must be transformed to "5.0.0-rc1" and "5.0.0-beta1-1" respectively.

# "5.0.1"     --> "5.0.1"
# "5.0.1.1"   --> "5.0.1-1" *
# "5.0.0.rc1" --> "5.0.0-rc1"
#
# * This makes it a prerelease. That's bad, but we haven't come up with
# a better solution at the moment.
npm_version = version.gsub(/\./).with_index { |s, i| i >= 2 ? "-" : s }
gem     = "pkg/refactored_invention-#{version}.gem"
gemspec = "refactored_invention.gemspec"

namespace :all do
  task build: [:clean, gem]

  task :clean do
    rm_f gem
  end

  task :update_versions do
    glob = root.dup
    glob << "/lib/refactored_invention/gem_version.rb"

    file = Dir[glob].first
    ruby = File.read(file)

    major, minor, tiny, pre = version.split(".", 4)
    pre = pre ? pre.inspect : "nil"

    ruby.gsub!(/^(\s*)MAJOR(\s*)= .*?$/, "\\1MAJOR = #{major}")
    raise "Could not insert MAJOR in #{file}" unless $1

    ruby.gsub!(/^(\s*)MINOR(\s*)= .*?$/, "\\1MINOR = #{minor}")
    raise "Could not insert MINOR in #{file}" unless $1

    ruby.gsub!(/^(\s*)TINY(\s*)= .*?$/, "\\1TINY  = #{tiny}")
    raise "Could not insert TINY in #{file}" unless $1

    ruby.gsub!(/^(\s*)PRE(\s*)= .*?$/, "\\1PRE   = #{pre}")
    raise "Could not insert PRE in #{file}" unless $1

    File.open(file, "w") { |f| f.write ruby }

    require "json"

    if JSON.parse(File.read("#{root}/javascript/package.json"))["version"] != npm_version
      Dir.chdir("javascript") do
        if sh "which npm"
          sh "npm version #{npm_version} --no-git-tag-version"
        else
          raise "You must have npm installed to release RefactoredInvention."
        end
      end
    end
  end

  task gem => %w(update_versions pkg) do
    cmd = ""
    cmd += "gem build #{gemspec} && mv refactored_invention-#{version}.gem #{root}/pkg/"
    sh cmd
  end

  # Push gem to Ruby Gems and node package to NPM
  task :push do
    sh "gem push #{gem}"

    # if File.exist?("refactored_invention/package.json")
    Dir.chdir("refactored_invention") do
      npm_tag = /[a-z]/.match?(version) ? "pre" : "latest"
      sh "npm publish --tag #{npm_tag}"
    end
    # end
  end

  # Verify we have no dirty changes in the tree and that the tag does not already exist
  task :ensure_clean_state do
    # Checks to see if the tree is dirty and aborts if it is
    unless `git status -s | grep -v 'VERSION\\|CHANGELOG\\|Gemfile.lock\\|package.json\\|version.rb\\|tasks/release.rb'`.strip.empty?
      abort "[ABORTING] `git status` reports a dirty tree. Make sure all changes are committed"
    end

    # Checks to see if the tag has already been created and SKIP_TAG is not used and aborts if it is
    unless ENV["SKIP_TAG"] || `git tag | grep '^#{tag}$'`.strip.empty?
      abort "[ABORTING] `git tag` shows that #{tag} already exists. Has this version already\n"\
            "           been released? Git tagging can be skipped by setting SKIP_TAG=1"
    end
  end

  # Verifies if dependencies are satisfied by installed gems
  task :bundle do
    sh "bundle check"
  end

  # Commit the shit
  task :commit do
    unless `git status -s`.strip.empty?
      File.open("pkg/commit_message.txt", "w") do |f|
        f.puts "# Preparing for #{version} release\n"
        f.puts
        f.puts "# UNCOMMENT THE LINE ABOVE TO APPROVE THIS COMMIT"
      end

      sh "git add . && git commit --verbose --template=pkg/commit_message.txt"
      rm_f "pkg/commit_message.txt"
    end
  end

  # Create and push new tag
  task :tag do
    sh "git tag -s -m '#{tag} release' #{tag}"
    sh "git push --tags"
  end

  task prep_release: %w(ensure_clean_state build bundle commit)

  task release: %w(prep_release tag push)
end
