# Deliberately named _specs.rb to avoid being loaded except when specified

RSpec.configure do |config|
  config.output_metadata = ['data', 'other']
end

describe "pending spec with no implementation" do
  it "is pending"
end

RSpec.describe "pending command with block format" do
  context "with content that would fail" do
    it "is pending" do
      pending
      expect(1).to eq(2)
    end
  end

  context "with content that would pass" do
    it "fails" do
      pending
      expect(1).to eq(1)
    end
  end
end

RSpec.describe "passing spec" do
  it "passes" do
    expect(1).to eq(1)
  end
end

RSpec.describe "failing spec" do
  it "fails" do
    expect(1).to eq(2)
  end
end

describe 'specs with metadata' do
  it 'has a single string', :data => 'test' do
    expect(1).to eq(1)
  end

  it 'has an array of strings', :data => ['one', 'two', 'three'] do
    expect(1).to eq(1)
  end

  it 'has a number', :data => 1 do
    expect(1).to eq(1)
  end

  it 'has an array of numbers', :data => [1,2,3], :not_found => [1,2,3]  do
    expect(1).to eq(1)
  end

  it 'has multiple key/values', :data => 'test1', :other => 'test2' do
    expect(1).to eq(1)
  end
end

describe 'inherited metadata', :data => 'test-inheritance' do
  it 'inherits metadata from parent' do
    expect(1).to eq(1)
  end

  it 'overrides metadata from parent', :data => 'overridden' do
    expect(1).to eq(1)
  end
end
RSpec.describe "a failing spec with odd backtraces" do
  #it "fails with a backtrace that has no file" do
  #  require 'erb'
  #
  #  ERB.new("<%= raise 'foo' %>").result
  #end

  #it "fails with a backtrace containing an erb file" do
  #  e = Exception.new
  #
  #  def e.backtrace
  #    ["/foo.html.erb:1:in `<main>': foo (RuntimeError)",
  #     "   from /lib/ruby/1.9.1/erb.rb:753:in `eval'"]
  #  end
  #
  #  def e.message
  #    # Redefining message steps around this behaviour
  #    # on JRuby: http://jira.codehaus.org/browse/JRUBY-5637
  #    self.class.name
  #  end
  #
  #  raise e
  #end
end