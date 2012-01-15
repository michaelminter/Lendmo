class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image_uri
      t.string :description
      t.string :type
      t.timestamps
    end
    
    Badge.create :name => 'Sign Up',        :image_uri => 'signup_badge.png', 
                 :description => 'Welcome to Lendmo! Congrats for signing up.'
    Badge.create :name => 'First Lend',     :image_uri => 'firstlend_badge.png', 
                 :description => 'Way to go! You lent for the first time on Lendmo.'
    Badge.create :name => 'Fifth Lend',     :image_uri => 'fifthlend_badge.png', 
                 :description => 'Wow! You are really getting a hang of this lending thing!'
    Badge.create :name => 'Butterfingers',  :image_uri => 'butterfingers_badge.png', 
                 :description => 'You broke it, you bought it...'
    Badge.create :name => 'First Borrow',   :image_uri => 'firstborrow_badge.png',
                 :description => 'You borrowed for the first time on Lendmo. Just remember to return it!'
    Badge.create :name => 'Fifth Borrow',   :image_uri => 'fifthborrow_badge.png',
                 :description => 'Wow! You are really getting a hang of this borrowing thing!'
    # :name => 'First Return',  :image_uri => '??', :description => 'Good for you for being responsible'
  end
end
