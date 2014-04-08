require 'test_helper'

describe User do

  it 'has an email' do
    user = Factory.build :user, email: nil
    user.must_have_invalid :email
  end

  it 'has a unique email' do
    Factory.create :user, email: 'duplicate@example.com'

    duplicate = Factory.build :user, email: 'duplicate@example.com'
    duplicate.must_have_invalid :email
  end
end
