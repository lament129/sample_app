class AddWorkNumberToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :work_number, :string
  end
end
