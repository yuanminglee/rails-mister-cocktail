Rails.application.routes.draw do
  root 'cocktails#index'

  resources :cocktails do
    resources :doses, only: %i[new create edit update]
  end

  resources :doses, only: :destroy
end
