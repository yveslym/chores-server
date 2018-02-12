
json.call(
    group, :id, :name,
)
    json.chores group.chores do |chore|
        json.partial! 'v1/chores/chore', chore: chore
    end
json.members group.users do |user|
json.call(user, :id,:email, :first_name, :last_name, :username)
end
