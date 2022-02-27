class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :ex_reply, :date
  end
end
