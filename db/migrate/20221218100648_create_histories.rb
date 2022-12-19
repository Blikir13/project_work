class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.string :giver_id
      t.string :receiver_id
      t.string :receiver_wish
      t.string :room_name
      t.string :giver_name
      t.string :receiver_name
      t.timestamps
    end
  end
end
