class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    html = "<p>#{message.sender.username}: #{message.text}</p>"
    chat_id = [message.sender_id, message.receiver_id].sort.join("")
    ActionCable.server.broadcast("message_channel_#{chat_id}",  html)
  end
end
