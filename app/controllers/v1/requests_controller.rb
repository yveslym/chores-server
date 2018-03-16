class V1::RequestsController < ApplicationController

    #Function for fetching only the chore completion requests
    def fetch_chore_completion_requests

     @v1_request = Request.where(reciever_id: current_user.id, group_id: v1_requests_params[:group_id])
     if @v1_request != nil
      render json: @v1_request, status: :ok
  else
      render json: @v1_request.error, status: :unprocessable_entity
  end
    end

    '''Function for fetching only the group requests'''
    def fetch_group_requests
        @v1_request =  Request.where.not(group_name: nil).where(reciever_id: current_user.id)
        if @v1_request != nil
            @v1_request.map {|request| request.request_type = 0}
         render json: @v1_request, status: :ok
        else
         render json: @v1_request.error, status: :unprocessable_entity
        end
       end

    '''Function to check if validate or reject request'''
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
        elsif req.completion? && req.chore_completion_confirmation(v1_requests_params).save
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    end

    ''' function to send chore completion to all users of same group'''
    def chore_completion_request
      chore = Chore.where(id: params[:chore_id]).first
      chore.pending = true
      chore.save
      group = Group.where(id: chore.group_id).first
      uuid = SecureRandom.uuid
      group.users.each do |user|
        if current_user.id != user.id
          receiver_user = current_user
          @v1_request = Request.new(sender_id: current_user.id,reciever_id: user.id,
          request_type: v1_requests_params[:request_type],
            chore_id: v1_requests_params[:chore_id], group_id: chore.group_id, uuid: uuid,
          username: receiver_user.username, chore_name: chore.name)

          if @v1_request.save
            head(:ok)
        else
            head(:unprocessable_entity)
            end
        end
      end
    end

    #function to create new request
    def create

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
      :user_email, :user_token,:username, :id, :group_name, :uuid)
    end
 end
