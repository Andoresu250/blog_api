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

    resources :friendship_requests, except: [:index, :show, :update] do
      collection do
        get :sent
        get :pending
      end
      member do
        post :accept
      end
    end

    resources :users, only: [:index]
    resources :friends, only: [:index]
  end


end