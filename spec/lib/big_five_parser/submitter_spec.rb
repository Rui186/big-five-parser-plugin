require 'spec_helper'

RSpec.describe BigFiveParser::Submitter do
  describe '#self.submit_to_recruitbot(params)' do
    it 'should send post request' do
      url = 'https://recruitbot.trikeapps.com/api/v1/roles/bellroy-tech-team-recruit/big_five_profile_submissions'
      params = '{"name":"name", "email":"email"}'
      response = double('Faraday')
      expect(response).to receive(:status).and_return 201
      expect(response).to receive(:body).and_return 'token'
      expect(Faraday).to receive(:post).with(url, params, "Content-Type" => "application/json").and_return response
      expect(BigFiveParser::Submitter.submit_to_recruitbot(params)).to eq ({ status: 201, body: 'token' })
    end
  end
end
