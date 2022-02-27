class AddPointsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :points, :integer
  end
end
