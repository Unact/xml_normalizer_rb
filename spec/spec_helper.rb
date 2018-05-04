require 'rubygems'
ENV["RAILS_ENV"] ||= 'test'

Bundler.require(:default, :test)
require File.expand_path("../../lib/xml-normalizer", __FILE__)

Dir[File.join(File.expand_path("../", __FILE__), "support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # config.run_all_when_everything_filtered = false
  # config.filter_run :focus
  config.mock_with :rspec
  # config.filter_run_excluding :broken => true

  config.order = 'random'

  config.filter_run_excluding skip: true


  config.before(:suite) do
  end

  config.before(:each) do
  end

  config.after(:each) do
  end
end
