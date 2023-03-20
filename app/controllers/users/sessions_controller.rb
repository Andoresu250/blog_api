# frozen_string_literal: true

require 'digest'

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  def create
    super do
      return logged_user(resource)
    end
  end

  private

  def logged_user(resource)
    resource.jwt = current_token
    render json: resource, include: '**', status: :created
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
