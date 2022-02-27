class CreateParts < ActiveRecord::Migration[5.2]
  def change
    create_table :parts do |t|
      t.string :part_number
      t.integer :points
      t.boolean :laser
      t.boolean :tig
      t.boolean :add
      t.boolean :long
      t.boolean :ebw
      t.boolean :bend
      t.boolean :out

      t.timestamps
    end
  end
end
