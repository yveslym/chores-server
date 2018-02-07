class CreateGroupRequest < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
        t.references :reciever, index: :true
        t.references :group, index: :true
        t.references :sender, index: :true
        t.references :chore, index: :true
        t.string :request_type
        t.boolean :response
    end
  end
end
