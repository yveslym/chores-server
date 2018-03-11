
#getting the specific group that was passed in
json.call(group, :id, :name, :image_file)

#Adding the chores param to the group
json.chores group.chores do |chore|
    json.partial! 'v1/chores/chore', chore: chore
end

#Adding the users inside the group
json.members group.users do |user|
  json.partial! 'v1/users/user', user: user
  json.call(user, :id,:email, :first_name, :last_name, :username, :image_file)
end
