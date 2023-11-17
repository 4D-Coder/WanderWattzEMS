# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeoapifyService, type: :service do
  context '#ip_geolocation' do
    def host_ip
      conn = Faraday.new(url: 'https://api.ipify.org')
      response = conn.get { |req| req.params['format'] = 'json' }
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      parsed_response[:ip]
    end

    let(:ip_address) { host_ip }

    it 'can convert location information into coordinates' do
      VCR.use_cassette('IP Geolocation', record: :once) do
        response = GeoapifyService.ip_geolocation('https://api.geoapify.com', ip_address)

        expect(response).to have_key :location

        location = response[:location]
        expect(location).to be_a Hash

        expect(location[:latitude]).to be_a Float
        expect(location[:longitude]).to be_a Float
      end
    end
  end
end
