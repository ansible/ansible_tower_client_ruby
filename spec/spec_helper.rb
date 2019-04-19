gem_root = Gem::Specification.find_by_name("ansible_tower_client").gem_dir
Dir[File.join(gem_root, "spec/support/**/*.rb")].each { |f| require f }

require 'factory_bot'
FactoryBot.find_definitions

RSpec.configure do |config|
  config.order = :random
  config.include FactoryBot::Syntax::Methods
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ansible_tower_client'
