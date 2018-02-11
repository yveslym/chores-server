class AddChoreColumnBelongsToGroup < ActiveRecord::Migration[5.1]
  def change
      add_reference :chores, foreign_key: {to_table: :groups}
  end
end
