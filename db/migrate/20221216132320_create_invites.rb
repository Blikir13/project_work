class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.string :room_id
      t.string :user_id
      t.string :inviter_id
      t.timestamps
    end
  end
end
