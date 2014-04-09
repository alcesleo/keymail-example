require 'test_helper'

describe MessagesController do

  it 'should set posts' do
    get :index
    assigns(:messages).wont_be_nil
  end

  it 'should place new messages first' do
    last = Factory :message, created_at: 10.minutes.ago
    first = Factory :message

    get :index
    assigns(:messages).must_equal [first, last]
  end
end
