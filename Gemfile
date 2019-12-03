source 'https://rubygems.org'

plugin "bundler-inject", "~> 1.1"
require File.join(Bundler::Plugin.index.load_paths("bundler-inject")[0], "bundler-inject") rescue nil

# Specify your gem's dependencies in ansible_tower_client.gemspec
gemspec

# HACK: Rails 5 dropped support for Ruby < 2.2.2
active_support_version = "< 5" if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.2.2")
gem "activesupport", active_support_version
