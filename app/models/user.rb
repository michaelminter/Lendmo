class User < ActiveRecord::Base
  has_many :items
  
  validates :first_name,  :presence => true,
                          :length   => { :maximum => 63 }
  validates :last_name,   :presence => true,
                          :length   => { :maximum => 63 }
  
  def name()
    self.first_name + " " + self.last_name
  end
  
  def profile_picture()
    "http://graph.facebook.com/" + self.fb_id + "/picture"
  end
  
  # Grab the list of Facebook friends using Lendmo
  def friends(token)
    if not token.nil?
      fbUser = FbGraph::User.new(self.fb_id, :access_token => token)
      fbUser = fbUser.fetch
      fbUser.friends
    end
  end
  
  def feed_events(token)
    friends = self.friends(token)
    events = []
    friends.each do |f|
      friend = User.where(:fb_id => f.identifier).first
      if !friend.nil?
        Event.where("lender_id = ? || borrower_id = ?", friend.id, friend.id).each do |e|
          events << e unless e.nil?
        end
      end
    end
    events
  end
  
  def activity_events()
    Event.where("lender_id = ? || borrower_id = ?", self.id, self.id)
  end
  
  def self.exists(fb_id)
    existing = User.where(:fb_id => fb_id).first
    return !existing.nil?
  end
  
  # Select a random user from the database
  def self.random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
  end

  # Lend an item to a friend
  def return(item_id)
    Event.create(:item_id => i, :isLending => false)
    i = Item.find(item_id)
    i.destroy
  end
  def lend(item, borrower, value)
    i = Item.new(:name => item, :user_id => self.id, :borrower_id => borrower, :value => value)
    Event.create(:item_id => i.id, :isLending => true)
  end

  # Find the user trying to sign in, or create a new one if they're new
  def self.find_or_create(auth_hash)
    existing = User.where("fb_id = ?", auth_hash[:uid]).first
    
    if existing.nil?
      User.create(
        :first_name => auth_hash[:info][:first_name],
        :last_name => auth_hash[:info][:last_name],
        :email => auth_hash[:info][:email],
        :url => auth_hash[:info][:urls][:Facebook],
        :fb_id => auth_hash[:uid]
      )
    else
      existing
    end
  end
end
