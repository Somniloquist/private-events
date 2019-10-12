class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :invitations
  has_many :attendees, through: :invitations, source: :user

  def invite(user)
    self.invitations.build(user_id: user.id).save unless invitation_exists(user)
  end

  # returns a relations containing all users who accepted their event invite
  def accepted_invitations
    User.joins(:attended_events).where( invitations: { accepted: true, event_id: self.id } )
  end

  def self.upcoming
    self.where("date >= ?", Time.now)
  end

  def self.past
    self.where("date < ?", Time.now)
  end

  private
    def invitation_exists(user)
      !Invitation.where(event_id: self.id, user_id: user.id).empty?
    end
end
