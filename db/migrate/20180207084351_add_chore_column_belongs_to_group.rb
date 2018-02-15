class AddChoreColumnBelongsToGroup < ActiveRecord::Migration[5.1]
  def change
      add_reference :chores, :group, index: :true, foreign_key: true
  end
end
