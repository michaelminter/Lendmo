class AddNumlendsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :num_lends, :integer
  end
end
