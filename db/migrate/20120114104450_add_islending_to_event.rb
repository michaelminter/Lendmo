class AddIslendingToEvent < ActiveRecord::Migration
  def change
    add_column :events, :islending, :boolean
  end
end
