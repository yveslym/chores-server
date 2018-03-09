class AddAttachmentImageFileToUsers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :users do |t|
      t.attachment :image_file
    end
  end

  def self.down
    remove_attachment :users, :image_file
  end
end
