class Item < ActiveRecord::Base
    belongs_to :user

    validates :name,    :presence => true,
                        :length   => { :maximum => 63 }
    validates :category,    :presence => true,
                            :length   => { :maximum => 63 }
    validates :borrower_id, :presence => true


end
