class MessagesController < ApplicationController

  # TODO: authentication

  def index
    @messages = Message.order(created_at: :desc).page(params[:page])
    @new_message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user = User.where(email: 'NOT A REAL USER').first_or_create # FIXME: use current_user

    if @message.save
      flash[:notice] = 'Message successfully posted!'
    else
      # TODO: should use real error messages, but there really isn't much else that can happen
      flash[:error] = 'Message cannot be empty.'
    end
    redirect_to root_path
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
