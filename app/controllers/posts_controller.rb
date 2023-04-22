class PostsController < ApplicationController

  before_action :authenticate_user!, only: [ :me, :create, :update, :destroy ]
  before_action :set_post, only: [:update, :destroy, :show]
  before_action :validate_ownership, only: [:update, :destroy]

  def index
    if current_user.present?
      pagy, records = pagy(Post.for_every_one, page: params[:page], items: params[:items])
    else
      pagy, records = pagy(Post.for_every_one, page: params[:page], items: params[:items])
    end
    pagination_header(pagy)
    render json: records, status: :ok
  end

  def me
    pagy, records = pagy(Post.where(posts: { author: current_user }), page: params[:page], items: params[:items])
    pagination_header(pagy)
    render json: records, status: :ok
  end

  def show
    render json: @post, status: :ok
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    if post.save
      render json: post, status: :created
    else
      render json: { message: 'Post could be created', errors: post.errors }, status: :unprocessable_entity
    end
  end

  def update
    @post.assign_attributes(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: { message: 'Post could be created', errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: nil, status: :no_content
    else
      render json: { message: 'The post can not be deleted' }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:id, :title, :content, :post_type)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
    render json: { message: 'Post not found' }, status: :not_found if @post.nil?
  end

  def validate_ownership
    render json: { message: 'You can not perform this action on this post' }, status: :unauthorized if @post.author != current_user
  end

end
