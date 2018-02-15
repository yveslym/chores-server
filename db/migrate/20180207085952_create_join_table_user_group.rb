class CreateJoinTableUserGroup < ActiveRecord::Migration[5.1]
    def change
        create_join_table :groups, :users do |t|
        t.references :user, index: :true, foreign_key: true
        t.references :group, index: :true, foreign_key: true
        t.timestamps
      end
    end
end
