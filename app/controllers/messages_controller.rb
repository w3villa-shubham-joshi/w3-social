class MessagesController < ApplicationController

    def create
        message = Message.create(sender_id: params[:sender_id], receiver_id: params[:receiver_id], text: params[:message])
        ActionCable.server.broadcast("message_channel", {message: message})
        SendMessageJob.perform_later(message)
        # redirect_back(fallback_location: "/users")
        
    end
end
