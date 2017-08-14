RSpec.configure do |config|
 
  # testに必要なものをrequireする。
  require 'yaml'
  require 'padrino'
  require 'simplecov'
  require 'webrick'

  SimpleCov.start do
    add_filter '/vender'
    add_filter '/spec'
    add_filter '/lib/connection_pool_management_middleware.rb'
    add_filter '/lib/sass_initializer.rb'
  end
  
  config.expose_dsl_globally = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

#  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  # ファイルをinclude
  Dir[File.join(File.dirname(__FILE__), "../lib/**/*.rb")].each { |f| require f }
end
