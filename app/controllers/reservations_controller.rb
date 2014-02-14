class ReservationsController < ApplicationController

  before_filter :load_restaurant

  def index
  end

  def show
  	@reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @party_size = params[:reservation][:party_size].to_i
  	if @party_size <= seats_left
      @reservation = @restaurant.reservations.build(reservation_params)
      @reservation.user_id = current_user.id
	  	if @reservation.save
        flash[:notice] = "Your reservation for #{ @reservation.party_size } people has been confimed"
	  		redirect_to restaurant_path(:id => @restaurant.id)
	  	else
	  		render :new
	  	end
	  else
    		flash[:notice] = "There are not enough seats left at #{@restaurant.name} for #{@date}. Please choose another date"
        redirect_to restaurant_path(:id => @restaurant.id)
  	end
  end

  def edit
  	@reservation = Reservation.find(params[:id])
  end

  def update
  	@reservation = Reservation.find(params[:id])
  	if @reservation.update_attributes(reservation_params)
  		redirect_to reservations_path
  	else
  		render :edit
  	end
  end

  def destroy
  	@reservation = Reservation.find(params[:id])
  	@reservation.destroy
  	redirect_to restaurant_path(@restaurant)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:id, :party_size, :restaurant_id, :reservation_date, :reservation_hour, :user_id, :name)
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end
