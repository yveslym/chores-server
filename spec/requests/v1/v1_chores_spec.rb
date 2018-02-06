require 'rails_helper'

RSpec.describe "V1::Chores", type: :request do
  describe "GET /v1_chores" do
    it "works! (now write some real specs)" do
      get v1_chores_path
      expect(response).to have_http_status(200)
    end
  end
end
