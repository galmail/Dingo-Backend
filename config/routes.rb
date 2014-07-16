Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end
  
  get "/api" => redirect("https://apigee.com/dingoapp/console/dingo1")
  
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  namespace :api do
    namespace   :v1 do
      resources :tickets, defaults: {format: :json}
      resources :events, defaults: {format: :json}
      resources :categories, defaults: {format: :json}
    end
  end

end
