class AddChoreColumnBelongsToGroup < ActiveRecord::Migration[5.1]
  def change
      add_reference :chores, :group, foreign_key: {to_table: :groups}
  end
end
