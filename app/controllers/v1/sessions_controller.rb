class V1::SessionsController < ApplicationController


def show
    current_user ? head(:ok) : head(:unauthorized)
end

  # POST /v1/sessions
  def create
    @user = User.where(email: params[:email]).first
    if @user&.valid_password?(params[:password])
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

private

def set_v1_chore
  @user = current_user
end


def nilify_token
  current_user&.authentication_token = nil
end
def v1_sessions_params
  params.permit(:email,:password, :password_confirmation)
end
 end
