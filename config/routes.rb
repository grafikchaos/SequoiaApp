SequoiaApp::Application.routes.draw do

  # Customizing paths for devise.
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => 'logout' }, :controllers => { :sessions => 'sessions' }
  
  resources :clients, :shallow => true, :except => 'index' do
    resources :projects, :except => 'show'
    resources :entities, :except => 'show'
  end
  
  resources :favorites, :except => 'show'

  # Administration for entity types and keys
  scope "/admin" do
    resources :entity_types, :entity_keys, :users, :except => 'show'
    resources :audits, :only => 'index'
  end
  match '/admin' => redirect('/admin/entity_keys')
  match '/admin/users/:user_id/unlock' => 'users#unlock', :as => 'user_unlock'
  match '/account' => 'users#edit', :as => 'my_account'

  match '/search' => 'search#results', :as => 'search_results'

  # Our root URL is mapped to the search controller
  root :to => "search#start"
  
  
  # Versions
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  
  # Catch everything else and give it to the error controller
  match '*a', :to => 'errors#routing', :as => 'error'
  
end
