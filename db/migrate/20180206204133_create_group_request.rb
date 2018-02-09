class CreateGroupRequest < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
        t.references :reciever, index: :true
        t.references :group, index: :true
        t.references :sender, index: :true
        t.references :chore, index: :true
        t.integer :request_type, null:false
        t.boolean :response
    end
  end
end
