class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :seats_left
  helper_method :reservation_date
  helper_method :current_user
  helper_method :current_user
  helper_method :hours
  helper_method :seating_hours



  def reservation_date
    reservation = params[:reservation]
    @date = Date.new reservation["reservation_date(1i)"].to_i, reservation["reservation_date(2i)"].to_i, reservation["reservation_date(3i)"].to_i
    return @date
  end

  def hours
    [["Select Hour"], ["5 am", 5], ["6 am", 6], ["7 am", 7], ["8 am", 8], ["9 am", 9], ["10 am", 10], ["11 am", 11], ["noon", 12], ["1 pm", 13], ["2 pm", 14], ["3 pm", 15], ["4 pm", 16], ["5 pm", 17], ["6 pm", 18], ["7 pm", 19], ["8 pm", 20], ["9 pm", 21], ["10 pm", 22], ["11 pm", 23], ["12 pm", 0], ["1 am", 1], ["2 am", 2], ["3 am", 3], ["4 am", 4]]
  end

  def seats_left
    @total_taken = 0
    @timeslot = []
    @restaurant.reservations.each do |timeslot|
      if (timeslot.reservation_date) == reservation_date && (timeslot.reservation_hour) == params[:reservation][:reservation_hour].to_i
        @timeslot << timeslot
      end
  end
    @timeslot.each do |reservation|
      @total_taken += reservation.party_size.to_i
    end
    @total_available = @restaurant.capacity - @total_taken
    return @total_available
  end

  def seating_hours
    @reservation_hour = [["Select Hour"]]
    if (@restaurant.closing_hour.hour - 5) <= 0
      @normalized_closing_hour = @restaurant.closing_hour.hour + 24
    else
      @normalized_closing_hour = @restaurant.closing_hour.hour
    end
    if (@restaurant.opening_hour.hour - 5) <= 0
      @normalized_opening_hour = @restaurant.opening_hour.hour + 24
    else
      @normalized_opening_hour = @restaurant.opening_hour.hour
    end
    @total_cycles = ((@normalized_closing_hour - @normalized_opening_hour) / @restaurant.seating_cycle).floor
    @collection = @restaurant.opening_hour.hour - 5.0
    (1..@total_cycles).each do |seating|
      @collection % 1 > 0 ? @hourfix = 0.2 : @hourfix = 0
      if seating == 1
        timeslot =["#{@restaurant.opening_hour.hour - 5.0} hs", (@restaurant.opening_hour.hour - 5)]
      else

        timeslot = ["#{@collection - @hourfix} hs", @collection - @hourfix]
      end
      @reservation_hour << timeslot
      @collection = @collection + @restaurant.seating_cycle
    end
    return @reservation_hour
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end



end
