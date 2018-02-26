class PostsController < ApplicationController
  before_action :set_post , only:[:show,:edit]

  def index
    @posts = Post.all
  end

  def create
    @post = Post.create(post_params);
    # attaches id of signed in user
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post , notice: 'Post created successfully'
    else
      render :new
    end
  end

  def show
  end

  def new
    @post = Post.new
  end
  def edit
  end
  private
  def post_params
    params.require(:post).permit(:date,:rationale,:sd)
  end
  def set_post
    @post = Post.find(params[:id])
  end
end
