Rails.application.routes.draw do
  root to: 'home#index'
 
  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    get 'users/change_password', to: 'registrations#change_password', as: 'user_change_password'
    get 'users/cancel_account', to: 'registrations#cancel_account', as: 'user_cancel_account'
  end

  get 'profile', to: 'home#profile', as: 'profile'
  match 'configure', to: 'home#configure', via: [:get, :post], as: 'configure'
end
