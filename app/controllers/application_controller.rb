class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

helper_method :seats_left
helper_method :reservation_date


   def reservation_date
    reservation = params[:reservation]
    @date = Date.new reservation["reservation_date(1i)"].to_i, reservation["reservation_date(2i)"].to_i, reservation["reservation_date(3i)"].to_i, reservation["reservation_date(4i)"].to_i
   return @date
   end

   def seats_left
    @total_taken = 0
    @timeslot = []
    @restaurant.reservations.each do |timeslot|
      if (timeslot.reservation_date) == reservation_date
        @timeslot << timeslot
      end
    end

    @timeslot.each do |reservation|
      @total_taken += reservation.party_size.to_i
    end
    @total_available = @restaurant.capacity - @total_taken
    return @total_available
  end

end
