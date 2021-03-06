require 'test_helper'

describe SessionsController do

  it 'handles not being able to send emails' do
    Keymail::Authentication.stubs(:request).raises
    post :send_keymail, { email: 'test@email.com' }
    flash[:error].wont_be_nil
    flash[:notice].must_be_nil
    assert_redirected_to root_path
  end

  context 'sending emails' do
    before do
      ActionMailer::Base.deliveries.clear
      post :send_keymail, { email: 'test@email.com' }
    end

    it 'sends an email' do
      ActionMailer::Base.deliveries.last.wont_be_nil
    end

    it 'redirects to root' do
      assert_redirected_to root_path
    end

    it 'sets a flash on success' do
      flash[:notice].wont_be_nil
      flash[:error].must_be_nil
    end
  end


  context 'logging in via link' do

    let(:email) { 'text@email.com' }
    let(:url_key) { Keymail::Authentication.request(email).url_key } # FIXME: ugly..

    it 'creates the user if it does not exist' do
      -> { get :verify_link, { url_key: url_key } }.must_change 'User.count', +1
    end

    it 'does not create a user if it exists' do
      user = Factory :user, email: email
      -> { get :verify_link, { url_key: url_key } }.wont_change 'User.count'
    end

    context 'successful login' do

      before do
        get :verify_link, { url_key: url_key }
      end

      it 'sets a cookie' do
        cookies[:auth_token].wont_be_nil
      end

      # from ApplicationController
      it 'has the current_user' do
        @controller.current_user.email.must_equal email
      end

      it 'redirects to root with a flash on login success' do
        assert_redirected_to root_path
        flash[:success].wont_be_nil
      end

    end

    context 'unsuccessful login' do
      before do
        get :verify_link, { url_key: 'invalid' }
      end

      it 'redirects to root with a flash on failure' do
        assert_redirected_to root_path
        flash[:error].wont_be_nil
      end
    end
  end

  context 'logging out' do
    it 'logs out the user' do
      log_in
      get :log_out
      cookies[:auth_token].must_be_nil
    end
  end
end
