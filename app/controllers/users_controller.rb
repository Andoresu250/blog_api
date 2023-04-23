class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    return render json: [], status: :ok if params[:search].blank? || params[:search].length < 3
    pagy, records = pagy(User.search(params[:search]), page: params[:page], items: params[:items])
    pagination_header(pagy)
    render json: records, status: :ok
  end

end
