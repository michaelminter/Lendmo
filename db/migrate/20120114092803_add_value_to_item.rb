class AddValueToItem < ActiveRecord::Migration
  def change
    add_column :items, :value, :string
  end
end
