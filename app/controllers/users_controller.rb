class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  # GET /user/:id
  def show
    @user = User.find(params[:id])
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

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters

  def signed_in_user
    store_location
    redirect_to signin_url, notice: 'Please sign in.' unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
