$:.unshift(File.expand_path('../../lib', __FILE__))

require 'rspec'
require 'sports_direct'

# Requires supporting files with custom matchers and macros, etc.,
# in ./support/ and its subdirectories.
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |file|
  require(file)
end

RSpec.configure do |config|
  config.mock_with :rspec
end
