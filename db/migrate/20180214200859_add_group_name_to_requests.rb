class AddGroupNameToRequests < ActiveRecord::Migration[5.1]
  def change
      add_column :requests, :group_name, :string , limit: 40
  end
end
