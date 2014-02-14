class AddColumnToRestaurantsOpeningAndClosingHours < ActiveRecord::Migration
  def change
        add_column :restaurants, :opening_hour, :time
        add_column :restaurants, :closing_hour, :time
        add_column :restaurants, :seating_cycle, :decimal
  end
end
