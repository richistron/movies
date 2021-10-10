Rails.application.routes.draw do
  namespace :v1 do
    resources :movies, except: :destroy
  end
end
