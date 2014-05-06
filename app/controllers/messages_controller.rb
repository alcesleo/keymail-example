class MessagesController < ApplicationController

  before_filter :authorize!, except: [:index]

  def index
    @messages = Message.newest_first.page(params[:page])
    @new_message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user

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
