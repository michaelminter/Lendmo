class User < ActiveRecord::Base
  has_many :items

  attr_accessible :first_name, :last_name, :email
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name,  :presence => true,
                          :length   => { :maximum => 63 }
  validates :last_name,   :presence => true,
                          :length   => { :maximum => 63 }
  validates :email, :presence => true,
                    :length   => { :maximum => 63 },
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false}
  
  def name()
    self.first_name + " " + self.last_name
  end
  
  # Select a random user from the database
  def self.random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
  end
  
end
