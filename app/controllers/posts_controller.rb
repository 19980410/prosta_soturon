class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    post = Post.new(post_params)

    post.user_id = current_user.id

    post.save
    redirect_to post_path(post)
  end


  def destroy

  end

  def update
    post = Post.find(params[:id])

    params[:post][:image_id].each do |image_id|
      image = post.images.find(image_id)
      image.purge
    end
    post.update(post_params)
    redirect_to post_path(post)
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :language_id, :title, :body, images: [])
  end
end