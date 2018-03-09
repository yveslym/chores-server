#This method uses a jbuilder object, then uses the .call method to return to us an object that has
# the specified parameters
json.call(
    chore,
    :id,
    :name,
    :penalty,
    :due_date,
    :reward,
    :completed,
    :assigned,
    :user_id
    :image_file
)

# json.image_file do
#   json.partial! 'v1/users/user', user: current_user
#   json.call(user, :id,:email, :first_name, :last_name, :username)
# end
