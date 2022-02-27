class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :order_number
      t.string :item_number
      t.string :part_number
      t.string :qty
      t.date :etd

      t.timestamps
    end
  end
end
