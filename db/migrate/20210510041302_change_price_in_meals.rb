class ChangePriceInMeals < ActiveRecord::Migration[6.0]
  def change
    remove_column :meals, :price
    add_column :meals, :price, :float
  end
end
