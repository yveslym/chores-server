Rails.application.routes.draw do
  devise_for :users

namespace :v1, defaults: { format: :json }  do
resources :requests
resource :sessions, only: [:create, :destroy,:show]
resources :groups do
    resources :chores
end
end
 post 'v1/new_account/' => 'v1/sessions#new_account'

 #chores routes
  get 'v1/chores/:group_id/user/' => 'v1/chores#user_chores'
get 'v1/chores/:group_id/group/' => 'v1/chores#group_chores'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
