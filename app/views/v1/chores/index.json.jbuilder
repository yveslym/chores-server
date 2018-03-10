json.array! @v1_chore do |each_chore|

    json.partial! 'v1/chores/chore', chore: each_chore
    # add user
    user = User.where(id: each_chore.user_id).first
    if user.present?
    json.user do
        json.partial! 'v1/sessions/user', user: user
        end
    else
json.user  nil
    end
end
