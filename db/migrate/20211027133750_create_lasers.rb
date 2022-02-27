class CreateLasers < ActiveRecord::Migration[5.2]
  def change
    create_table :lasers do |t|
      t.string :part_number

      t.timestamps
    end
  end
end
