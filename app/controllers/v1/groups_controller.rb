class V1::GroupsController < ApplicationController
  before_action :set_v1_group, only: [:show, :update, :destroy]

  # GET /v1/groups
  def index
    render json: Group.where(id: current_user.id), status: :ok
    #render :index, status: :ok
  end

  # GET /v1/groups/1
  def show
    @v1_group = current_user.group.where(id: params[:id]).first
    if  @v1_group != nil
      render json: group, status: :ok
    else
      render json: @v1_group.errors, status: :unprocessable_entity
    end

  end

  # POST /v1/groups
  def create
      #byebug
    @v1_group = current_user.groups.build(v1_group_params)
    @v1_group.user_id = current_user.id
    @v1_group.users << current_user
    if @v1_group.save
      #current_user.group_id = @v1_group.id
      current_user.save
      render json: @v1_group, status: :created
    else
      render json: @v1_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/groups/1
  def update
    if @v1_group.update(v1_group_params)
      render json: @v1_group
    else
      render json: @v1_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/groups/1
  def destroy
    @v1_group = current_user.groups.where(id: params[:id])
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
     params.permit(:name, :id)
    end
end
