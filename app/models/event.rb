class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :invitations
  has_many :attendees, through: :invitations, source: :user

  def self.upcoming
    self.where("date >= ?", Time.now)
  end

  def self.past
    self.where("date < ?", Time.now)
  end
end
