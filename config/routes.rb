Rails.application.routes.draw do
  devise_for :users
#adds v1/ then the rest of the path
namespace :v1, defaults: { format: :json }  do
#only create routes for things inside the array
resources :requests
 # only: [:create, :index, :update]
#if its resource, and not resources, there won't be id associated with the path
resource :sessions, only: [:create, :destroy,:show, :update]
resources :groups do
    resources :chores
end
end
 post 'v1/new_account/' => 'v1/sessions#new_account'
 #Route for sending out chore_completion requests for all users in the current group
 post 'v1/chore_completion_request/' => 'v1/requests#chore_completion_request'
 #Route for fetching all the group requests
 get 'v1/fetch_group_requests/' => 'v1/requests#fetch_group_requests'
 #Route for fetching all the chore completion requests
 get 'v1/fetch_chore_completion_requests/' => 'v1/requests#fetch_chore_completion_requests'

 #chores routes
 #For getting User in progress chores
  get 'v1/chores/user/' => 'v1/chores#user_chores'
  #Get User completed chores
  get 'v1/completed_chores/user/' => 'v1/chores#completed_user_chores'
  get 'v1/chores/:group_id/group/' => 'v1/chores#group_chores'
  get 'v1/groups/:group_id/completed_chores/' => 'v1/chores#completed_group_chores'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
