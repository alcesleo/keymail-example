class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  before_create :generate_auth_token

  def generate_auth_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end
end
