class User < ActiveRecord::Base
  has_many :items
  
  validates :first_name,  :presence => true,
                          :length   => { :maximum => 63 }
  validates :last_name,   :presence => true,
                          :length   => { :maximum => 63 }
  
  def name()
    self.first_name + " " + self.last_name
  end
  
  # Select a random user from the database
  def self.random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
  end
<<<<<<< HEAD
  def lend

  end
=======
  
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
  
<<<<<<< HEAD
>>>>>>> 330373e4cfca93dbe592ad3087ce3f1e6483b474
=======
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
  
>>>>>>> 330373e4cfca93dbe592ad3087ce3f1e6483b474
end
