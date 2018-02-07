class V1::RequestController < ApplicationController

    # function to fetch all recieve invitation
    def index
        @v1_request = Request.where(reciever_id: current_user.id)
        if @v1_request != nil
            render json: @v1_request
        else

        end
    end

    #function to create new request
    def create
        if User.where(id: params[:reciever_id]).first & Group.where(id: params[:group_id]).first
        @v1_request = Request.new(sender_id: current_user.id,reciever_id: params[:reciever_id],group_id: params[:group_id],request_type: params[:request_type])
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

def v1_sessions_params
  params.permit(:sender_id,:reciever_id, :group_id, :chore_id, :user_id, :request_type)
    end
 end
