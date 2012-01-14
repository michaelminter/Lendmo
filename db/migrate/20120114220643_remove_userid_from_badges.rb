class RemoveUseridFromBadges < ActiveRecord::Migration
  def up
    remove_column :badges, :user_id
  end

  def down
    add_column :badges, :user_id, :integer
  end
end
