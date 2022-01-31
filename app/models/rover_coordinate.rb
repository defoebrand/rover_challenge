class RoverCoordinate < ApplicationRecord
  validates :instructions, presence: true

  before_save :calculate_final_orientation

  def calculate_final_orientation
    self.final_orientation = RoverMovement.process_instructions(
      grid_size, [
        initial_orientation,
        instructions
      ]
    )[0]
  end

  def initial_orientation=(param_values)
    return if param_values.any?(nil)

    self[:initial_orientation] = [param_values[0].to_i, param_values[1].to_i, param_values[2]]
  end

  def grid_size=(param_value)
    self[:grid_size] = param_value.presence || self[:grid_size]
  end
end
