class V1::RequestsController < ApplicationController

    #Function for fetching only the chore completion requests
    def fetch_chore_completion_requests
      @v1_request ||= []
      all_requests = Request.where(reciever_id: current_user.id)
      all_requests.each do |request|
        if request.group_name == nil
          @v1_request << request
        end
      end
      render json: @v1_request, status: :ok
    end

    #Function for fetching only the group requests
    def fetch_group_requests
      @v1_request ||= []
      all_requests = Request.where(reciever_id: current_user.id)
      all_requests.each do |request|
        if request.group_name != nil
          @v1_request << request
        end
      end
      render json: @v1_request, status: :ok
    end

    def index
        #byebug
        @v1_request = Request.where(reciever_id: current_user.id)
        render :index, status: :ok
    end


    # function to fetch all recieve invitation
    def show
    end

    # function to add or reject request
    def update
        req = Request.find(params[:id])

        #Checks the type of request and also that our request function succeeded and saved,
        #if both is true, we'll destroy that request.
        #chore_request is to assign chores
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

    ''' function to send chore completion to all users of same group'''
    def chore_completion_request
      chore = Chore.where(id: params[:chore_id]).first
      group = Group.where(id: chore.group_id).first

      group.users.each do |user|
          @v1_request = Request.new(sender_id: current_user.id,reciever_id: user.id,
          request_type: v1_requests_params[:request_type],
            chore_id: v1_requests_params[:chore_id])
        if @v1_request.save
            head(:ok)
        else
            head(:unprocessable_entity)
            end
        end
    end

    #function to create new request
    def create
        # if current_user == nil
        #     head(:unprocessable_entity)
        # end

        #Can params be fulfilled through the headers as well?
        #Checks the receiver and group id parameter to see if they exist
        #Then create a new Request with parameters through the body, including group id and receiver id
        if (User.where(id: v1_requests_params[:reciever_id]).first != nil) && (Group.where(id: v1_requests_params[:group_id]).first != nil)
        @v1_request = Request.new(sender_id: current_user.id,reciever_id: v1_requests_params[:reciever_id],
            group_id: v1_requests_params[:group_id],request_type: v1_requests_params[:request_type],
            chore_id: v1_requests_params[:chore_id], group_name: v1_requests_params[:group_name])

        if @v1_request.save
            render json: @v1_request, status: :created
        else
            head(:unprocessable_entity)
        end
      end
    end



private
# function to handle friend request
def friend_request

end



def v1_requests_params
  params.permit(:sender_id,:reciever_id, :group_id,
      :chore_id, :user_id, :request_type,:response,
      :user_email, :user_token,:username, :id, :group_name)
    end
 end
