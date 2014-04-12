class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :text

  delegate :email, to: :user, prefix: true

  scope :newest_first, -> { order(created_at: :desc) }

end
