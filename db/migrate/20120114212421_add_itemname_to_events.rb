class AddItemnameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :item_name, :string
  end
end
