class AddOwnerColumnToGroup < ActiveRecord::Migration[5.1]
  def change
    add_reference :groups, :owner,index: :true ,foreign_key: {to_table: :users}
  end
end
