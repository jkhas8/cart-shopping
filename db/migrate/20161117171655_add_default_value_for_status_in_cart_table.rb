class AddDefaultValueForStatusInCartTable < ActiveRecord::Migration[5.0]
  def up
    change_column :carts, :status, :string, default: "open"
  end

  def down
    change_column :carts, :status, :string, default: nil
  end
end
