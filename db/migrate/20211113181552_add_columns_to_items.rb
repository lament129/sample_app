class AddColumnsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :las_req, :boolean
    add_column :items, :las_rec, :boolean
  end
end
