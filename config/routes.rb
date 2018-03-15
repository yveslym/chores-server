Rails.application.routes.draw do
  devise_for :users
#adds v1/ then the rest of the path
namespace :v1, defaults: { format: :json }  do
resources :requests
 # only: [:create, :index, :update]
#if its resource, and not resources, there won't be id associated with the path
resource :sessions, only: [:create, :destroy,:show, :update]
resources :groups do
    resources :chores
end

post 'new_account/' => 'sessions#new_account'
#Route for sending out chore_completion requests for all users in the current group
post 'chore_completion_request/' => 'requests#chore_completion_request'
#Route for fetching all the group requests
get 'fetch_group_requests/' => 'requests#fetch_group_requests'
#Route for fetching all the chore completion requests
get 'fetch_chore_completion_requests/' => 'requests#fetch_chore_completion_requests'

#chores routes
#For getting User in progress chores
 get 'chores/user/' => 'chores#user_chores'
 #Get User completed chores
 get 'completed_chores/user/' => 'chores#completed_user_chores'
 get 'chores/:group_id/group/' => 'chores#group_chores'
 get 'groups/:group_id/completed_chores/' => 'chores#completed_group_chores'
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 #patch routes
 patch 'groups/:id/user/' => 'groups#remove_member'
#only create routes for things inside the array
end
end
