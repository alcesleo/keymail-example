require 'test_helper'

describe MessagesController do
  context '#index' do
    it 'assigns messages' do
      get :index
      assigns(:messages).wont_be_nil
    end

    it 'assigns new_message' do
      get :index
      assigns(:new_message).wont_be_nil
    end

    it 'places new messages first' do
      last = Factory :message, created_at: 20.minutes.ago
      first = Factory :message

      get :index
      assigns(:messages).first.must_equal first
      assigns(:messages).last.must_equal last
    end
  end

  context '#create' do
    it 'creates a message' do
      -> { post :create, message: { text: 'Texty text' } }.must_change 'Message.count', +1
    end

    it 'redirects to root on success' do
      post :create, message: Factory.attributes_for(:message)
      assert_redirected_to root_path
    end

    it 'shows error on fail' do
      skip
      # TODO: implement error messages
      post :create, message: Factory.attributes_for(:message, text: '')
    end

    it 'sets the current user on the message'
  end

  context '#delete' do
    it 'deletes a message' do
      message = Factory :message
      -> { delete :destroy, id: message.id }.must_change 'Message.count', -1
    end

    it 'only deletes owned messages'
  end
end
