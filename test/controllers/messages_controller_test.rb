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
      # created in this order to make sure it fails if Message.all is used
      last = Factory :message, created_at: 20.minutes.ago
      first = Factory :message

      get :index
      assigns(:messages).must_equal [first, last]
    end
  end

  context '#create' do

    it 'creates a message' do
      -> { post :create, message: { text: 'Texty text' } }.must_change 'Message.count', +1
    end

    it 'flashes when posting a message' do
      post :create, message: { text: 'A message' }
      assert_redirected_to root_path
      flash[:notice].wont_be_nil
    end

    it 'flashes error on fail' do
      post :create, message: { text: '' }
      assert_redirected_to root_path
      flash[:error].wont_be_nil
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
