class Request < ApplicationRecord
    enum request_type: [:groups, :chores, :friends]
    #ASSIGN CHORE
    def chore_request(v1_requests_params)
            user = User.find(v1_requests_params[:reciever_id])
            @chore = Chore.find(v1_requests_params[:chore_id])
            #@chore.user_id = user.id
            users.chores << @chore
            @chore.assigned = :true
            @chore
    end
    # function to handle group request
    def group_request (v1_requests_params)

            req = Request.find(v1_requests_params[:id])
            @group = Group.where(id: v1_requests_params[:group_id]).first
            user = User.find(req.reciever_id)
            @group.users << user
            @group
    end

end
