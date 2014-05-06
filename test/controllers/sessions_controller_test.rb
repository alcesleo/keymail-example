require 'test_helper'

describe SessionsController do

  context '#send_keymail' do
    before do
      ActionMailer::Base.deliveries.clear
      get :send_keymail, { email: 'test@email.com' }
    end

    it 'sends an email' do
      ActionMailer::Base.deliveries.last.wont_be_nil
    end

    it 'redirects to root' do
      assert_redirected_to root_path
    end
  end

end
