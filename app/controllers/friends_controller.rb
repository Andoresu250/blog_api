class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:search].blank? || params[:search].length < 3
      pagy, records = pagy(current_user.friends, page: params[:page], items: params[:items])
    else
      pagy, records = pagy(current_user.friends.search(params[:search]), page: params[:page], items: params[:items])
    end
    pagination_header(pagy)
    render json: records, status: :ok
  end
end
