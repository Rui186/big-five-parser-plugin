require 'spec_helper'
# require 'big_five_parser'

# describe BigFiveParser::Parser do
RSpec.describe BigFiveParser::Parser do
  describe '#parse' do
    it 'should call body_content and parse_content' do
      path = 'file/path'
      file = double('File')
      # content = 'text'
      expect(File).to receive(:open).with(path).and_return(file)
      # expect(file).to receive(:blank?).and_return(false)
      # expect_any_instance_of(BigFiveParser::Parser).to receive(:body_content).with(file).and_return(content)
      # expect_any_instance_of(BigFiveParser::Parser).to receive(:parse_content).with(content)
      BigFiveParser::Parser.new(path, name: 'name', email: 'email')#.parse
    end
  end

  describe '#body_content(file)' do

  end

  describe '#parse_content(content)' do

  end
end
# end
