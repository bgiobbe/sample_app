class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :no_user,        only: [:new, :create]

  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /user/:id
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  # GET /user/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # GET /users/:id/edit
  def edit
    # @user is set in before_action
  end

  # PATCH /users/:id
  # PUT /users/:id
  def update
    # @user is set in before_action
    if @user.update_attributes(user_params)
      # handle a successful update
      flash[:success] = 'Profile updated'
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /user/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User record destroyed."
    redirect_to users_url
  end
  
private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Before filters

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def no_user
    redirect_to root_url if signed_in?
  end
end
