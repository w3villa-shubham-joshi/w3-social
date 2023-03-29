class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token
    # def create
    #     @like = Like.new(like_params)
    #     @likee = Like.create(like_params.merge(user_id: current_user.id))
    #     if @like.save
    #         flash[:success] = 'Thanks for Liking!'
    #     else
    #         flash[:alert] = @like.errors.full_messages.join(', ')
    #     end
    # end

    def like
        post_get = Post.find_by(id: params[:post_id])
        like = post_get.likes.new(count: 1, user: current_user)
        if like.save
            #add success notice here
            # redirect_to root_path
        else
            # notify to failed like in ui
            redirect_to root_path
        end
    end

    def dislike
        like_get = Like.find_by(user_id: current_user.id, likeable_id: params[:post_id])
        destroy_liek = like_get.destroy
        if destroy_liek
            redirect_to root_path
        else
            redirect_to root_path
        end
    end

    # def destroy
    #     @like = current_user.likes.find(params[:id])
    #     @like.destroy
    # end

    private
    def like_params
        params.permit(:value,:user_id, :reference_id, :reference_type)
    end
end