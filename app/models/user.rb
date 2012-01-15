class User < ActiveRecord::Base
  has_many :items

  has_and_belongs_to_many :badges

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
    friends = []
    
    if not token.nil?
      fbUser = FbGraph::User.new(self.fb_id, :access_token => token)
      fbUser = fbUser.fetch
      fbUser.friends.each do |f|
        user = User.exists(f.identifier)
        if !user.nil?
          friends << user
        end
      end
    end
    
    friends
  end
  
  def feed_events(token)
    friends = self.friends(token)
    events = []
    friends.each do |f|
      friend = User.where(:fb_id => f.fb_id).first
      if !friend.nil?
        Event.where("lender_id = ? OR borrower_id = ?", friend.id, friend.id).each do |e|
          events << e unless e.nil?
        end
      end
    end
    events
  end
  
  def activity_events()
    events = []
    Event.where("lender_id = ? OR borrower_id = ?", self.id, self.id).find_each do |e|
      events << e unless e.nil?
    end
    events
  end
  
  def self.exists(fb_id)
    existing = User.where(:fb_id => fb_id).first
  end
  
  # Select a random user from the database
  def self.random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
  end

  def return(item)
    Event.create(:item_id => item.id, :islending => false)
    item.destroy
  end
  
  def lend(item, borrower)
    Event.create(:item_id => item.id, :borrower_id => borrower.id, :lender_id => self.id, :item_name => item.name, :islending => true)
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

  def create_venmo_url(item)
    value = item.value
    name  = item.name
    borrower_email = User.find(item.borrower_id).email
    
    note = URI.escape("Paying you #{name} that I borrowed through Lendmo")
    
    "https://venmo.com/?txn=pay&amount=#{value}&note=#{note}&recipients=#{borrower_email}"
  end
  
end
