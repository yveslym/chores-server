class V1::RequestsController < ApplicationController

    def index
        @v1_request = Request.where(reciever_id: current_user.id)
        if @v1_request != nil
            render json: @v1_request
        else

        end
    end
    # function to fetch all recieve invitation
    def show
    end

    # function to add or reject request
    def update
        req = Request.where(id: params[:id]).first
        # response = RequestHelper.create_request(req)
        # response.save

        if req.chores?
            self.chore_request
        elsif req.groups?
            #self.group_request

        elsif req.friends?

        else
            head(:unprocessable_entity)
        end
    end

    #function to create new request
    def create
        if current_user == nil
            head(:unprocessable_entity)
        end
        
        if User.where(id: params[:reciever_id]).first && Group.where(id: v1_requests_params[:group_id]).first
        @v1_request = Request.new(sender_id: current_user.id,reciever_id: v1_requests_params[:reciever_id],
            group_id: v1_requests_params[:group_id],request_type: v1_requests_params[:request_type],
            chore_id: v1_requests_params[:chore_id])
        if @v1_request.save
            head(:ok)
        else
            head(:unprocessable_entity)
            end
        else
            head(:unprocessable_entity)
        end
    end
private
# function to handle friend request
def friend_request

end

# function to handle group request
def group_request
    if v1_requests_params[:response] == :true
        # user = User.where(id: v1_requests_params[:reciever_id]).first
        group = Group.where(id: v1_requests_params[:group_id]).first
        group.users << current_user
        if group.save
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    else
        self.delete
    end
end

#function to hamdle chore request
def chore_request
    if v1_requests_params[:response] == true
        user = User.find(id: v1_requests_params[:reciever_id])
        chore = Chore.find(id: v1v1_requests_params[:chore_id])
        chore.user_id = reciever_id
        chore.assigned = :true
        if chore.save
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    else
        self.delete
    end
end

def v1_requests_params
  params.permit(:sender_id,:reciever_id, :group_id,
      :chore_id, :user_id, :request_type,:response, :user_email, :user_token)
    end
 end
