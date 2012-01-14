class RemoveDescriptionFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :description
  end

  def down
    add_column :events, :description, :string
  end
end
