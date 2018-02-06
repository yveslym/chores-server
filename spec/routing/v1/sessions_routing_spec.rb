require "rails_helper"

# RSpec.configure do |config|
#   # https://github.com/rails/jbuilder/issues/32
#   config.render_views = true
# end

RSpec.describe V1::SessionsController, type: :routing do




  describe "routing" do

    it "routes to #index" do
      expect(:get => "/v1/sessions").to route_to("v1/sessions#index")
    end


    it "routes to #show" do
      expect(:get => "/v1/sessions/1").to route_to("v1/sessions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/v1/sessions").to route_to("v1/sessions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/sessions/1").to route_to("v1/sessions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/sessions/1").to route_to("v1/sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/sessions/1").to route_to("v1/sessions#destroy", :id => "1")
    end

  end
end
