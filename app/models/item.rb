class Item < ActiveRecord::Base
    belongs_to :user

    validates :name,    :presence => true,
                        :length   => { :maximum => 63 }
    validates :user_id, :presence => true
    validates :borrower_id, :presence => true

end
