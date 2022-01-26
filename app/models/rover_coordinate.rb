class RoverCoordinate < ApplicationRecord
  validates :initial_orientation, :instructions, presence: true

  before_save :calculate_final_orientation

  def calculate_final_orientation
    self.final_orientation = RoverMovement.process_instructions(
      initial_orientation,
      instructions
    )
  end
end
