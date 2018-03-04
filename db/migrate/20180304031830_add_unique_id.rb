class AddUniqueId < ActiveRecord::Migration[5.1]
  def change
      add_column :requests, :unique_id, :string
  end
end
