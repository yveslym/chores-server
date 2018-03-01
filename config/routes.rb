Rails.application.routes.draw do
  devise_for :users
#adds v1/ then the rest of the path
namespace :v1, defaults: { format: :json }  do
#only create routes for things inside the array
resources :requests, only: [:create, :index, :update]
#if its resource, and not resources, there won't be id associated with the path
resource :sessions, only: [:create, :destroy,:show]
resources :groups do
    resources :chores
end
end
 post 'v1/new_account/' => 'v1/sessions#new_account'

 #chores routes
  get 'v1/chores/user/' => 'v1/chores#user_chores'
get 'v1/chores/:group_id/group/' => 'v1/chores#group_chores'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
