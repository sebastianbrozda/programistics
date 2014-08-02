Rails.application.routes.draw do

  post 'comments/create' => 'comments#create'

  get 'my_earnings/index'
  get 'my_earnings' => "my_earnings#index"

  get 'user_settings' => "user_settings#index"
  post 'update_email' => 'user_settings#update_email'
  post 'update_bitcoin_wallet' => 'user_settings#update_bitcoin_wallet'
  post 'upload_avatar' => 'user_settings#upload_avatar'

  get "payment_notification/coinbase" => "payment_notification#coinbase", as: 'payment_notification_coinbase'

  get "purchase/note/:id" => "purchase#note", as: 'purchase_note'

  post "favorites/add_note_to_favorites" => "favorites#add_note_to_favorites", as: :add_note_to_favorites
  post "favorites/remove_note_from_favorites" => "favorites#remove_note_from_favorites", as: :remove_note_from_favorites
  get "favorite/notes" => "favorites#notes", as: 'favorite_notes'

  get "notes/my_own" => "notes#my_own", as: 'my_own_notes'
  resources :notes, only: [:show, :new, :create]

  devise_for :users

  root "home#index"

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
