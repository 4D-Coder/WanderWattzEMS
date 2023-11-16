require 'rails_helper'
# continued development/testing upon frontend creation [https://chat.openai.com/share/652b188a-1aae-49d5-820d-36e7258d1bd4]
Rspec.describe 'Google OAuth2 Callback', type: :request do
  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end
end
