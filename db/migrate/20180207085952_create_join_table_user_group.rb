class CreateJoinTableUserGroup < ActiveRecord::Migration[5.1]
    def change
        create_join_table :groups, :users do |t|
        t.references :user, index: :true
        t.references :group, index: :true
        t.timestamps
      end
    end
end
