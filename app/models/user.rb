require 'open-uri'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

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

  
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  validates_uniqueness_of :username
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" } 

  # has_many :messagee, foreign_key: :receiver_id, class_name: 'Message'
  # has_many :senders, through: :messagee
  # has_many :messaged, foreign_key: :sender_id, class_name: 'Message'
  # has_many :receivers, through: :messaged
  after_create_commit { broadcast_append_to "users" }
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy


  
  def friendships
    friendships_as_user + friendships_as_friend
  end

  attr_accessor :login
  
  def login
    @login || username || email
  end
  

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.from_omniauth(auth)
      
    # binding.pry
    user = User.find_by_email(auth.info.email)

    if user.present?
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.save
    else
      user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name 
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.save
      image_url = auth.info.image  
      downloaded_file = URI.open(image_url)
      user.image.attach(io: downloaded_file, filename: "foo.png")
    end
      user
  end
end

