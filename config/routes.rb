Ideia::Application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'

  resources :votes

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

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  post "register/new"
  get "index/index"
  get "users/message_return"
  get "login/login"
  post "login/login"
  get "login/logout"
  post "login/logout"
  get 'users/validated'
  get 'theories/adopted'

  match "entrar" => "login#login"
  match "sair" => "login#logout"
  root to: "index#index"

  resources :theories do
     member do
          get "adopt"
          get "abandon"
    end
   end

  resources :users
  match '/users/:token/confirm' => 'users#confirm'
  match '/users/:id/send' => 'users#sendMail'
  match '/adoptions/new/:theory' => 'adoptions#new'
  match '/journals/new/:id' => 'journals#new'
  match '*a', to: 'errors#routing'

end
