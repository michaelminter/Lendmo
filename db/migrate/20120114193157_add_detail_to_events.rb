class AddDetailToEvents < ActiveRecord::Migration
  def change
    add_column :events, :lender_id, :integer
    add_column :events, :borrower_id, :integer
  end
end
