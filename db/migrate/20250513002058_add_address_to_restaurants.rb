class AddAddressToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :address, :string
    # remove_column :restaurants :address, :string
    # add_reference
    # remove_reference
  end
end
