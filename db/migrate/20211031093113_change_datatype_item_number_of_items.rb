class ChangeDatatypeItemNumberOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :item_number, :integer
  end
end
