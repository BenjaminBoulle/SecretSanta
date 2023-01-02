class ParticipantsController < ApplicationController
  before_action :set_event, only: %i[new create]

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.event = @event
    if @participant.save
      redirect_to event_path(@event)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :email)
  end
end
