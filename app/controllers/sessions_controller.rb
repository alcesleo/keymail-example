class SessionsController < ApplicationController

  def send_keymail
    Keymail::Authentication.request(params[:email])
    flash[:notice] = "An email has been sent to #{params[:email]}, click the link in the email to log in."
    redirect_to root_path
  end

  def verify_link
    result = Keymail::Authentication.verify_url_key(params[:url_key])

    if result.authenticated?
      login_or_register_user(result.email)
      flash[:success] = 'Successfully logged in'
      redirect_to root_path
    else
      flash[:error] = 'Login failed'
      redirect_to root_path
    end
  end

  def log_out
    cookies.delete(:auth_token)
    flash[:notice] = 'Logged out successfully'
    redirect_to root_path
  end

  private

  def login_or_register_user(email)
    user = User.where(email: email).first_or_create
    persist_login(user)
  end

  def persist_login(user)
    cookies.permanent[:auth_token] = user.auth_token
  end
end
