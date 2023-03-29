class Message < ApplicationRecord
  before_create :confirm_participant
  belongs_to :user
  belongs_to :room
  after_create_commit { broadcast_append_to self.room }

  def confirm_participant
    if self.room.is_private
      is_participant = Participant.where(user_id: self.user_id, room_id: self.room.id).first
      throw :abort unless is_participant
    end
  end
end
