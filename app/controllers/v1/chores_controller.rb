class V1::ChoresController < ApplicationController
  before_action :set_v1_chore, only: [:show, :update, :destroy]

  # GET /v1/chores
  def index

      if (current_user != nil) && (params[:chore_type] == "group")

          @v1_chore = Chore.where(group_id: v1_chore_params[:group_id])
          render json: @v1_chore, status: :created

    elsif current_user && (params[:chore_type] == "user")
        @v1_chore = Chore.where(user_id: v1_chore_params[current_user.id])
        render json: @v1_chore, status: :created
    else
    render json: @v1_chore.errors, status: :unprocessable_entity

    end
end

  # GET /v1/chores/1
#   def show
#     render json: @v1_chore
#   end
# end

  # POST /v1/chores
  def create

    group = current_user.groups.where(id: params[:group_id]).first
    @v1_chore = group.chores.build(v1_chore_params)
    @v1_chore.completed = false
    @v1_chore.assigned = false
    if @v1_chore.save
      render :create, status: :created

    else
      render json: @v1_chore.errors, status: :unprocessable_entity

    end
  end

  # PATCH/PUT /v1/chores/1
  def update

    @v1_chore = Chore.where(id: params[:id])
    if @v1_chore.update(v1_chore_params)
      render json: @v1_chore
    else
      render json: @v1_chore.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/chores/1
  def destroy
    @v1_chore = Chore.where(id: params[:id])
    if @v1_chore.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  # GET /v1/group/{:group_id}/chores/users
  def user_chores
    @v1_chore = current_user.groups
    render json: @v1_chore
  end
  # GET /v1/group/{:group_id}/chores/groups
  def group_chores

    group = current_user.groups.where(id: params[:group_id]).first
    @v1_chore = group.chores
    render :index, status: :ok
  end

  # POST /v1/groups/{:group_id}/chores/assign/user{id}
  def assign_chore
    #method to assign chores to a user
    group = Group.where(id: params[:group_id])
   user = group.users.where(id: params[:user_id])
    user.chore_id = params[:id]
  #end
      if user.save
        head(:ok)
      else
        head(:unprocessable_entity)
  end
  end
  # DELETE /v1/groups/{:id}/chores/{:id}
  def unassign_chore
    group = current_user.groups.where(id: params[:group_id])
    user = group.users.where(id: params[:user_id])

    chore = Chore.where(id: params[:id])
    chore.user_id = nil
    chore.save
   if  user.chores.where(id: params[:id]).destroy
     head(:ok)
   else
     head(:unprocessable_entity)
   end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_chore
      @v1_chore = current_user.groups.chores
    end

    # Only allow a trusted parameter "white list" through.
    def v1_chore_params
      params.permit(:name, :id, :due_date, :completed, :assigned, :reward, :penalty, :user_id, :group_id, :chore_type)

    end
end
