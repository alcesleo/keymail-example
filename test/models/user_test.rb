require 'test_helper'

describe User do

  it 'must have an email' do
    user = Factory.build :user, email: nil

    user.must_be :invalid?
    user.errors[:email].must_be :present?
  end
end
