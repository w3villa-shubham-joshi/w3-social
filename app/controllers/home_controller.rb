class HomeController < ApplicationController
  before_action :authenticate_user!
    def index
      @post = Post.new
      @posts = Post.all.order(created_at: :desc)
      # @posts = current_user.posts.includes(:comments).order(created_at: :desc)
      @comment = Comment.new
      # binding.pry
      # @comments = Comment.all.order(created_at: :desc)
      # @like = Like.new
      # @likes = Like.all
      # render
    end

end
