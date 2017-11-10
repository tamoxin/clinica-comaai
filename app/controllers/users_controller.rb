class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  skip_before_action :require_professor, :require_admin, :require_coordinator
  # before_action :not_available, only: [:destroy]
  # before_action :coord_or_admin, only: [:new, :create, :index]
  # before_action :is_owner, only: [:show, :edit, :update]




  # GET /users
  # GET /users.json
  def index
    if admin?
      @users = User.all
    elsif coordinator?
      @users = User.where.not(userType: 'admin').where.not(userType: 'coordinator').all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if coordinator?
      if params[:user][:userType] == 'admin' || params[:user][:userType] == 'coordinator'
           redirect_to new_user_path, notice: 'Action forbidden.'
      end
    end
        @user = User.new(user_params)

        respond_to do |format|
          if @user.save
            format.html { redirect_to @user, notice: 'User was successfully created.' }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :userType, :firstName, :lastName, :email, :phone, :active)
    end

  # def coord_or_admin
  #   unless coordinator? || admin?
  #     if professor?
  #       redirect_to courses_path
  #     elsif student?
  #       redirect_to groups_path
  #     end
  #   end
  # end
  #
  # def is_owner
  #   unless admin?
  #     user = User.find(params[:id])
  #     if user.userType == 'admin'
  #       redirect_to users_path
  #     elsif user.userType == 'coordinator' && current_user.id != user.id
  #       redirect_to users_path
  #     elsif current_user.id != user.id
  #       unless coordinator?
  #         redirect_to root_path
  #       end
  #     end
  #   end
  # end
  #
  # def not_available
  #   redirect_to users_path
  # end

end
