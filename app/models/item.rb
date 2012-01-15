class Item < ActiveRecord::Base
    belongs_to :user

    validates :name,    :presence => true,
                        :length   => { :maximum => 63 }
    validates :user_id, :presence => true
    validates :borrower_id, :presence => true

    def create_venmo_url(current_user)
      if current_user.id == self.user_id
        borrower_email = URI.escape(borrower.email)
        note = URI.escape("Charging you for #{self.name} that you borrowed through Lendmo")
        "https://venmo.com/?txn=charge&amount=#{self.value}&note=#{note}&recipients=#{borrower_email}"
      else
        lender_email = URI.escape(self.user.email)
        note = URI.escape("Paying you for #{self.name} that I borrowed through Lendmo")
        "https://venmo.com/?txn=pay&amount=#{self.value}&note=#{note}&recipients=#{lender_email}"
      end
    end
    
    def borrower()
      User.find(self.borrower_id)
    end
end
