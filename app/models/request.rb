class Request < ApplicationRecord
    enum request_type: [:groups, :chores, :friends]
    #The functions below are what happens before a specific request is deleted, it handles
    # the logic of what accepting the request does

    #function to respond to a chore_completion_request
    def chore_completion_request (v1_requests_params)
      #Here we just want to change the specific chore's completion property to true
      @chore = Chore.find(v1_requests_params[:chore_id])
      @chore.completed = :true
      @chore
    end

    #ASSIGN CHORE
    def chore_request(v1_requests_params)
            user = User.find(v1_requests_params[:reciever_id])
            @chore = Chore.find(v1_requests_params[:chore_id])
            #@chore.user_id = user.id
            user.chores << @chore
            @chore.assigned = :true
            @chore
    end
    # function to handle group request
    def group_request (v1_requests_params)

            req = Request.find(v1_requests_params[:id])
            @group = Group.where(id: v1_requests_params[:group_id]).first
            user = User.find(req.reciever_id)
            if v1_requests_params[:response]
             @group.users << user
            end
            @group
    end

end
