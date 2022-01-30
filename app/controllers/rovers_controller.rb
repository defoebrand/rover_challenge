class RoversController < ApplicationController
  def show
    @rover = RoverCoordinate.find(params[:rover])
  end

  def new
    @rover_movement = RoverCoordinate.new
  end

  def create
    @rover_movement = RoverCoordinate.new(
      initial_orientation: [rover_params[:xCoord].to_i, rover_params[:yCoord].to_i, rover_params[:direction]],
      instructions: rover_params[:instructions]
    )
    
    if @rover_movement.save
      redirect_to controller: 'rovers', action: 'show', rover: @rover_movement.id
    else
      flash.now[:notice] = 'Something went wrong. Please try running your simulation again!'
      render :new
    end
  end

  private

  def rover_params
    params.require(:rover_params).permit(:instructions, :xCoord, :yCoord, :direction)
  end
end
