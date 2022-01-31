class RoversController < ApplicationController
  def show
    @rover = RoverCoordinate.find(params[:rover])[0]
  end

  def new
    @rover_movement = RoverCoordinate.new
  end

  def create
    @rover_movement = RoverCoordinate.new(
      initial_orientation: [rover_params[:xCoord], rover_params[:yCoord], rover_params[:direction]],
      instructions: rover_params[:instructions],
      grid_size: rover_params[:grid_size]
    )

    begin
      if @rover_movement.save
        redirect_to controller: 'rovers', action: 'show', rover: [@rover_movement.id]
      else
        flash.now[:notice] = 'Something went wrong. Please try running your simulation again!'
        render :new
      end
    rescue ArgumentError => e
      flash[:notice] = e
      @rover_movement.destroy
      redirect_to root_path and return
    end
  end

  private

  def rover_params
    params.require(:rover_params).permit(:instructions, :xCoord, :yCoord, :direction, grid_size: [])
  end
end
