require 'builder'
require 'rspec'

require 'rspec/core/formatters/base_formatter'
require 'rspec/core/formatters/jenkins_formatter'

RSpec.configure do |config|
  config.add_setting :output_metadata
end

# Make it easier to use
RspecJenkinsFormatter = RSpecJenkinsFormatter = RSpec::Core::Formatters::JenkinsFormatter
