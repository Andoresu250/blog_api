Rails.application.routes.draw do

  scope defaults: {format: :json} do
    devise_for :users,
               controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations',
               }, defaults: {format: :json}

    resources :posts do
      collection do
        get :me
      end
    end
  end


end
