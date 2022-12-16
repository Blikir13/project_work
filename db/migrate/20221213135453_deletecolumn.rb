class Deletecolumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :room_number, :string
  end
end
