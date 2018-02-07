class AddIndexToRequest < ActiveRecord::Migration[5.1]
  def change
      add_reference :requests, index: :true
  end
end
