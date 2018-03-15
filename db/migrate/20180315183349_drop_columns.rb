class DropColumns < ActiveRecord::Migration[5.1]
  def change
      remove_column :users, :voice_file_file_size
  end
end
