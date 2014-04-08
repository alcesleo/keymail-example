require 'test_helper'

describe User do

  it 'has an email' do
    user = Factory.build :user, email: nil

    user.must_be :invalid?
    user.errors[:email].must_be :present?
  end

  it 'has a unique email' do
    Factory.create :user, email: 'duplicate@example.com'
    duplicate = Factory.build :user, email: 'duplicate@example.com'

    duplicate.must_be :invalid?
    duplicate.errors[:email].must_be :present?
  end
end
