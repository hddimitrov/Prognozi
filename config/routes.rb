Prognozi::Application.routes.draw do
  root :to => 'predictions#index'

  devise_for :users, only: [:sessions]

  as :user do
    post 'users/sign_up' => 'devise/registrations#create', as: :new_user_registration
  end

  match '/predictions'     => 'predictions#index',   via: :get
  match '/match_prediction' => 'predictions#match',  via: :post
  match '/group_prediction' => 'predictions#group',  via: :post
  match '/top_scorer_prediction' => 'predictions#top_scorer',  via: :post

  match '/load_group_stage' => 'predictions#load_group_stage',  via: :get

  match '/load_knockout_stage' => 'predictions#load_knockout_stage',  via: :get
  match '/save_knockout_stage' => 'predictions#save_knockout_stage',  via: :post

  match '/standings'     => 'participants#ranking',   via: :get
  match '/rules'     => 'participants#rules',   via: :get

  # match '/decline_invitation'           => 'rooms#room_inv_decline',   via: :post
  # match '/accept_invitation'            => 'rooms#room_inv_accept',    via: :post
  # match '/roominvites/:room_id/:uids'   => 'rooms#invite',             via: :get
  # match '/newroom'                => 'rooms#new',      via: :get
  # match '/createroom'             => 'rooms#create',   via: :post
  # match '/rooms'                  => 'rooms#index',    via: :get
  # match '/rooms/:room_id'         => 'rooms#show',     via: :get, as: :room

  #Facebook auth

  # match 'auth/:provider/callback', to: 'sessions#oauth_success'
  # match 'auth/failure', to: redirect('/')

  match '/dev'     => 'predictions#dev',   via: :get
  match '/points'  => 'predictions#points',   via: :get

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
