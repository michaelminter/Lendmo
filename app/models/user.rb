class User < ActiveRecord::Base
  has_many :items
  
  has_and_belongs_to_many :badges
  
  after_create :first_badge

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
      
      friend_fb_ids = []
      fbUser.friends.each { |f| friend_fb_ids << f.identifier }
      
      User.where(:fb_id => friend_fb_ids).find_each { |user| friends << user }
    end
    
    friends
  end
  
  # Look through the list of friends using Lendmo and find events they've been involved in
  def feed_events(token)
    friends = self.friends(token)
    friends.each do |f|
      friend = User.where(:fb_id => f.fb_id).first
      if !friend.nil?
        return Event.where("lender_id = ? OR borrower_id = ? OR borrower_id = ?", friend.id, friend.id, self.id)
      end
    end
      return Event.where("borrower_id = ?", self.id)
  end
  
  def activity_events()
    Event.where("lender_id = ? OR borrower_id = ?", self.id, self.id)
  end
  
  def first_badge
    badge = Badge.find(1)
    self.badges << badge
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

  def give_back(item)
    Event.create(:item_id => item.id, :lender_id => item.user_id, :borrower_id => item.borrower_id, :islending => false)
    lender = User.find(item.user_id)
    lender.num_lends -= 1
  end
  
  def lend(item, borrower, token)
    if !token.nil?
      # Post a Facebook Open Graph action for this lend operation
      uri = URI('https://graph.facebook.com/me/lendmo-app:lend')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      req = Net::HTTP::Post.new(uri.request_uri)
      req.set_form_data('item' => 'http://samples.ogp.me/222418151177756', 'access_token' => token)
      response = http.request(req)
    end
    
    self.num_lends += 1
    Event.create(:item_id => item.id, :borrower_id => borrower.id, :lender_id => self.id, :item_name => item.name, :islending => true)
  end
  
  # Post a status to user's Facebook wall about his borrow request
  def post_borrow_status(event, token)
    if not token.nil?
      me = FbGraph::User.me(token)
      me.feed!(
        :message => "I'm looking to borrow #{event.item_name} on Lendmo. Can anyone help me out?",
        :link => "http://lendmo.heroku.com/users/#{self.id}",
        :name => "Lendmo",
        :description => "A social lending platform"
      )
    end
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
        :fb_id => auth_hash[:uid],
        :num_lends => 0
      )
    else
      existing
    end
  end

end
