source 'https://rubygems.org'

# Specify your gem's dependencies in ansible_tower_client.gemspec
gemspec

# Pull in a development Gemfile if one exists
eval_gemfile('Gemfile.dev.rb') if File.exists?('Gemfile.dev.rb')

# HACK: Rails 5 dropped support for Ruby < 2.2.2
active_support_version = "< 5" if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.2.2")
gem "activesupport", active_support_version
