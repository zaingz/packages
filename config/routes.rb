Rails.application.routes.draw do
  resources :packages
  resources :requests



  #devise_for :users
  devise_for :users, path: "me", path_names: { sign_in: 'login', sign_out: 'logout', registration: 'profile', sign_up: 'signup' }
  root 'me#profile'
  get '/me/profile', to: 'me#profile'
  get 'packages/search/:distance', to: 'packages#search'
  get '/packages/status/delivered', to: 'packages#delivered'
  get '/packages/status/not_delivered', to: 'packages#not_delivered'
  get '/package/:id/requests', to: 'packages#requests'
  get '/package/:id/request_makers', to: 'packages#request_makers'
  get '/requests/status/pending', to: 'requests#pending'
  get '/requests/status/accepted', to: 'requests#accepted'
  get '/request/:id/package', to: 'requests#package'
  get '/request/:id/package_owner', to: 'requests#package_owner'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
