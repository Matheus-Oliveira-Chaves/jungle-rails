class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email]
    password = params[:password]

    if admin_credentials?(email, password)
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

  def admin_credentials?(email, password)
    email == ENV['ADMIN_EMAIL'] && password == ENV['ADMIN_PASSWORD']
  end
end