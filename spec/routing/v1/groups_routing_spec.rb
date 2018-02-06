require "rails_helper"

RSpec.describe V1::GroupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/v1/groups").to route_to("v1/groups#index")
    end


    it "routes to #show" do
      expect(:get => "/v1/groups/1").to route_to("v1/groups#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/v1/groups").to route_to("v1/groups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/groups/1").to route_to("v1/groups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/groups/1").to route_to("v1/groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/groups/1").to route_to("v1/groups#destroy", :id => "1")
    end

  end
end
