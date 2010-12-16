require 'vcr'

VCR.config do |config|
  config.cassette_library_dir = File.expand_path('../../fixtures/net', __FILE__)
  config.default_cassette_options = { :record => :none }
  config.stub_with :webmock
end

module VCRHelpers
  def use_cached_requests(scope, options={}, &block)
    if mode = options.delete(:record)
      mode_alises = { :new => :new_episodes }
      options[:record] = mode_alises[mode] || mode
    end

    VCR.use_cassette(scope, options, &block)
  end
end

RSpec.configure do |config|
  config.include(VCRHelpers)
end
