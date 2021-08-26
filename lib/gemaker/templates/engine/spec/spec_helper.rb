# frozen_string_literal: true

require "active_support"
require "shoulda/matchers"
require "timecop"
require "../../../../architecture/papertrail_config/spec/support/shared_examples/versioned_model.rb"

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].sort.each do |f|
  require f
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include_context 'versioned model', type: :model
end
