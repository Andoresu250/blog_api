class FriendshipRequestsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_friendship_request, only: %i[ destroy accept ]

  def pending
    pagy, records = pagy(FriendshipRequest.where(friend: current_user))
    pagination_header(pagy)
    render json: records, status: :ok
  end

  def sent
    pagy, records = pagy(FriendshipRequest.where(user: current_user))
    pagination_header(pagy)
    render json: records, status: :ok
  end

  def create
    if FriendshipRequest.where(user: current_user, friend_id: friendship_request_params[:friend_id]).exists?
      return render json: { message: "Request already sent" }, status: :unprocessable_entity
    end
    if friendship_request_params[:friend_id] == current_user.id
      return render json: { message: "You can not add yourself" }, status: :unprocessable_entity
    end
    friendship_requests = FriendshipRequest.new(friendship_request_params)
    friendship_requests.user = current_user
    if friendship_requests.save
      render json: friendship_requests, status: :created
    else
      render json: { message: 'Post could be created', errors: friendship_requests.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @friendship_request.destroy
      render json: nil, status: :no_content
    else
      render json: { message: 'The friendship request can not be deleted' }, status: :unprocessable_entity
    end
  end

  def accept
    return render json: { message: "You can not accept this request" }, status: :unprocessable_entity if @friendship_request.friend != current_user
    @friendship_request.accept
    render json: { message: 'Friend request accepted' }, status: :created
  rescue
    render json: { message: 'Friend request can not be accepted' }, status: :unprocessable_entity
  end

  private

  def set_friendship_request
    @friendship_request = FriendshipRequest.find_by(id: params[:id])
    render json: { message: 'Friend request not found' }, status: :not_found if @friendship_request.nil?
  end

  def friendship_request_params
    params.permit(:friend_id)
  end

  def validate_ownership
    render json: { message: 'You can not perform this action on this post' }, status: :unauthorized if @friendship_request.user != current_user && @friendship_request.friend != current_user
  end
end
