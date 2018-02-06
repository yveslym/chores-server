json.data do
    json.user do
        json.call(
            byebug
            @user,
            :email,
            :authentication_token
        )
    end
end
