class RemovePointsFromParts < ActiveRecord::Migration[5.2]
  def change
    remove_column :parts, :points, :integer
  end
end
