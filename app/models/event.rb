class Event < ActiveRecord::Base
  has_many :comments
  
  def description()
    borrower = User.find(self.borrower_id)
    if(lender_id.nil?)
      return borrower.name + " wants to borrow stuff"
    else
      item = Item.find(self.item_id)
      lender = User.find(self.lender_id)
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
