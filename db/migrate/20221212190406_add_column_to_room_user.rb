class AddColumnToRoomUser < ActiveRecord::Migration[7.0]
  def change
    add_column :room_users, :gift_user_id, :string
  end
end
