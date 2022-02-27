class RemoveOutFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :out, :string
  end
end
