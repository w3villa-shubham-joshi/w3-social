class PostsController < ApplicationController
    def new
        @post= Post.new
    end
    
    def create       
        @post = Post.new(post_params.merge(user_id: current_user.id))
        if @post.save
            redirect_to root_path
        else
            flash[:error] = @post.errors.full_messages.join(', ')
            render :back
        end
    end 

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new(:post => @post)
    end

    private 
     
    def post_params 
        params.require(:post).permit(:title,:heading,:user_id,:images)
    end 


end
