# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ansible_tower_client/version'

Gem::Specification.new do |spec|
  spec.name          = "ansible_tower_client"
  spec.version       = AnsibleTowerClient::VERSION
  spec.authors       = ["Brandon Dunne", "Drew Bomhof"]
  spec.email         = ["bdunne@redhat.com", "dbomhof@redhat.com"]

  spec.summary       = %q{Ansible Tower REST API wrapper gem}
  spec.description   = %q{Ansible Tower REST API wrapper gem}
  spec.homepage      = "https://github.com/Ansible/ansible_tower_client_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "faraday",              "~> 0.13"
  spec.add_runtime_dependency "faraday_middleware"
  spec.add_runtime_dependency "more_core_extensions", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
