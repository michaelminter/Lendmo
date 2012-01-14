class Comment < ActiveRecord::Base
    belongs_to :event, :user

    validates :content, :presence => true

end
