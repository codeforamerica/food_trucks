FoodTrucks::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    resources :vendors do
      resources :time_slots
    end
    resources :locations do
      resources :time_slots
    end
  end

  namespace :api do
    resources :locations, only: [ :index, :show ]
    resources :vendors, only: [ :index, :show ]
    resources :time_slots, only: [ :index, :show ]
  end

  root to: "admin/dashboard#index"
end
