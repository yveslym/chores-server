class AddPendingColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :chores, :pending, :boolean
  end
end
