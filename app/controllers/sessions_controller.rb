class SessionsController < ApplicationController

  def send_keymail
    Keymail::Authentication.request(params[:email])
    redirect_to root_path
  end

end
