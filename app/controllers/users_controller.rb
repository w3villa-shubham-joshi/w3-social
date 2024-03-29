class UsersController < ApplicationController

    # def index
    #     @users = User.all
    # end

    def show
        # binding.pry
        @user = User.find()
        @current_user = current_user
        @rooms = Room.public_rooms
        @users = User.all_except(@current_user)
        @room = Room.new
        @message = Message.new
        @room_name = get_name(@user, @current_user)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
        @messages = @single_room.messages
    
        render "rooms/index"
      end
      
      def edit
        @user = current_user
      end
      
      def update
        @user = current_user
        @user.update!(user_params)
        # binding.pry
        redirect_to root_path
      end



      private

      def get_name(user1, user2)
        users = [user1, user2].sort
        "private_#{users[0].id}_#{users[1].id}"
      end

      def user_params
        params.require(:user).permit(:firstname, :lastname, :username, :email, :image)
      end
end
