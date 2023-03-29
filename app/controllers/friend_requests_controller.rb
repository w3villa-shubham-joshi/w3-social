class FriendRequestsController < ApplicationController
    def create
        if sent_friend_request
            flash[:notice] = "Friend Request sent."
        else
            flash[:notice] = "Unable to send request" 
        end

        redirect_to root_path


    end

    def accept
        # need to check how can we accept friend request and send friend request
        # Friendship.create(user_id: params[:receive_id] , friend_id: current_user.id)
        # Friendship.create(user_id: current_user.id, friend_id:  params[:receive_id])
        # create_friendship(params[:receive_id], current_user.id)
        create_friendship(current_user.id, params[:receive_id])
        create_friendship(params[:receive_id], current_user.id)
        FriendRequest.where(requester_id: params[:receive_id], receiver_id: current_user.id).last.update(status: 1)
        flash[:notice] = "Friend Request Accepted"
        redirect_to root_path
    end

    def reject
        reject_friend_request = FriendRequest.find_by(receiver_id: current_user.id, requester_id: params[:receive_id])
        reject_friend_request.update(status: 2) if reject_friend_request.present?
        flash[:notice] = "Friend Request Rejected"        
        redirect_to root_path
    end

 
private

    def create_friendship(sender_id, receiver_id)
        Friendship.create(user_id: sender_id , friend_id: receiver_id)
        # Friendship.create(user_id: receiver_id , friend_id: sender_id)
    end

    def sent_friend_request
        @friend_request = current_user.friend_requests_as_requester.create(receiver_id: params[:receive_id])    
    end  

end


