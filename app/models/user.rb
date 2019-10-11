class User < ApplicationRecord
  has_many :events, foreign_key: "creator_id"
  has_many :invitations
  has_many :attended_events, through: :invitations, source: :event

  def attend(event)
    event.invitations.build(user_id: self.id).save
  end

  def upcoming_events
    self.attended_events.where("date >= ?", Time.now)
  end

  def past_events
    self.attended_events.where("date < ?", Time.now)
  end
end
