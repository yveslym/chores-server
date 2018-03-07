class AddRequestUuid < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :uuid, :string
  end
end
