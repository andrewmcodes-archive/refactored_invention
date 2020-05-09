[![Gem Version](https://badge.fury.io/rb/refactored_invention.svg)](https://rubygems.org/gems/refactored_invention) [![Build](https://github.com/andrewmcodes/refactored_invention/workflows/Build/badge.svg)](https://github.com/andrewmcodes/refactored_invention/actions)
[![JRuby Build](https://github.com/andrewmcodes/refactored_invention/workflows/JRuby%20Build/badge.svg)](https://github.com/andrewmcodes/refactored_invention/actions)

# Refactored Invention

- Utilizes yarn workspaces
  - This means you do not have to `cd` into folders for development
  - All development related packages are stored in the root of the project in package.json
  - Example usage:
    - From root `yarn prettier-standard:format` will correctly format files
    - To use scripts specific to the JS workspace `yarn workspaces run ...` ex: `yarn workspaces run build` will output the rollup generated dist file


## Installation

Adding to a gem:

```ruby
# my-cool-gem.gemspec
Gem::Specification.new do |spec|
  # ...
  spec.add_dependency "refactored_invention"
  # ...
end
```

Or adding to your project:

```ruby
# Gemfile
gem "refactored_invention"
```

### Supported Ruby versions

- Ruby (MRI) >= 2.5.0
- JRuby >= 9.2.9

## Usage

TBD

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/andrewmcodes/refactored_invention](https://github.com/andrewmcodes/refactored_invention).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
