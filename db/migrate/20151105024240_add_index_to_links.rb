class AddIndexToLinks < ActiveRecord::Migration
  def change
    add_index :links, :user_id
  end
end
