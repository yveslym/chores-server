class V1::ChoresController < ApplicationController
  #Before we perform any of the functions inside the array, set the global variable @v1_chore
  #right now we're not using this
  # before_action :set_v1_chore, only: [:show, :update, :destroy]

  # GET /v1/chores
  #Index returns all the chores of a certain group, or of a certain user
  def index

      if (current_user.present? && params[:chore_type] == "group")
          #set global var to all the chores where the group id is equal to the id in our body
          @v1_chore = Chore.where(group_id: v1_chore_params[:group_id], completed: false)
          render :index, status: :ok

    elsif (current_user.present? && params[:chore_type] == "user")
        @v1_chore = V1::Chore.where(user_id: v1_chore_params[current_user.id])
        render :index_user, status: :ok
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
    #get the current group of the logged in user
    #.where returns an array, even if there's only one value
    #In Ruby, the params function can access the path, the url params, or the body for the needed value
    group = current_user.groups.where(id: params[:group_id]).first
    #The .build method is a built in method of ruby where we can add to a collection without saving it just yet
    #So we're adding a new Chore to the chores collection in our postico db without saving it yet
    @v1_chore = group.chores.build(v1_chore_params)
    @v1_chore.completed = false
    @v1_chore.assigned = false
    @v1_chore.pending = false
    @v1_chore.groupname = group.name
    if @v1_chore.save
      render :create, status: :created
    else
      render json: @v1_chore.errors, status: :unprocessable_entity

    end
  end

  # PATCH/PUT example route: /v1/groups/1/chores/1
  def update
    #Finding the specific chore where the id matches the one we pass in with the body
    @v1_chore = Chore.where(id: params[:id]).first
    #Here we're checking if we have user_id in our body, and if we do, we'll change the selected chore's properties
    #with the parameters of the body, we go through the specific group to our specific chore with the path
    if v1_chore_params[:user_id]
      @v1_chore.user_id = params[:user_id]
      @v1_chore.assigned = true
      if @v1_chore.save
        render :show, status: :ok
      end
    else
      render json: @v1_chore.errors, status: :unprocessable_entity
    end
  end

  # DELETE example route: /v1/groups/:group_id/chores/:id
  def destroy
    @v1_chore = Chore.where(id: params[:id])
    if @v1_chore.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  def completed_user_chores
    @v1_chore ||= []
     current_user.groups.each do |group|
       group.chores.each do |chore|

          if chore.user_id == current_user.id && chore.completed == true
            @v1_chore << chore
        end
       end
    end
    #render json is basically the return value, in this case, return @v1_chore as json
    render json: @v1_chore, status: :ok
  end

  # GET /v1/group/{:group_id}/chores/users
  def user_chores
    @v1_chore ||= []
     current_user.groups.each do |group|
       group.chores.each do |chore|

          if chore.user_id == current_user.id && chore.completed == false
            @v1_chore << chore
        end
       end
    end
    #render json is basically the return value, in this case, return @v1_chore as json
    render json: @v1_chore, status: :ok
  end



  # GET /v1/group/{:group_id}/chores/groups
  def group_chores

    group = current_user.groups.where(id: params[:group_id]).first
    @v1_chore ||= []
    group.chores.each do |chore|
      if chore.completed == false
        @v1_chore << chore
      end
    end
    byebug
    render :index, status: :ok
  end

  def completed_group_chores

    group = current_user.groups.where(id: params[:group_id]).first
    @v1_chore ||= []
    group.chores.each do |chore|
      if chore.completed == true
        @v1_chore << chore
      end
    end
    render :index, status: :ok
  end

  '''method to assign chores to a user
    find the specific group from the params'''
  def assign_chore
    group = Group.where(id: params[:group_id])
    #
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
   if user.chores.where(id: params[:id]).destroy
     head(:ok)
   else
     head(:unprocessable_entity)
   end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_chore
      #@v1_chore = current_user.groups.chores
    end

    # Only allow a trusted parameter "white list" through.
    def v1_chore_params
      params.permit(:name, :id, :due_date, :completed, :assigned, :reward, :penalty, :user_id, :group_id)

    end
end
