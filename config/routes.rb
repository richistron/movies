Rails.application.routes.draw do
  namespace :v1 do
    resources :movies, only: [:index, :show, :create]
  end
end
