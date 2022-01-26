class RoversController < ApplicationController
  def show
    @rover = RoverCoordinate.find(params[:rover])
    @display_results = @rover.final_orientation
  end

  def new
    @rover_movement = RoverCoordinate.new
    # @rover_coords = RoverMovement.process_instructions([3, 3, 'E'], 'MMRMMRMRRM')
    # @rover_coords2 = RoverMovement.process_instructions([1, 2, 'N'], 'LMLMLMLMM')
  end

  def create
    @rover_movement = RoverCoordinate.create(
      initial_orientation: [rover_params[:xCoord].to_i, rover_params[:yCoord].to_i, rover_params[:direction]],
      instructions: rover_params[:instructions]
    )

    redirect_to controller: 'rovers', action: 'show', rover: @rover_movement.id
  end

  private

  def rover_params
    params.require(:rover_params).permit(:instructions, :xCoord, :yCoord, :direction)
  end
end
