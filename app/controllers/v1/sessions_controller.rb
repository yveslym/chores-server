class V1::SessionsController < ApplicationController

def show
    if params[:username] != nil
      @v1_user = User.where(username: params[:username]).first
      @v1_user ? (render :show, status: :ok) : head(:unauthorized)
    else
      @v1_user = current_user
      @v1_user ? (render :show, status: :ok) : head(:unauthorized)

end
end

  # POST /v1/sessions
  def create

    @v1_user = User.where(email: params[:email]).first
    if @v1_user&.valid_password?(params[:password])
        render :create, status: :created
    else
        head(:unauthorized)

    end
  end

  def new_account

    @user = User.new(v1_sessions_params)
    if @user.save
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  # DELETE /v1/sessions/1
  def destroy

    current_user&.authentication_token = nil
    if current_user.save

        head(:ok)
    else
        head(:unauthorized)
    end
  end

  def update
      @v1_user = current_user
      if v1_sessions_params[:first_name] != nil
           @v1_user.first_name = v1_sessions_params[:first_name]
      elsif v1_sessions_params[:last_name] != nil
          @v1_user.last_name = v1_sessions_params[:last_name]
      elsif v1_sessions_params[username] != nil
          @v1_user.username = v1_sessions_params[:username]
    end

    if @v1_user.save
        render json: :update, status: :ok
    else
        render json: @v1_user.erros, status: :unprocessable_entity
  end
end

private

def set_v1_chore
  @user = current_user
end


def nilify_token
  current_user&.authentication_token = nil
end

def v1_sessions_params
      params
      .require(:email, :password)
      .permit(:email,:password, :password_confirmation,:first_name, :last_name,:username)
end

end
