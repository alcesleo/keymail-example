require 'test_helper'

describe 'Authentication Integration' do

  it 'only shows the login prompt when logged out' do
    visit root_path
    page.must_have_selector '#email'
    page.wont_have_selector '#message_text'
  end

  it 'only shows the message input when logged in' do
    log_in
    visit root_path
    page.must_have_selector '#message_text'
    page.wont_have_selector '#email'
  end

end
