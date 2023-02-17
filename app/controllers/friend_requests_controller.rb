class FriendRequestsController < ApplicationController
    def create
        if sent_friend_request
            redirect_to root_path, notice: 'Friend request sent.'
        else
            redirect_to root_path, alert: 'Unable to send friend request.'
        end
    end

    def accept
        Friendship.create(user_id: params[:receive_id] , friend_id: current_user.id)
        Friendship.create(user_id: current_user.id, friend_id:  params[:receive_id])
        redirect_to root_path, notice: 'Friend request accepted.'
    end

    def reject
        reject_friend_request = FriendRequest.find_by(receiver_id: current_user.id)
        reject_friend_request.destroy if reject_friend_request.present?
        redirect_to root_path, notice: 'Friend request rejected.'
    end

 
private

  def sent_friend_request
    @friend_request = current_user.friend_requests_as_requester.create(receiver_id: params[:receive_id])    
  end  

end


