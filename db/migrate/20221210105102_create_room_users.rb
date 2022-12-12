class CreateRoomUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :room_users do |t|
      t.string :room_id
      t.string :user_id
      t.string :role
      t.string :wish
      t.string :real_username

      t.timestamps
    end
  end
end
