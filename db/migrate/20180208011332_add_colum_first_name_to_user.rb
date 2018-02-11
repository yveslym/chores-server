class AddColumFirstNameToUser < ActiveRecord::Migration[5.1]
  def change
      # remove_column :users, :first_name
      add_column :users, :first_name, :string, limit: 30
  end
end
