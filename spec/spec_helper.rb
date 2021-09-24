require "bundler/setup"
require "ding_talk"
require 'mock_redis'
require 'yaml'
require 'simplecov'

seeds_path = File.join(File.dirname(__FILE__), 'fixtures/config.yml')
if File.exist? seeds_path
  YAML.load_file(seeds_path).each do |k, v|
    ENV[k] = "#{v}"
  end
end

SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DingTalk.configure do |config|
      config.redis = MockRedis.new
    end
  end

  config.before(:each) do
    # allow_any_instance_of(DingTalk::Request).to receive(:request) {DingTalk::MockApi} if ENV['DEBUG'] == 'YES'
  end

end
