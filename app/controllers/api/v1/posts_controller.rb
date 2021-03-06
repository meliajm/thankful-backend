class Api::V1::PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
  
    def index
      @posts = Post.all
  
      render json: @posts, include: [:user]
    end
  
    def show
      render json: @post
    end
  
    def create
      # binding.pry
      @user = current_user
      @post = Post.new(post_params)
      @post.user = @user

      if @post.save
        render json: @post, include: [:user], status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def post_params
        params.require(:post).permit(:entry)
      end
  end
  