class AddAttachmentImageFileToGroups < ActiveRecord::Migration[5.1]
  def self.up
    change_table :groups do |t|
      t.attachment :image_file
    end
  end

  def self.down
    remove_attachment :groups, :image_file
  end
end
