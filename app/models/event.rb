class Event < ActiveRecord::Base
  has_many :comments
  
  default_scope :order => 'events.created_at DESC'
  
  def description()
    borrower = self.borrower
    if(lender_id.nil?)
      return borrower.name + " wants to borrow " + self.item_name
    else
      item = Item.find(self.item_id)
      lender = self.lender
      if (self.islending?)
        lender.name + " lent " + item.name + " to " + borrower.name
      else
        borrower.name + " returned " + item.name + " to " + lender.name
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
