class ChangeReservationTimeToDecimal < ActiveRecord::Migration
  def change
    remove_column :reservations, :reservation_hour, :integer
    add_column :reservations, :reservation_hour, :decimal
  end
end
