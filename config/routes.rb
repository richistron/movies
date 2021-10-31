Rails.application.routes.draw do
  root to: 'v1/movies#index'

  namespace :v1 do
    resources :movies
  end
end
