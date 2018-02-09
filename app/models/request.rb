class Request < ApplicationRecord
    enum request_type: [:groups, :chores, :friends]
end
