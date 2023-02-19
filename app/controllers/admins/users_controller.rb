class Admins::UsersController < ApplicationController
  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    #
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render :json => @users }
    # end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admins_users_path, notice: "User was successfully created." }
        format.json { render :index, status: :created, location: [:admins, @user] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admins_users_path, notice: "User was successfully updated." }
        format.json { render :index, status: :ok, location: [:admins, @user] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admins_users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end

    # @user = User.find(params[:id])
    # if @user.destroy
    #   flash[:notice] = "User was successfully destroyed."
    #   redirect_to admins_users_path
    # end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :name, :address, :phone_number, :credit_card_number)
  end
end