class AddGroupAndChoreReferenceToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :group, index: :true, foreign_key: :true
    add_reference :users, :chore, index: :true, foreign_key: :true
    #add_reference :chores, :user, index: :true, null: :true
    add_reference  :chores, :group, index: :true, null: :false
    add_reference :groups, :user, index: :true, foreign_key: :true
    add_reference :groups, :chore, index: :true, foreign_key: :true
  end
end
