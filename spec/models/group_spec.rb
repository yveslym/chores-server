require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "Validations" do
    it "is valid with valid attributes" do
      group = Group.new(name: "SantaBarbara")
      expect(group).to be_valid
    end

    it "is invalid without a name" do
      bad_group = Group.new(name: nil)
      expect(bad_group)to_not be_valid
    end
  end

  describe "Associations" do
    it "should have many chores" do
      assoc = Group.reflect_on_association(:chores)
      expect(assoc.macro).to eq :has_many
    end
    it "should have and belong to many users" do
      assoc = Group.reflect_on_association(:users)
      expect(assoc.macro).to eq :has_and_belongs_to_many
  end
end
