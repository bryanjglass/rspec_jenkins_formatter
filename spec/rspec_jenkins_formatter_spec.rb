require 'nokogiri'
require 'rspec'
require 'rspec/matchers'
require 'rspec_jenkins_formatter'

describe RSpecJenkinsFormatter do
  describe 'without metadata output' do
    let(:generated_xml) do
      `rspec --pattern spec/fixtures/sample_specs.rb --format RspecJenkinsFormatter`
    end

    it 'formats as xml' do
      expect { Nokogiri::XML.parse(generated_xml) }.to_not raise_error
    end
  end

  describe 'with metadata output' do
    let(:generated_xml) do
      Nokogiri::XML.parse(`rspec --pattern spec/fixtures/sample_specs.rb --format RspecJenkinsFormatter`)
    end


    it 'writes strings as attributes' do
      found = generated_xml.xpath('//testcase[@data=$value]', nil, {:value => '1'})
      expect(found.length).to eq(1)
    end

    it 'writes arrays of strings as a single comma separated value' do
      found = generated_xml.xpath('//testcase[@data=$value]', nil, {:value => '1,2,3'})
      expect(found.length).to eq(1)
    end

    it 'only writes attributes specified in output_metadata' do
      found = generated_xml.xpath('//testcase[@not_found]')
      expect(found.length).to eq(0)
    end

    it 'writes inherited metadata' do
      found = generated_xml.xpath('//testcase[@data=$value]', nil, {:value => 'test-inheritance'})
      expect(found.length).to eq(1)
    end

    it 'writes overridden inherited metadata' do
      found = generated_xml.xpath('//testcase[@data=$value]', nil, {:value => 'overridden'})
      expect(found.length).to eq(1)
    end

    it 'write multiple attributes' do
      found = generated_xml.xpath('//testcase[@data=$value1][@other=$value2]', nil, {:value1 => 'test1',
                                                                                    :value2 => 'test2'})
      expect(found.length).to eq(1)
    end
  end
end