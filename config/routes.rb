Ashint::Application.routes.draw do

  # Customizing paths for devise.
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => 'logout' }
  
  resources :clients, :shallow => true, :except => 'index' do
    resources :projects, :has_many => :notes, :except => 'show'
    resources :entities, :has_many => :notes, :except => 'show'
  end
  
  resources :favorites, :except => 'show'

  # Administration for entity types and keys
  scope "/admin" do
    resources :entity_types, :entity_keys, :users, :except => 'show'
  end
  match '/admin' => redirect('/admin/entity_keys')

  # Our root URL is mapped to the search controller
  root :to => "search#start"
  match '/search' => 'search#results', :as => 'search_results'
  
  # Catch everything else and give it to the error controller
  match '*a', :to => 'errors#routing', :as => 'error'
  
end
