class AddColumnToReservationsReservationHour < ActiveRecord::Migration
  def change
    add_column :reservations, :reservation_hour, :integer
  end
end
