require 'rails_helper'

RSpec.describe Chore, type: :model do
  describe "Validations" do
    it "is valid with valid attributes" do
      chore = Chore.new(name: "Dishes", due_date: "Tuesday 27", penalty: "5 dollars", reward: "1 dollar", assigned: false, completed: false)
      expect(chore).to be_valid
    end
    it "is invalid without a name" do
      bad_chore = Chore.new(name: nil, due_date: "Tuesday 27", penalty: "5 dollars", reward: "1 dollar", assigned: false, completed: false)
      expect(bad_chore).to_not be_valid
    end
    it "is invalid without a due_date" do
      bad_chore = Chore.new(name: "Dishes", due_date: nil, penalty: "5 dollars", reward: "1 dollar", assigned: false, completed: false)
      expect(bad_chore).to_not be_valid
    end
    it "is invalid without an assigned" do
      bad_chore = Chore.new(name: "Dishes", due_date: "Tuesday 27", penalty: "5 dollars", reward: "1 dollar", assigned: nil, completed: false)
      expect(bad_chore).to_not be_valid
    end
    it "is invalid without a completed" do
      bad_chore = Chore.new(name: "Dishes", due_date: "Tuesday 27", penalty: "5 dollars", reward: "1 dollar", assigned: false, completed: nil)
      expect(bad_chore).to_not be_valid
    end
  end

  describe "Associations" do
    it "should belong to a user"

end
