class AttractionsController < ApplicationController

  def index
    @attractions = Attraction.all 
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)
      if @attraction.save
        redirect_to attraction_path(@attraction)
      else
        render 'new'
      end
  end

  def show
    @attraction = Attraction.find(params[:id])
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.new(attraction_params)
      if @attraction.save
        redirect_to attraction_path(@attraction)
      else
        render 'edit'
      end
  end

  def ride
    @ride = Ride.new(user_id: current_user.id, attraction_id: params[:id])
    ride_result = @ride.take_ride
    if ride_result == true
      redirect_to user_path(current_user), notice: "Thanks for riding the #{@ride.attraction.name}!"
    else
      redirect_to user_path(current_user), notice: ride_result
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :happiness_rating, :nausea_rating, :min_height)
  end

end
