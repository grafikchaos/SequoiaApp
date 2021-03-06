SequoiaApp::Application.routes.draw do

  # Customizing paths for devise.
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => 'logout' }, :controllers => { :sessions => 'sessions' }
  
  resources :clients, :shallow => true, :except => 'index' do
    resources :projects, :except => 'show'
    resources :entities, :except => 'show'
    resources :notes, :except => 'show'
  end

  # Entity row value replacement
  get '/ajax/entity_row_value/:entity_row_id' => 'entities#show_value', :as => 'entity_row_value'
  
  resources :favorites, :except => 'show'

  # Administration for entity types and keys
  scope "/admin" do
    resources :entity_types, :entity_keys, :users, :except => 'show'
    resources :audits, :only => ['index', 'create']
    resources :roles
  end
  match '/admin' => redirect('/admin/entity_keys')
  match '/admin/users/:user_id/unlock' => 'users#unlock', :as => 'user_unlock'
  get '/account' => 'users#edit', :as => 'my_account'

  get '/search' => 'search#results', :as => 'search_results'

  # switch user route
  match 'switch_user' => 'switch_user#set_current_user'

  # Our root URL is mapped to the search controller
  root :to => "search#start"
  
  # Versions
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  # Catch everything else and give it to the error controller
  match '*a', :to => 'errors#routing', :as => 'error'
  
end
