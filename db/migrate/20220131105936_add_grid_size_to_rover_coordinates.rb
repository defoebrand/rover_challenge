class AddGridSizeToRoverCoordinates < ActiveRecord::Migration[6.1]
  def change
    add_column :rover_coordinates, :grid_size, :integer, array: true, default: [5, 5]
  end
end
