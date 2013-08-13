class SessionsController < ApplicationController

  # GET /signin
  def new
  end

  # POST /sessions
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      # Sign the user in and redirect to the user's show page
      sign_in user
      redirect_to user
    else
      # Create an error message and re-render the sign-in form
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  # DELETE /signout
  def destroy
    sign_out
    redirect_to root_url
  end

end
