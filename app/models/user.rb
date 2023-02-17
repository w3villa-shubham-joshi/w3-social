class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_one_attached :image
  has_many :likes, dependent: :destroy

  has_many :friend_requests_as_requester, foreign_key: :requester_id, class_name: :FriendRequest
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: :FriendRequest

  has_many :friendships_as_user, foreign_key: :user_id, class_name: :Friendship
  has_many :friendships_as_friend, foreign_key: :friend_id, class_name: :Friendship
  
  has_many :friendships, ->(user) {where("user_id = ? OR friend_id = ?", user.id, friend.id)}
  has_many :friends, through: :friendships
  # has_many :friend_as, through: :friendships_as_user
  # has_many :friend_bs, through: :friendships_as_friend

  # has_many :incoming_friend_requests, class_name: :FriendRequest, source: :friend

  
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  def friendships
    friendships_as_user + friendships_as_friend
  end

  attr_accessor :login
  
  def login
    @login || username || email
  end
  
  # def email_required?
  #   false
  # end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end

