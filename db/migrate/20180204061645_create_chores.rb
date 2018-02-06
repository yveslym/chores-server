class CreateChores < ActiveRecord::Migration[5.1]
  def change
    create_table :chores do |t|
      t.string :name
      t.string :due_date
      t.string :penalty
      t.string :reward
      t.boolean :assigned
      t.boolean :completed
      t.belongs_to :user, index: :true, optional: :true
      t.timestamps
    end
  end
end
