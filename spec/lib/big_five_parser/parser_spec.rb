require 'spec_helper'

RSpec.describe BigFiveParser::Parser do
  describe '#parse' do
    before do
      @path = 'file/path'
      @file = double('File')
    end

    it 'should call body_content and parse_content' do
      content = 'text'
      result = { name: 'name', email: 'email' }
      expect(File).to receive(:file?).with(@path).and_return(true)
      expect(File).to receive(:open).with(@path).and_return(@file)
      expect_any_instance_of(BigFiveParser::Parser).to receive(:body_content).with(@file).and_return(content)
      expect_any_instance_of(BigFiveParser::Parser).to receive(:parse_content).with(content).and_return(result)
      expect(@file).to receive(:close)
      expect(BigFiveParser::Parser.new(@path, name: 'name', email: 'email').parse).to eq result
    end

    it 'should return nil if file not exist' do
      expect(File).to receive(:file?).with(@path).and_return(false)
      expect(BigFiveParser::Parser.new(@path, name: 'name', email: 'email').parse).to eq nil
    end
  end

  describe '#body_content(file)' do
    it 'should parse file content by Nokogiri' do
      expect(File).to receive(:file?).with(@path).and_return(true)
      doc = double('Nokogiri::HTML')
      expect(Nokogiri::HTML::Document).to receive(:parse).and_return(doc)
      expect(doc).to receive(:text)
      BigFiveParser::Parser.new(@path).send(:body_content, @file)
    end
  end

  describe '#parse_content(content)' do
    it 'should return formatted result' do
      content = "critics, or soldiers.\n\t\t\t\t\n\t\t\t\t\t\n\t\t\t\t\t\tDomain/Facet...... Score\n\t\t\t\t\t\tAGREEABLENESS...84 \n\t\t\t\t\t\tTrust...........92 \n\t\t\t\t\t\tMorality........72 \n\t\t\t\t\t\tAltruism........57 \n\t\t\t\t\t\tCooperation.....72 \n\t\t\t\t\t\tModesty.........74 \n\t\t\t\t\t\tSympathy........63 \n\t\t\t\t\t\n\t\t\t\t\n\t\t\t\n\t\t\n\t\n\n\n\t  \n\t\t\n\t\t\t\n\t\t\t\tYour high level of"
      expect(File).to receive(:file?).with(@path).and_return(true)
      result = {
                  "AGREEABLENESS":{
                    "Overall Score":"84",
                    "Facets":{
                      "Trust":"92",
                      "Morality":"72",
                      "Altruism":"57",
                      "Cooperation":"72",
                      "Modesty":"74",
                      "Sympathy":"63"
                    }
                  }
                }.to_json
      expect(BigFiveParser::Parser.new(@path).send(:parse_content, content)).to eq result
    end

    it 'should return formatted result' do
      content = "the Extraversion domain.\n\nDomain/Facet...... Score\nNEUROTICISM..........21\nAnxiety..............73\nAnger................4\nDepression...........30\nSelf-Consciousness...58\nImmoderation.........12\nVulnerability........12\nYour score on"
      expect(File).to receive(:file?).with(@path).and_return(true)
      result = {
                  "NEUROTICISM":{
                    "Overall Score":"21",
                    "Facets":{
                      "Anxiety":"73",
                      "Anger":"4",
                      "Depression":"30",
                      "Self-Consciousness":"58",
                      "Immoderation":"12",
                      "Vulnerability":"12"
                    }
                  }
                }.to_json
      expect(BigFiveParser::Parser.new(@path).send(:parse_content, content)).to eq result
    end
  end
end
