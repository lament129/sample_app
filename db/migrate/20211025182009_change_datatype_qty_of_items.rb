class ChangeDatatypeQtyOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :qty, :integer
  end
end
