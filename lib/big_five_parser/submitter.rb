module BigFiveParser
  class Submitter
    require 'faraday'

    def self.submit(params)
      url = 'https://recruitbot.trikeapps.com/api/v1/roles/bellroy-tech-team-recruit/big_five_profile_submissions'
      response = Faraday.post(url, params, "Content-Type" => "application/json")
      { status: response.status, body: response.body }
    end
  end
end