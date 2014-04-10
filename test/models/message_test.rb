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

  it 'sorts newest first' do
    last = Factory :message, created_at: 20.minutes.ago
    first = Factory :message
    Message.newest_first.must_equal [first, last]
  end

end
