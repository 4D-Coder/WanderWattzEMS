# frozen_string_literal: true

class ApplicationService
  class << self
    def parse_json(response_body)
      JSON.parse(response_body, symbolize_names: true)
    end

    def conn(base_url)
      Faraday.new(
        url: base_url,
        headers: { 'Content-Type' => 'application/json' }
      )
    end
  end
end
