class ApplicationController < ActionController::Base

  include Pagy::Backend

  skip_before_action :verify_authenticity_token


  def pagination_header(pagy)
    headers["total_pages"] = pagy.pages
    headers["total_items"] = pagy.count
  end
end

