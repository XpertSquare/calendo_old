Calendo::Application.routes.draw do 
  
  get "customers/index"
  get 'site/index'
  get 'accounts/index'  
  get 'register' => 'accounts#new'
  get 'login' => 'sessions#new'
  get 'logout'=>'sessions#destroy'
  
  constraints(Subdomain) do
    get '/' => 'public#index', as: 'acount_root'
    
    namespace :admin do
       get '/' => 'dashboard#index'
       
       resources :services 
       resources :comments
       
       resources :users, :controller => 'customers', :path =>"customers", as: 'customers'
       get '/customers/:id/activity' => 'customers#activity', as: 'customer_activity'
       get '/customers/:id/comments' => 'customers#comments', as: 'customer_comments'
       get '/customers/:id/invoicess' => 'customers#invoices', as: 'customer_invoices'
       
       resources :users, :controller => 'staff', :path =>"staff", as: 'staff'
       
       get '/account' => 'account#show', as: 'account'
       get '/account/edit' => 'account#edit', as: 'edit_account'
       patch '/account' => 'account#update', as: 'update_account'
       
       get '/profile' => 'profile#show', as: 'profile'
       get '/profile/edit' => 'profile#edit', as: 'edit_profile'
       patch '/profile' => 'profile#update', as: 'update_profile'
       
       
       
       
       
       #get '/staff' => 'staff#index', as: 'staff'
       #post '/staff' => 'staff#create', as: 'create_staff'
       #get '/staff/new' => 'staff#new', as: 'new_staff'
       #get '/staff/:id/edit' => 'staff#edit', as: 'edit_staff'
       #patch '/staff/:id' => 'staff#update', as: 'update_staff'
       #put '/staff/:id' => 'staff#update'
       #delete '/staff/:id' => 'staff#destroy', as: 'delete_staff'
       
    end
  end
  
  resources :accounts, only: [:index, :create]
  resources :sessions, only: [:create, :destroy]  
  
  root 'site#index'
  
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
