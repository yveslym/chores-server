class AddAttachmentVoiceFileToUsers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :users do |t|
      t.attachment :voice_file
    end
  end

  def self.down
    remove_attachment :users, :voice_file
  end
end
