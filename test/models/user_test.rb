require 'test_helper'

describe User do

  it 'must have an email' do
    user = Factory.build :user, email: nil

    user.must_have_invalid :email
  end

  it 'must have a unique email' do
    Factory.create :user, email: 'duplicate@example.com'
    duplicate = Factory.build :user, email: 'duplicate@example.com'

    duplicate.must_have_invalid :email
  end
end
