# AnsibleTowerClient

[![Gem Version](https://badge.fury.io/rb/ansible_tower_client.svg)](http://badge.fury.io/rb/ansible_tower_client)
[![Build Status](https://travis-ci.org/ansible/ansible_tower_client_ruby.svg)](https://travis-ci.org/ansible/ansible_tower_client_ruby)
[![Code Climate](https://codeclimate.com/github/ansible/ansible_tower_client_ruby/badges/gpa.svg)](https://codeclimate.com/github/ansible/ansible_tower_client_ruby)
[![Dependency Status](https://gemnasium.com/ansible/ansible_tower_client_ruby.svg)](https://gemnasium.com/ansible/ansible_tower_client_ruby)
[![Coverage Status](http://img.shields.io/coveralls/ansible/ansible_tower_client_ruby.svg)](https://coveralls.io/r/ansible/ansible_tower_client_ruby)
[![Security](https://hakiri.io/github/ansible/ansible_tower_client_ruby/master.svg)](https://hakiri.io/github/ansible/ansible_tower_client_ruby/master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ansible_tower_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ansible_tower_client

## Usage

```ruby
require 'ansible_tower_client'

# Optionally set a global logger
AnsibleTowerClient.logger = Logger.new(STDOUT)

# Create a connection
conn = AnsibleTowerClient::Connection.new(
  :base_url   => "https://awx.example.com/",
  :username   => "admin",
  :password   => "pa$$w0rd!",
  :verify_ssl => OpenSSL::SSL::VERIFY_PEER # Optional: an OpenSSL::SSL::VERIFY_* constant
)

# Query the config
conn.api.config
# => {"eula"=>"text"
#     "version"=>"3.2.2",
#     "project_base_dir"=>"/var/lib/awx/projects",
#     "ansible_version"=>"2.4.1.0",
#     ...}

# Query a collection
conn.api.job_templates.all
# => [<AnsibleTowerClient::JobTemplate id=580, type="job_template", url="/api/v1/job_templates/580/", name="ems_refresh_spec-job_template", description="EmsRefreshSpec JobTemplate", ...>
#     <AnsibleTowerClient::JobTemplate id=585, type="job_template", url="/api/v1/job_templates/585/", name="ems_refresh_spec-job_template2", description="EmsRefreshSpec JobTemplate", ...>]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Ansible/ansible_tower_client_ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
