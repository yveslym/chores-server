class CreateGroupRequest < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
        # t.references :reciever, index: :true, foreign_key: true
        t.references :group, index: :true, foreign_key: true
        # t.references :sender, index: :true, foreign_key: true
        t.references :chore, index: :true, foreign_key: true
        t.integer :request_type, null:false
        t.boolean :response
    end
  end
end
