class Comment < ActiveRecord::Base
    belongs_to :event

    validates :content, :presence => true,
                        :length => { :minimum => 1, :maximum => 500 }
    validates :user_id, :presence => true
    validates :event_id, :presence => true

end
