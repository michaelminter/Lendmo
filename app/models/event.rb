class Event < ActiveRecord::Base
  has_many :comments
  
  default_scope :order => 'events.created_at DESC'
  
  def description()
    borrower = self.borrower
    borrower_url = Rails.root + "/users/#{borrower.id}"
    
    if(lender_id.nil?)
      return "<a href=#{borrower_url} class='user'>" + borrower.name + "</a> wants to borrow " + self.item_name
    else
      item = Item.find(self.item_id)
      lender = self.lender
      lender_url = Rails.root + "/users/#{lender.id}"
      
      if (self.islending?)
        "<a href=#{lender_url} class='user'>" + lender.name + "</a> lent " + item.name + " to <a href=#{borrower_url} class='user'>" + borrower.name + "</a>"
      else
        "<a href=#{borrower_url} class='user'>" + borrower.name + "</a> returned " + item.name + " to <a href=#{lender_url} class='user'>" + lender.name + "</a>"
      end
    end
  end

  def lender()
    User.find(self.lender_id)
  end

  def borrower()
    User.find(self.borrower_id)
  end
end
