require_relative 'support/rails'
Dir[File.join(File.dirname(__FILE__), 'support/*.rb')].each {|f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.infer_spec_type_from_file_location!

  config.include Spree::TestingSupport::ControllerRequests
end
