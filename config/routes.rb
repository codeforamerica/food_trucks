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
    resources :locations, only: [ :index, :show ] do
      collection do
        get :search
      end

      resources :time_slots, only: [ :index, :show ] do
        collection do
          get :search
        end
      end
    end

    resources :vendors, only: [ :index, :show ] do
      collection do
        get :search
      end
    end
  end

  root to: "admin/dashboard#index"
end
