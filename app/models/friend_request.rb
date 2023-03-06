class FriendRequest < ApplicationRecord

  PENDING = 0
  ACCEPTED = 1
  REJECTED = 2

  enum status: { pending: PENDING, accepted: ACCEPTED, rejected: REJECTED }
  
  belongs_to :requester, class_name: :User
  belongs_to :receiver, class_name: :User
end
