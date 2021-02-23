class PostsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def index
      render json: Post.all
  end

  def show
      render json: Post.find(params["id"])
  end

  def create
      puts params
      render json: Post.create(params["post"])
  end

  def delete
      render json: Post.delete(params["id"])
  end

  def update
      puts params
      render json: Post.update(params["id"], params["post"])
  end
end
