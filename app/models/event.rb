class Event < ActiveRecord::Base
    has_many :comments
    validates :item_id, :presence => true
    
    def description
        item = Item.find(:item_id)
        lender = User.find(item.user_id)
        borrower = User.find(item.borrower_id)

        lender.name + " lent " + item.name + 
            " to " + borrower.name
    end
end
