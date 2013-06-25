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

  root to: "admin/dashboard#index"
end
