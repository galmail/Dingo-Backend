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
    namespace :v1 do
      resources :users, defaults: {format: :json} do
        post  'block'
        post  'report'
      end
      resources :tickets, defaults: {format: :json}
      resources :events, defaults: {format: :json}
      resources :categories, defaults: {format: :json}
      resources :messages, defaults: {format: :json}
      resources :offers, defaults: {format: :json}
      resources :devices, defaults: {format: :json}
      resources :orders, defaults: {format: :json}
      resources :alerts, defaults: {format: :json}
      
      namespace :payments do
        post  'store_credit_card'
        get   'verify_credit_card'
        post  'authorize_payment'
      end
      
      namespace :paypal do
        post  'success'
        post  'cancel'
        post  'notification'
      end
      
      namespace :promos do
        get   'get_discount'
      end
      
    end
  end

end
