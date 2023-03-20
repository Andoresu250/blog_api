class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :json

  def create
    super do

    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      logged_user(resource)
    else
      register_failed
    end
  end

  def register_success
    render json: { message: 'Registration Complete, now please log in' }, status: :ok
  end

  def register_failed
    render json: { message: 'Error', errors: resource.errors }, status: 422
  end

  def logged_user(resource)
    resource.jwt = current_token
    render json: resource, include: '**', status: :created
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end

end
