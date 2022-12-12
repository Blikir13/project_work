class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.string :room_number
      t.string :password_digest
      t.string :count_of_users

      t.timestamps
    end
  end
end
