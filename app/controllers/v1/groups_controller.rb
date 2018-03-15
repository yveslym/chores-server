class V1::GroupsController < ApplicationController
  before_action :set_v1_group, only: [:show, :update, :destroy]

  # GET /v1/groups
  def index
     if @v1_group = current_user.groups

    render :index, status: :ok
    else
        render json: @v1_group.errors, status: :unprocessable_entity
    end
  end

  # GET /v1/groups/1
  def show
    @v1_group = current_user.group.where(id: params[:id]).first
    if  @v1_group != nil
      render json: @v1_group, status: :ok
    else
      render json: @v1_group.errors, status: :unprocessable_entity
    end

  end

  # POST /v1/groups
  def create
    #Build the new group with group params and put the new group in the groups collection of User
    @v1_group = current_user.groups.build(v1_group_params)
    #set the new group's user_id to the user thats logged in, basically the creator
    @v1_group.user_id = current_user.id
    #add in the current user to the new group's list of members
    @v1_group.users << current_user
    if @v1_group.save
      #current_user.group_id = @v1_group.id
      current_user.save
      render json: @v1_group, status: :created
    else
      render json: @v1_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH - delete the targeted member from current group
  # /v1/groups/:id
  #Handle what happens when the last person of a group leaves it
  def remove_member
    @v1_group = current_user.groups.where(id: params[:id]).first
    user = @v1_group.users.where(id: params[:user_id])
    @v1_group.users.delete(user)
    @v1_group.save

    user_chores = Chore.where(user_id: params[:user_id], group_id: params[:id])
    user_chores.each do |chore|
      chore.destroy
    end
    user_requests = Request.where(sender_id: params[:user_id], group_id: params[:id])
    user_requests.each do |request|
      request.destroy
    end
    head(:ok)
  end

  # PATCH/PUT /v1/groups/1
  def update
    group = Group.where(id: params[:id])
    if group.update(v1_group_params)
      render json: group
    else
      render json: group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/groups/1
  def destroy
    @v1_group = current_user.groups.where(id: params[:id]).first
    if @v1_group.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_group
      @v1_group = current_user.groups
    end

    # Only allow a trusted parameter "white list" through.
    def v1_group_params
     params.permit(:name, :image_file)
    end
end
