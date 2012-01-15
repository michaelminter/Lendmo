class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image_uri
      t.string :description

      t.timestamps
    end
    
    Badge.create :name => 'Sign Up', :image_uri => 'signup_badge.png', :description => 'Welcome to Lendmo! Congrats for signing up.', :type => 'Start'
    Badge.create :name => 'First Lend', :image_uri => 'firstlend_badge.png', :description => 'Way to go! You lent for the first time on Lendmo.', :type => 'Lend'
    Badge.create :name => 'Fifth Lend', :image_uri => 'fifthlend_badge.png', :description => 'Wow! You\'re really getting a hang of this lending thing!', :type => 'Lend'
    Badge.create :name => 'Butterfingers', :image_uri => 'butterfingers_badge.png', :description => 'You broke it, you bought it...', :type => 'Special'
  end
end
