class InvitationsController < ApplicationController
  def new
  end

  def create
    @event = Event.find(event_params[:event_id])
    @user = User.find_by(invitation_params)
    if @user && @event
      @event.invite @user
    end
    redirect_to @event
  end

  def destroy
    invitation = Invitation.find invitation_params[:id]
    invitation.delete if current_user == invitation.user
    redirect_to current_user
  end

  def accept
    invitation = Invitation.find invitation_params[:id]
    current_user.accept invitation if current_user == invitation.user
    redirect_to current_user
  end

  private
    def event_params
      params.require(:event).permit(:event_id)
    end

    def invitation_params
      params.require(:invitation).permit(:id, :name)
    end

end
