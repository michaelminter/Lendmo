class Event < ActiveRecord::Base
    has_many :comments
    
    def description
        item = Item.find(:item_id)
        lender = User.find(:lender_id)
        borrower = User.find(:borrower_id)
        if (self.islending?)
          lender.name + " lent " + item.name + " to " + borrower.name
        else
          borrower.name + " returned " + item.name + " to " + lender.name
        end
    end

    def lender()
        User.find(self.lender_id)
    end

    def borrower()
        User.find(self.borrower_id)
    end
end
