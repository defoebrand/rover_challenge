class CreateRoverCoordinates < ActiveRecord::Migration[6.1]
  def change
    create_table :rover_coordinates do |t|
      t.jsonb :initial_orientation, array: true, default: []
      t.jsonb :final_orientation, array: true, default: []
      t.string :instructions

      t.timestamps
    end
  end
end
