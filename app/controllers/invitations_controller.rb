class InvitationsController < ApplicationController
  def new
  end

  def create
    @event = Event.find(event_params[:event_id])
    @user = User.find_by(invitation_params)
    if @user && @event
      @event.invite @user
      redirect_to @event
    else
      render :new
    end
  end

  private
    def event_params
      params.require(:event).permit(:event_id)
    end

    def invitation_params
      params.require(:invitation).permit(:name)
    end

end
