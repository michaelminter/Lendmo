class Event < ActiveRecord::Base
    has_many :comments
    validates :item_id, :presence => true
    
    def description
        item = Item.find(:item_id)
        lender = User.find(item.user_id)
        borrower = User.find(item.borrower_id)
        if (self.isLending?)
        lender.name + " lent " + item.name + 
            " to " + borrower.name
        else
        borrower.name + " returned " item.name + " to " + lender.name
        end
    end

    def get_lender
        item = Item.find(:item_id)
        User.find(item.user_id)
    end

    def get_borrower
        item = Item.find(:item_id)
        User.find(item.borrower_id)
    end
end
