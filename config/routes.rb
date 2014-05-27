Prognozi::Application.routes.draw do
  root :to => 'predictions#index'

  devise_for :users

  match '/predictions'     => 'predictions#index', via: :get
  match '/match_prediction' => 'predictions#match',  via: :post
  match '/group_prediction' => 'predictions#group',  via: :post

  # match '/decline_invitation'           => 'rooms#room_inv_decline',   via: :post
  # match '/accept_invitation'            => 'rooms#room_inv_accept',    via: :post
  # match '/roominvites/:room_id/:uids'   => 'rooms#invite',             via: :get
  match '/newroom'                      => 'rooms#new',                via: :get
  match '/createroom'                   => 'rooms#create',             via: :post
  match '/rooms'                        => 'rooms#index',              via: :get
  match '/rooms/:room_id'               => 'rooms#show',               via: :get, as: :room

  #Facebook auth

  # match 'auth/:provider/callback', to: 'sessions#oauth_success'
  # match 'auth/failure', to: redirect('/')

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
