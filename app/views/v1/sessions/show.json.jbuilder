json.partial! 'v1/sessions/user', user: @v1_user
json.group @v1_user.groups do |group|
    json.partial! 'v1/groups/group', group: group
end
