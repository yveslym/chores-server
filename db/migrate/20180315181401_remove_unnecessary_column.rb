class RemoveUnnecessaryColumn < ActiveRecord::Migration[5.1]
  def change
      remove_column :users, :voice_file_file_name
      remove_column :users, :voice_file_content_type
      remove_column :users, :voice_file_updated_at
  end
end
