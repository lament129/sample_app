class AddValveToParts < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :valve, :boolean
  end
end
