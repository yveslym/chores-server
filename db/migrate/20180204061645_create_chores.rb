class CreateChores < ActiveRecord::Migration[5.1]
  def change
    create_table :chores do |t|
      t.string :name
      t.string :due_date
      t.string :penalty
      t.string :reward
      t.boolean :assigned
      t.boolean :completed
      t.references :user, index: :true, foreign_key: true
      t.timestamps
    end
  end
end
