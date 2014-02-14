class RestaurantsController < ApplicationController

  def index
    @restaurants=Restaurant.all
    @user = current_user

  end

  def new
    @restaurant=Restaurant.new
    @hours = hours
  end

  def create
    @restaurant = current_user.build_restaurant(restaurant_params)

    if @restaurant.save
      redirect_to restaurants_path
    else
      render :new
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reservation = Reservation.new
    @user = current_user
    @hash = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
    marker.lat restaurant.latitude
    marker.lng restaurant.longitude
end
  end

  def edit
    @restaurant = Restaurant.find([params[:id]])
  end

  def update
    @restaurant = Restaurant.find([params[:id]])
    if @restaurant.update_attributes(restaurant_params)
      redirect_to restaurants_path
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:capacity, :id, :user_id, :opening_hour, :closing_hour, :seating_cycle, :picture, :description, :category1, :category2, :category3)
  end

end
