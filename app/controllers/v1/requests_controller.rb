class V1::RequestsController < ApplicationController

    def index
        #byebug
        @v1_request = Request.where(reciever_id: current_user.id)
        render json: @v1_request, status: :ok
    # if (current_user != nil)
    #     if @v1_request = Request.where(reciever_id: current_user.id)
    #         render json: @v1_request, status: :ok
    #     else
    #         render json: @v1_request.errors, status: :unprocessable_entity
    #     end
    # else
    #         render head(:unprocessable_entity)
    #     end
    end
    # function to fetch all recieve invitation
    def show
    end

    # function to add or reject request
    def update
        req = Request.find(params[:id])

        if req.chores? && req.chore_request(v1_requests_params).save
            req.destroy

            head(:ok)

        elsif req.groups? && req.group_request(v1_requests_params).save
            req.destroy
            head(:ok)

        elsif req.friends? && req.friend_request(v1_requests_params).save
            req.destroy
            head(:ok)

        else
            head(:unprocessable_entity)
        end
    end

    #function to create new request
    def create
        # if current_user == nil
        #     head(:unprocessable_entity)
        # end

        if (User.where(id: params[:reciever_id]).first != nil) && (Group.where(id: v1_requests_params[:group_id]).first != nil)
        @v1_request = Request.new(sender_id: current_user.id,reciever_id: v1_requests_params[:reciever_id],
            group_id: v1_requests_params[:group_id],request_type: v1_requests_params[:request_type],
            chore_id: v1_requests_params[:chore_id], group_name: v1_requests_params[:group_name])



        if @v1_request.save
            render json: @v1_request, status: :created
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



#function to hamdle chore request


def v1_requests_params
  params.permit(:sender_id,:reciever_id, :group_id,
      :chore_id, :user_id, :request_type,:response,
      :user_email, :user_token,:username, :id, :group_name)
    end
 end
