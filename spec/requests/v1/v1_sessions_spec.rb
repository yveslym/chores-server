require 'rails_helper'

RSpec.describe "V1::Sessions", type: :request do
  describe "GET /v1_sessions" do
    it "works! (now write some real specs)" do
      get v1_sessions_path
      expect(response).to have_http_status(200)
    end
  end
end
