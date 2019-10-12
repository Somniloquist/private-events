class EventsController < ApplicationController
  def index
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      Invitation.new(user_id: current_user.id, event_id: @event.id, accepted: true).save
      redirect_to @event
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.accepted_invitations
  end
end

private
  def event_params
    params.require(:event).permit(:title, :date, :location, :description)
  end
