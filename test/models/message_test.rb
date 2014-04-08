require 'test_helper'

describe Message do

  it 'must have text' do
    message = Factory.build :message, text: ''
    message.must_have_invalid :text
  end

  it 'must belong to a user' do
    message = Factory.build :message, user: nil
    message.must_have_invalid :user
  end

end
