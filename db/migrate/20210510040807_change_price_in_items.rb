class ChangePriceInItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :price
    add_column :items, :price, :float
  end
end
