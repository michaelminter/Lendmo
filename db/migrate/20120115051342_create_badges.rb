class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image_uri
      t.string :description

      t.timestamps
    end
    
    Badge.create :name => 'Sign Up', :image_uri => 'signup_badge.png', :description => 'Welcome to Lendmo! Congrats for signing up.'
    Badge.create :name => 'First Lend', :image_uri => 'firstlend_badge.png', :description => 'Way to go! You lent for the first time on Lendmo.'
  end
end
