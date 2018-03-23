AlbumClub::Application.routes.draw do
  resources :tracks

  resources :albums
  get '/' => 'albums#index'
  root to: 'albums#index'
  get 'auth/twitter/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
end
