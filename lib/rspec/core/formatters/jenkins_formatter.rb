require 'time'

# Dumps rspec results as a JUnit XML file.
# Based on XML schema: http://windyroad.org/dl/Open%20Source/JUnit.xsd
class RSpec::Core::Formatters::JenkinsFormatter < RSpec::Core::Formatters::BaseFormatter
  def xml
    @xml ||= Builder::XmlMarkup.new :target => output, :indent => 2 
  end

  def start(example_count)
    @start = Time.now
    super
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    super

    xml.instruct!
    xml.testsuite :tests => example_count, :failures => failure_count, :errors => 0, :time => '%.6f' % duration, :timestamp => @start.iso8601 do
      xml.properties
      examples.each do |example|
        send :"dump_summary_example_#{example.execution_result[:status]}", example
      end
    end
  end

  def xml_example(example, &block)
    attributes = {}
    attributes[:classname] = example_classname(example)
    attributes[:name] = example.full_description
    attributes[:time] = '%.6f' % example.execution_result[:run_time]

    # add attributes for metadata
    example.metadata.each do |key, value|
      next unless RSpec.configuration.output_metadata.include?(key.to_s)

      if value.is_a?(Array)
        attributes[key] = value.join(',')
      else
        attributes[key] = value.to_s
      end
    end if RSpec.configuration.output_metadata?

    xml.testcase attributes, &block
  end

  def dump_summary_example_passed(example)
    xml_example example
  end

  def dump_summary_example_pending(example)
    xml_example example do
      xml.skipped
    end
  end

  def dump_summary_example_failed(example)
    exception = example.execution_result[:exception]
    backtrace = format_backtrace exception.backtrace, example

    xml_example example do
      xml.failure :message => exception.to_s, :type => exception.class.name do
        xml.cdata! "#{exception.message}\n#{backtrace.join "\n"}"
      end
    end
  end

  def example_classname(example)
    example.file_path.sub(%r{\.[^/]*\Z}, '').gsub('/', '.').gsub(%r{\A\.+|\.+\Z}, '')
  end
end
