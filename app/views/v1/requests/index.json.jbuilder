
json.array! @v1_request do |request|
    # group = Group.where(id: request.group_id).first
    # byebug

json.partial! 'v1/requests/request', request: request

end
