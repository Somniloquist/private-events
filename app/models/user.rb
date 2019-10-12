class User < ApplicationRecord
  has_many :events, foreign_key: "creator_id"
  has_many :invitations
  has_many :attended_events, through: :invitations, source: :event

  def attend(event)
    event.invitations.build(user_id: self.id).save
  end

  def upcoming_events
    Event.joins(:attendees).where( invitations: { accepted: true, user_id: self.id } ).where("date >= ?", Time.now)
  end

  def past_events
    Event.joins(:attendees).where( invitations: { accepted: true, user_id: self.id } ).where("date <= ?", Time.now)
  end
end
