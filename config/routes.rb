Ashint::Application.routes.draw do
  
  # Customizing paths for devise.
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => 'logout' }
  
  # Defining our nested resources.
  resources :bookmarks
  
  resources :clients, :has_many => :notes, :shallow => true do
    resources :projects, :except => 'show', :has_many => :notes
    resources :entities, :has_many => :notes
  end
  
  # Administration for entity types and keys
  scope "/admin" do
    resources :entity_types, :entity_keys, :users, :except => 'show'
  end
  match '/admin' => redirect('/admin/entity_keys')

  match '/:username/bookmarks' => 'bookmarks#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "clients#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  # Catch everything else and give it to the error controller
  match '*a', :to => 'errors#routing', :as => 'error'

end
