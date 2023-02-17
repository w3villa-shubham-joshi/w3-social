module ApplicationHelper
    def comment_order(comment)
        comment.all.order(created_at: :desc)
    end

    def all_user
        User.where.not(id: current_user.id)
    end


    def check_friend_request_sent(requestor , receiver)
        FriendRequest.where(requester_id: [requestor,receiver],receiver_id: [requestor,receiver]).last
    end 

    # def check_friend_request(receiver , requestor)
    #     FriendRequest.where(requester_id: requestor,receiver_id: receiver).last
    # end 


    def check_incoming_friend_request 
        ids = all_user.pluck(:id)
        FriendRequest.where(requester_id: ids,receiver_id: current_user.id)

    end

    def friendships
        # binding.pry
        ids = all_user.pluck(:id)
        Friendship.where(user_id: ids, friend_id: current_user.id )
    end 

    def get_user(id)
        User.find(id)
    end 



    def check_friendship(user,friend)
        # binding.pry
        Friendship.where(user_id: user, friend_id: friend).last
    end 
end
