Ideia::Application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'
  root to: "index#index"

  resources :journals

  resources :adoptions do
    member do
          get "journal"
    end
   end

  resources :categories do
    member do
      get "theories"
    end
  end

  resources :admins

  resources :users

  resources :theories do
     member do
          get "adopt"
          get "abandon"
    end
   end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  #get
  get 'theories/adopted'
  get 'users/validated'
  get 'index/index'
  get 'index/about'
  get 'users/message_return'
  get 'login/login'
  get 'login/logout'
  #post
  post 'login/login'
  post 'login/logout'
  post 'register/new'
  post '/vote/:theory_id/:vote' => 'votes#vote'
  post '/favorite/:theory_id/' => 'favorites#check'
  post '/theories/search' => 'theories#search'

  match 'entrar' => 'login#login'
  match 'sair' => 'login#logout'
  match '/users/:token/confirm' => 'users#confirm'
  match '/users/:id/send' => 'users#sendMail'
  match '/adoptions/new/:theory' => 'adoptions#new'
  match '/journals/new/:id' => 'journals#new'
  match '*a', to: 'errors#routing'

end
