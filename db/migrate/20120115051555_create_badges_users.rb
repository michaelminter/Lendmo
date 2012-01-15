class CreateBadgesUsers < ActiveRecord::Migration  
  def change
    create_table :badges_users, :id => false do |t|
      t.integer :user_id
      t.integer :badge_id
    end
  end
end