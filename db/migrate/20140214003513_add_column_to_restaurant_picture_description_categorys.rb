class AddColumnToRestaurantPictureDescriptionCategorys < ActiveRecord::Migration
  def change
    add_column :restaurants, :picture, :string
    add_column :restaurants, :description, :string
    add_column :restaurants, :category1, :string
    add_column :restaurants, :category2, :string
    add_column :restaurants, :category3, :string
  end
end
