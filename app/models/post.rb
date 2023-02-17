class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy 
    has_many_attached :images 

    #polymorphic association
    has_many :likes, as: :likeable

    def is_liked?(user)
        likes.where(user_id: user.id).any?
    end
end
