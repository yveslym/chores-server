class Request < ApplicationRecord
    enum request_type: [:groups, :chores, :friends, :completion]
    #The functions below are what happens before a specific request is deleted, it handles
    # the logic of what accepting the request does

    #function to respond to a chore_completion_request
    def chore_completion_confirmation(v1_requests_params)
      #Here we just want to change the specific chore's completion property to true
      @chore = Chore.find(v1_requests_params[:chore_id])

      if v1_requests_params[:response] == true
        @chore.completed = true
        @chore.pending = false
        delete_requests = Request.where(uuid: v1_requests_params[:uuid])
        delete_requests.each do |request|
          request.destroy
        end
      else

        request = Request.where(id: v1_requests_params[:id]).first
        request.destroy
        pending_request = Request.where(uuid: v1_requests_params[:uuid])
        if pending_request.any? == false
              @chore.pending = false
              @chore.user_id = nil
              @chore.assigned = false     
        end
      end
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
