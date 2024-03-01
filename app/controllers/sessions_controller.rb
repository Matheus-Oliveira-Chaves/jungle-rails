class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username]
    password = params[:password]

    if admin_credentials?(username, password)
      session[:admin_user] = true
      redirect_to admin_dashboard_path, notice: 'Logged in as admin!'
    else
      user = User.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: 'Logged in successfully!'
      else
        flash.now.alert = 'Invalid email or password'
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out.'
  end

  private

  def admin_credentials?(username, password)
    username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
  end
end