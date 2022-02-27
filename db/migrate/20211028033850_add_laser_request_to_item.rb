class AddLaserRequestToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :laser_request_date, :date
    add_column :items, :laser_preferred_date, :date
    add_column :items, :laser_arrival_date, :date
  end
end
