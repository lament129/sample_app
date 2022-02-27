class AddColumnsToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :out, :boolean
    add_column :items, :note, :string
  end
end
