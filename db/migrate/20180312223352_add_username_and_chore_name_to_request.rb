class AddUsernameAndChoreNameToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :username, :string
    add_column :requests, :chore_name, :string
  end
end
