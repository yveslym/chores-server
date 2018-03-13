class AddGroupNameToChores < ActiveRecord::Migration[5.1]
  def change
    add_column :chores, :groupname, :string
  end
end
