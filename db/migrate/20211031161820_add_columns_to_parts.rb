class AddColumnsToParts < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :half, :integer
    add_column :parts, :thr_eth, :integer
    add_column :parts, :qtr, :integer
    add_column :parts, :eth, :integer
  end
end
