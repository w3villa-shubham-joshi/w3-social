class CommentsController < ApplicationController
    def new
        @comment= Comment.new
    end
    
    def create    
        # @post = Post.find(params[:post_id])   
        @comment = Comment.create(comment_params.merge(user_id: current_user.id))
        if @comment.save
            flash[:notice] = "New Comment Added Successfully"
            redirect_to root_path
        else    
            flash[:error] = @comment.errors.full_messages.join(', ')
            render :back
        end
    end 

    private 
     
    def comment_params 
        params.require(:comment).permit(:message, :user_id, :post_id, images: [])
    end 


end
