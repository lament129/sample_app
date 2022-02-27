class RemoveDetailsFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :laser_request_date, :date
    remove_column :items, :laser_preferred_date, :date
    remove_column :items, :laser_arrival_date, :date
  end
end
