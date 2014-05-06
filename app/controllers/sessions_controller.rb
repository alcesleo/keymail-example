class SessionsController < ApplicationController

  def send_keymail
    Keymail::Authentication.request(params[:email])
    redirect_to root_path
  end

  def verify_link
    result = Keymail::Authentication.verify_url_key(params[:url_key])

    if result.authenticated?
      login_or_register_user(result.email)
      flash[:notice] = 'Successfully logged in'
      redirect_to root_path
    else
      flash[:error] = 'Login failed'
      redirect_to root_path
    end
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
