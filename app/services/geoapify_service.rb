# frozen_string_literal: true
class GeoapifyService < ApplicationService
  class << self
    def ip_geolocation(url, ip_address)
      response = conn(url).get do |req|
        req.path = '/v1/ipinfo'
        req.params['ip'] = ip_address
        req.params['apiKey'] = ENV['geoapify_api_key']
      end

      parse_json(response.body)
    end
  end
end
