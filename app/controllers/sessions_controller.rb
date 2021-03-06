class SessionsController < ApplicationController
  # GET /signin
  def new
    @user = User.new
  end

  # POST /sessions
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # DELETE /signout
  def destroy
    sign_out
    redirect_to root_url
  end
end
