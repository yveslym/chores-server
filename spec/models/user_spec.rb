require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "is valid with valid attributes" do
      user = User.new(
        email: "Sunny@test.com",
        password: "test123",
        password_confirmation: "test123",
      )
      expect(user).to be_valid
    end
    it "is invalid without email" do
      user = User.new(
        email: nil,
        password: "test123",
        password_confirmation: "test123"
      )
      expect(user).to be_invalid
    end
    it "is invalid without password" do
      user = User.new(
        email: "Sunny@test.com",
        password: nil,
        password_confirmation: "test123"
      )
      expect(user).to be_invalid
    end
    it "is invalid without password_confirmation" do
      user = User.new(
        email: "Sunny@test.com",
        password: "test123",
        password_confirmation: nil
      )
      expect(user).to be_invalid
    end
  end

  describe "Associations" do
    it "should have and belong to many groups" do
      assoc = User.reflect_on_association(:group)
      expect(assoc.macro).to eq :has_and_belongs_to_many
    end
    it "should have many chores through groups" do
      assoc = User.reflect_on_association(:chores)
      expect(assoc.macro).to eq :has_many_through_groups
  end
end
